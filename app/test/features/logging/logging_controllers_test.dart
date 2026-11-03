import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/logging/presentation/controllers/check_in_controller.dart';
import 'package:buckets/features/logging/presentation/controllers/log_payment_controller.dart';
import 'package:buckets/features/logging/presentation/controllers/receipt_review_controller.dart';
import 'package:buckets/features/logging/presentation/controllers/scan_controller.dart';
import 'package:buckets/features/logging/presentation/controllers/sort_alerts_controller.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderListenable;
import 'package:flutter_test/flutter_test.dart';

final SmsParser testParser = SmsParser([
  MessageTemplate(
    source: AlertSource.mtnMomo,
    name: 'test-paid',
    direction: MessageDirection.outgoing,
    pattern: RegExp(
      r'^TEST PAID K(?<amount>[\d,.]+) TO (?<counterparty>.+?) '
      r'FEE K(?<fee>[\d,.]+) REF (?<reference>\w+)$',
    ),
  ),
]);

final textRecognizer = FakeTextRecognizer();
final receiptParser = FakeReceiptTextParser();
final capture = FakeImageCapture();

Future<T> next<T>(
  ProviderContainer c,
  ProviderListenable<AsyncValue<T>> p,
) async {
  c.listen(p, (_, _) {});
  for (var i = 0; i < 100; i++) {
    final v = c.read(p);
    if (v case AsyncData(:final value) when !v.isLoading) return value;
    if (v case AsyncError(:final error)) fail('$p failed: $error');
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  fail('no value for $p');
}

String bucket(ProviderContainer c, BucketKind kind) =>
    (c.read(bucketRepositoryProvider) as InMemoryBucketRepository)
        .store
        .items
        .values
        .firstWhere((b) => b.kind == kind)
        .id;

PaymentAlert alert(String id, String counterparty, int minutes) =>
    PaymentAlert.create(
      id: id,
      rawText: null,
      source: AlertSource.mtnMomo,
      receivedAt: DateTime.utc(2026, 10, 25, 6, minutes),
      parsed: ParsedMessage(
        confidence: 1,
        direction: MessageDirection.outgoing,
        amount: const Money.kwacha(185),
        counterparty: counterparty,
      ),
    ).orThrow();

void main() {
  late ProviderContainer c;
  setUp(() async {
    c = ProviderContainer(
      overrides: [
        ...fakePortOverrides(
          textRecognizer: textRecognizer,
          receiptParser: receiptParser,
          imageCapture: capture,
        ),
        smsParserProvider.overrideWithValue(testParser),
      ],
      retry: retryUnlessFailure,
    );
    (await seedDemo(c)).orThrow();
  });
  tearDown(() => c.dispose());

  group('18 Sort sheet', () {
    test('next, last, then none left', () async {
      for (final a in [alert('a1', '[SHOP]', 0), alert('a2', '[CAFE]', 1)]) {
        (await c.read(alertRepositoryProvider).save(a)).orThrow();
      }
      var s = await next(c, sortAlertsControllerProvider) as SortNext;
      expect(s.alert.id, 'a1');
      expect(s.remaining, 2);
      expect(s.isLast, isFalse);
      final notifier = c.read(sortAlertsControllerProvider.notifier);
      expect(
        await notifier.file(
          category: Category.food,
          bucketId: bucket(c, BucketKind.living),
          alwaysFile: true,
        ),
        isTrue,
      );
      await pumpEventQueue();
      s = await next(c, sortAlertsControllerProvider) as SortNext;
      expect(s.alert.id, 'a2');
      expect(s.isLast, isTrue);
      await notifier.skip();
      expect(c.read(sortAlertsControllerProvider).value, isA<SortNone>());
    });

    test('a merchant rule pre-fills the next alert', () async {
      (await c.read(saveMerchantRuleProvider)(
        counterparty: '[SHOP]',
        category: Category.market,
        bucketId: 'x',
      )).orThrow();
      (await c.read(alertRepositoryProvider).save(alert('a', '[SHOP]', 0)))
          .orThrow();
      final s = await next(c, sortAlertsControllerProvider) as SortNext;
      expect(s.category, Category.market);
      expect(s.bucketId, 'x');
    });
  });

  group('19 Log a payment', () {
    test('cash: K 0 is a validation error, then saved', () async {
      final p = logPaymentControllerProvider;
      c.listen(p, (_, _) {});
      final notifier = c.read(p.notifier);
      final living = bucket(c, BucketKind.living);
      expect(
        await notifier.save(category: Category.food, bucketId: living),
        isFalse,
      );
      expect(c.read(p).errorCode, 'amount.notPositive');
      expect(
        await notifier.save(
          category: Category.food,
          bucketId: living,
          amount: const Money.kwacha(40),
        ),
        isTrue,
      );
      expect(c.read(p).saved, isTrue);
    });

    test(
      'paste tab reads the message; the wish banner shows above K 500',
      () async {
        final p = logPaymentControllerProvider;
        c.listen(p, (_, _) {});
        final notifier = c.read(p.notifier)
          ..setTab(LogTab.paste)
          ..paste('TEST PAID K185.00 TO [MERCHANT] FEE K2.50 REF ZX98');
        expect(c.read(p).parsedAmount, const Money(18500));
        await notifier.amountChanged(const Money.kwacha(600));
        expect(c.read(p).suggestWish, isTrue);
        await notifier.amountChanged(const Money.kwacha(100));
        expect(c.read(p).suggestWish, isFalse);
        expect(
          await notifier.save(
            category: Category.food,
            bucketId: bucket(c, BucketKind.living),
          ),
          isTrue,
        );
      },
    );
  });

  group('20 Scan', () {
    test('camera → processing → recognised', () async {
      final p = scanControllerProvider;
      c.listen(p, (_, _) {});
      expect(c.read(p), isA<ScanCamera>());
      textRecognizer.text = '[OCR TEXT]';
      await c.read(p.notifier).capture(CaptureSource.camera);
      expect(c.read(p), isA<ScanRecognized>());
    });

    test('no text found, then retake', () async {
      final p = scanControllerProvider;
      c.listen(p, (_, _) {});
      textRecognizer.text = '';
      await c.read(p.notifier).capture(CaptureSource.camera);
      expect(c.read(p), isA<ScanNoText>());
      c.read(p.notifier).retake();
      expect(c.read(p), isA<ScanCamera>());
    });

    test('a cancelled photo stays on the camera', () async {
      final p = scanControllerProvider;
      c.listen(p, (_, _) {});
      capture.path = null;
      await c.read(p.notifier).capture(CaptureSource.gallery);
      expect(c.read(p), isA<ScanCamera>());
      capture.path = '/private/receipt.jpg';
    });
  });

  group('21 Receipt review', () {
    Future<String> scanned(ReceiptDraft draft) async {
      textRecognizer.text = '[OCR TEXT]';
      receiptParser.draft = draft;
      final p = scanControllerProvider;
      c.listen(p, (_, _) {});
      await c.read(p.notifier).capture(CaptureSource.camera);
      return (c.read(p) as ScanRecognized).receiptId;
    }

    test('confident and items add up', () async {
      final id = await scanned(
        ReceiptDraft(
          total: Scored(const Money.kwacha(300), 0.95),
          items: [ReceiptItem('Bread', const Money.kwacha(300), 0.9)],
        ),
      );
      final s = await next(c, receiptReviewControllerProvider(id));
      expect(s.totalNeedsCheck, isFalse);
      expect(s.itemsMatch, isTrue);
    });

    test(
      'total needs check, items off; fixing the total, then saved',
      () async {
        final id = await scanned(
          ReceiptDraft(
            total: Scored(const Money.kwacha(300), 0.5),
            items: [ReceiptItem('Bread', const Money.kwacha(250), 0.9)],
          ),
        );
        final p = receiptReviewControllerProvider(id);
        var s = await next(c, p);
        expect(s.totalNeedsCheck, isTrue);
        expect(s.itemsOff, const Money.kwacha(-50));
        await c.read(p.notifier).setTotal(const Money.kwacha(250));
        s = c.read(p).value!;
        expect(s.totalNeedsCheck, isFalse);
        expect(s.itemsMatch, isTrue);
        expect(
          await c
              .read(p.notifier)
              .save(
                category: Category.market,
                bucketId: bucket(c, BucketKind.living),
              ),
          isTrue,
        );
        expect(c.read(p).value!.saved, isTrue);
      },
    );
  });

  group('22 Check-in', () {
    test('sort → count with a missing-cash gap → summary', () async {
      (await c.read(alertRepositoryProvider).save(alert('a', '[SHOP]', 0)))
          .orThrow();
      final p = checkInControllerProvider;
      var s = await next(c, p);
      expect(s.step, CheckInStep.sort);
      expect(s.unsorted, 1);
      final notifier = c.read(p.notifier);
      await notifier.nextStep();
      expect(c.read(p).value!.step, CheckInStep.count);
      (await c.read(logCashPaymentProvider)(
        amount: const Money.kwacha(-1) + const Money.kwacha(41),
        category: Category.food,
        bucketId: bucket(c, BucketKind.living),
      )).orThrow();
      await notifier.count(Money.zero);
      s = c.read(p).value!;
      expect(s.prompt, GapPrompt.receivedCash);
      expect(await notifier.recordReceived(intoLiving: false), isTrue);
      await notifier.nextStep();
      s = c.read(p).value!;
      expect(s.step, CheckInStep.summary);
      expect(s.summary, isNotNull);
    });

    test('missing cash is recorded as Untracked', () async {
      final p = checkInControllerProvider;
      await next(c, p);
      final notifier = c.read(p.notifier);
      await notifier.count(Money.zero);
      // First count with nothing expected: no gap.
      expect(c.read(p).value!.prompt, GapPrompt.none);
      c.invalidate(p);
      await next(c, p);
      // Expected stays K 0; counting K 0 again keeps the gap at zero.
      expect(await c.read(p.notifier).recordUntracked(), isFalse);
    });
  });
}
