import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/home/presentation/controllers/home_controller.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../setup/screens/screen_harness.dart';

/// A synthetic message format for tests only (AGENTS.md §5).
final SmsParser testParser = SmsParser([
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'test-paid',
    direction: MessageDirection.outgoing,
    pattern: RegExp(
      r'^TEST PAID K(?<amount>[\d,.]+) TO (?<counterparty>.+?) '
      r'REF (?<reference>\w+)$',
    ),
  ),
]);

PaymentAlert alert(String id, String who, int minute) => PaymentAlert.create(
  id: id,
  rawText: null,
  source: AlertSource.mtnMomo,
  receivedAt: DateTime.utc(2026, 10, 25, 6, minute),
  parsed: ParsedMessage(
    confidence: 1,
    direction: MessageDirection.outgoing,
    amount: const Money.kwacha(185),
    counterparty: who,
  ),
).orThrow();

void main() {
  late ProviderContainer c;
  late FakeTextRecognizer ocr;
  late FakeReceiptTextParser receipts;
  late FakeImageCapture camera;
  String path() => c.read(routerProvider).state.uri.path;

  Future<void> start(WidgetTester tester, String location) async {
    ocr = FakeTextRecognizer();
    receipts = FakeReceiptTextParser();
    camera = FakeImageCapture();
    c = ProviderContainer(
      overrides: [
        ...fakePortOverrides(
          textRecognizer: ocr,
          receiptParser: receipts,
          imageCapture: camera,
        ),
        smsParserProvider.overrideWithValue(testParser),
      ],
      retry: retryUnlessFailure,
    );
    addTearDown(c.dispose);
    (await seedDemo(c)).orThrow();
    (await c.read(completeSetupProvider)()).orThrow();
    await pumpApp(tester, c);
    c.read(routerProvider).go(location);
    await settleStreams(tester);
  }

  Money livingLeft() =>
      (c.read(homeControllerProvider).value! as HomeActive).livingLeft;

  group('18 Sort sheet', () {
    testWidgets('pick and file; next pre-filled by the rule; all sorted', (
      tester,
    ) async {
      await start(tester, Routes.home);
      for (final a in [alert('a1', '[SHOP]', 0), alert('a2', '[SHOP]', 1)]) {
        (await c.read(alertRepositoryProvider).save(a)).orThrow();
      }
      c.read(routerProvider).go(Routes.sort);
      await settleStreams(tester);
      expect(find.text(l.sortTitle), findsOneWidget);
      expect(find.text(l.sortPickBoth), findsOneWidget);
      await tapOn(tester, find.widgetWithText(BkChip, 'Food'));
      await tapOn(tester, find.widgetWithText(BkChip, 'Living'));
      await tapOn(tester, find.text(l.sortAlways('[SHOP]')));
      await tapOn(tester, find.text(l.sortFile));
      await settleStreams(tester);
      // The rule pre-fills the second alert: File is ready straight away.
      expect(find.text(l.sortLast), findsWidgets);
      expect(find.text(l.sortPickBoth), findsNothing);
      await tapOn(tester, find.text(l.sortFile));
      await settleStreams(tester);
      expect(find.text(l.sortDoneTitle), findsOneWidget);
      await tapOn(tester, find.text(l.done));
      expect(path(), Routes.home);
    });
  });

  group('19 Log a payment', () {
    testWidgets('cash: K 0 error, then saved with a toast; Living drops', (
      tester,
    ) async {
      await start(tester, Routes.log);
      await tapOn(tester, find.widgetWithText(BkChip, 'Food'));
      await tapOn(tester, find.widgetWithText(BkChip, 'Living'));
      await tapOn(tester, find.widgetWithText(BkButton, l.save));
      expect(find.text(l.errAmount), findsOneWidget);
      await typeAmount(tester, '80');
      await tapOn(tester, find.widgetWithText(BkButton, l.save));
      expect(path(), Routes.home);
      expect(find.text(l.logSaved), findsOneWidget);
      await settleStreams(tester);
      expect(livingLeft(), const Money.kwacha(3000));
    });

    testWidgets('paste: reads the message; big amounts suggest a wish', (
      tester,
    ) async {
      await start(tester, Routes.log);
      await typeAmount(tester, '700');
      await settleStreams(tester);
      expect(find.text(l.logWishTitle), findsOneWidget);
      await tapOn(tester, find.text(l.logPaste));
      await type(tester, l.logMessage, 'TEST PAID K185.00 TO [SHOP] REF Z1');
      expect(find.text('[SHOP]'), findsOneWidget);
      expect(find.text(money(const Money.kwacha(-185))), findsOneWidget);
    });
  });

  group('20–21 Scan and review', () {
    testWidgets('confident receipt → review → saved', (tester) async {
      await start(tester, Routes.scan);
      ocr.text = '[OCR TEXT]';
      receipts.draft = ReceiptDraft(
        total: Scored(const Money.kwacha(300), 0.95),
        items: [ReceiptItem('Bread', const Money.kwacha(300), 0.9)],
      );
      await tapOn(tester, find.bySemanticsLabel(l.scanShutter));
      await settleStreams(tester);
      expect(path(), startsWith('/log/receipt/'));
      expect(find.text(l.receiptItemsMatch), findsOneWidget);
      await tapOn(tester, find.widgetWithText(BkChip, 'Market'));
      await tapOn(tester, find.widgetWithText(BkChip, 'Living'));
      await tapOn(tester, find.widgetWithText(BkButton, l.save));
      expect(path(), Routes.home);
      await settleStreams(tester);
      expect(livingLeft(), const Money.kwacha(2780));
    });

    testWidgets('unsure total: warning, fix it; items off caption', (
      tester,
    ) async {
      await start(tester, Routes.scan);
      ocr.text = '[OCR TEXT]';
      receipts.draft = ReceiptDraft(
        total: Scored(const Money.kwacha(300), 0.4),
        items: [ReceiptItem('Bread', const Money.kwacha(250), 0.9)],
      );
      await tapOn(tester, find.bySemanticsLabel(l.scanShutter));
      await settleStreams(tester);
      expect(find.text(l.receiptCheckTotal), findsOneWidget);
      expect(find.text(l.receiptNotReady), findsOneWidget);
      await typeAmount(tester, '250');
      await tapOn(tester, find.text(l.receiptUseTotal));
      await settleStreams(tester);
      expect(find.text(l.receiptCheckTotal), findsNothing);
      expect(find.text(l.receiptItemsMatch), findsOneWidget);
    });

    testWidgets('no text: banner and retake; permission denied', (
      tester,
    ) async {
      await start(tester, Routes.scan);
      ocr.text = '';
      await tapOn(tester, find.bySemanticsLabel(l.scanShutter));
      await settleStreams(tester);
      expect(find.text(l.scanNoText), findsOneWidget);
      await tapOn(tester, find.text(l.scanRetake));
      expect(find.text(l.scanHint), findsOneWidget);
      camera.denied = true;
      await tapOn(tester, find.bySemanticsLabel(l.scanShutter));
      await settleStreams(tester);
      expect(find.text(l.scanNoCamera), findsOneWidget);
    });
  });
}
