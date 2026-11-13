import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/bills_fees_use_cases.dart';
import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_controller.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../flows/flow_harness.dart' show flowParser;
import '../../setup/screens/screen_harness.dart';

/// [text] as `MoneyFormatter` writes it: a no-break space after K.
String k(String text) => text.replaceAll('K ', 'K\u00a0');

/// A proof message in the synthetic test format (AGENTS.md §5).
String sent(String kwacha, String ref) =>
    'TEST SENT K$kwacha TO acc ****4521 REF $ref AT 2026-10-25 08:21';

void main() {
  late ProviderContainer c;
  late Payday payday;
  late FakeNotificationsApi notifications;
  String path() => c.read(routerProvider).state.uri.path;

  Future<void> start(WidgetTester tester, {FakeClock? clock}) async {
    notifications = FakeNotificationsApi();
    c = ProviderContainer(
      overrides: [
        ...fakePortOverrides(clock: clock, notifications: notifications),
        smsParserProvider.overrideWithValue(flowParser),
      ],
      retry: retryUnlessFailure,
    );
    addTearDown(c.dispose);
    (await seedDemo(c)).orThrow();
    (await c.read(completeSetupProvider)()).orThrow();
    payday = (await c.read(paydayRepositoryProvider).getAll()).orThrow().single;
    await pumpApp(tester, c);
    c.read(routerProvider).go(Routes.payday(payday.id));
    await settleStreams(tester);
  }

  Future<Transfer> transferFor(BucketKind kind) async {
    final all = (await c.read(bucketRepositoryProvider).getAll()).orThrow();
    final bucket = all.firstWhere((b) => b.kind == kind);
    return payday.transfers.firstWhere((t) => t.bucketId == bucket.id);
  }

  Future<void> openProof(WidgetTester tester, String bucket) async {
    await tapOn(tester, find.widgetWithText(BkTransferRow, bucket));
    await settleStreams(tester);
    expect(path(), contains('/proof/'));
  }

  Future<void> paste(WidgetTester tester, String text) async {
    await tester.enterText(
      find.descendant(
        of: find.byType(BkSmsField),
        matching: find.byType(TextField),
      ),
      text,
    );
    await tester.pump();
  }

  Future<void> check(WidgetTester tester) async {
    await tapOn(tester, find.widgetWithText(BkButton, l.proofCheck));
    await settleStreams(tester);
  }

  Finder badge(String bucket, String label) => find.descendant(
    of: find.widgetWithText(BkTransferRow, bucket),
    matching: find.text(label),
  );

  group('13 Payday transfer fees (R-FEE-5)', () {
    testWidgets('with a saved rate: fee per transfer and a total note', (
      tester,
    ) async {
      await start(tester);
      (await c.read(saveFeeBandProvider)(
        provider: AlertSource.mtnMomo,
        feeType: FeeType.send,
        min: Money.zero,
        max: const Money.kwacha(5000),
        fee: const Money.kwacha(5),
      )).orThrow();
      c.invalidate(paydayControllerProvider(payday.id));
      await settleStreams(tester);
      expect(find.textContaining(k('fee ~ K 5')), findsNWidgets(4));
      expect(find.text(l.paydayFeesNote(k('K 20'))), findsOneWidget);
    });

    testWidgets('no rate saved: no fee text', (tester) async {
      await start(tester);
      expect(find.textContaining('fee'), findsNothing);
    });
  });

  group('13 Payday transfers', () {
    testWidgets('open: 4 to prove, K 3,850 left, snooze until 20:00', (
      tester,
    ) async {
      await start(tester);
      expect(find.text(l.paydayDate('25 Oct')), findsOneWidget);
      expect(find.text(l.paydayHeadline), findsOneWidget);
      expect(find.text(l.paydayLeftOf(k('K 3,850'))), findsOneWidget);
      expect(find.text(l.paydayNeedsProof), findsNWidgets(4));
      expect(find.text(l.paydayTo('[SAVINGS ACCOUNT]')), findsNWidgets(4));
      expect(find.text(l.paydayLockNote), findsOneWidget);
      expect(find.text(l.paydaySnooze(1, '20:00')), findsOneWidget);
    });

    testWidgets('snooze used: toast, unlocked note, no snoozes left', (
      tester,
    ) async {
      await start(tester);
      await tapOn(tester, find.text(l.paydaySnooze(1, '20:00')));
      await settleStreams(tester);
      expect(find.text(l.paydaySnoozedUntil('20:00')), findsOneWidget);
      expect(find.text(l.paydayUnlockedNote), findsOneWidget);
      expect(find.text(l.paydaySnoozeLabel), findsOneWidget);
      expect(find.text(l.paydaySnoozeNoneLeft), findsOneWidget);
    });

    testWidgets('after 21:00 snooze is off and says why', (tester) async {
      // 21:30 in Lusaka.
      await start(tester, clock: FakeClock(DateTime.utc(2026, 10, 25, 19, 30)));
      expect(find.text(l.paydaySnoozeLabel), findsOneWidget);
      expect(find.text(l.paydaySnoozeTooLate), findsOneWidget);
    });

    testWidgets('the N-PAYDAY notification opens this screen', (tester) async {
      await start(tester);
      c.read(routerProvider).go(Routes.home);
      await settleStreams(tester);
      final scheduler =
          c.read(notificationSchedulerProvider) as FakeNotificationScheduler;
      final alarm = scheduler.scheduled.firstWhere(
        (n) => n.kind == NotificationKind.payday,
      );
      notifications.tap(alarm.deepLink);
      await settleStreams(tester);
      expect(path(), Routes.payday(payday.id));
      expect(find.text(l.paydayHeadline), findsOneWidget);
    });
  });

  group('14 Prove transfer · passed', () {
    testWidgets('paste from the clipboard, 4 checks pass, row proven', (
      tester,
    ) async {
      await start(tester);
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async => call.method == 'Clipboard.getData'
            ? <String, dynamic>{'text': sent('770.00', 'R1')}
            : null,
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      await openProof(tester, 'Emergency');
      expect(find.text(l.proofTitle), findsOneWidget);
      expect(find.text(l.proofEmpty), findsOneWidget);
      await tapOn(tester, find.text(l.proofPaste));
      await check(tester);
      expect(find.text(l.proofAllPassed), findsOneWidget);
      expect(find.text(k('K 770.00')), findsOneWidget);
      expect(find.text(l.proofReferenceNew), findsOneWidget);
      await tapOn(tester, find.widgetWithText(BkButton, l.done));
      await settleStreams(tester);
      expect(path(), Routes.payday(payday.id));
      expect(badge('Emergency', l.paydayProvenAt('08:00')), findsOneWidget);
      expect(find.text(l.paydayLeftOf(k('K 3,850'))), findsOneWidget);
      expect(find.text(l.paydayNeedsProof), findsNWidgets(3));
    });
  });

  testWidgets('14: the SMS field and Check stay above the keyboard', (
    tester,
  ) async {
    await start(tester);
    await openProof(tester, 'Emergency');
    await paste(tester, sent('770.00', 'K1'));
    tester.view.viewInsets = FakeViewPadding(
      bottom: 300 * tester.view.devicePixelRatio,
    );
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();
    const keyboardTop = 900.0 - 300;
    final field = find.descendant(
      of: find.byType(BkSmsField),
      matching: find.byType(TextField),
    );
    await tester.ensureVisible(field);
    await tester.pumpAndSettle();
    expect(tester.getBottomLeft(field).dy, lessThan(keyboardTop));
    expect(
      tester.getBottomLeft(find.widgetWithText(BkButton, l.proofCheck)).dy,
      lessThan(keyboardTop),
    );
  });

  group('15 Prove transfer · failed', () {
    testWidgets('amount low: banner, 3 of 4, save part and owe the rest', (
      tester,
    ) async {
      await start(tester);
      await openProof(tester, 'Emergency');
      await paste(tester, sent('707.00', 'R2'));
      await check(tester);
      expect(find.text(l.proofFailAmountLowTitle), findsOneWidget);
      expect(find.text(l.proofSomePassed(3)), findsOneWidget);
      expect(
        find.text(l.proofAmountMismatch(k('K 707'), k('K 770'))),
        findsOneWidget,
      );
      expect(find.text(l.proofPartialNote(k('K 63'))), findsOneWidget);
      await tapOn(tester, find.text(l.proofSavePartial(k('K 707'), k('K 63'))));
      await settleStreams(tester);
      expect(path(), Routes.payday(payday.id));
      expect(badge('Emergency', l.paydayOwed(k('K 63'))), findsOneWidget);
    });

    testWidgets('nothing read: try another, then mark as saved', (
      tester,
    ) async {
      await start(tester);
      await openProof(tester, 'Emergency');
      await paste(tester, 'hello');
      await check(tester);
      expect(find.text(l.proofFailUnknownTitle), findsOneWidget);
      expect(find.text(l.proofNotFound), findsNWidgets(4));
      await tapOn(tester, find.widgetWithText(BkButton, l.proofTryAnother));
      expect(find.text(l.proofEmpty), findsOneWidget);
      expect(find.text('hello'), findsNothing);
      await tapOn(tester, find.widgetWithText(BkButton, l.proofMarkSaved));
      await settleStreams(tester);
      expect(path(), Routes.payday(payday.id));
      expect(badge('Emergency', l.paydaySelfReported), findsOneWidget);
    });
  });

  group('16 Payday complete', () {
    testWidgets('the last proof opens 16; Home loses the lock note', (
      tester,
    ) async {
      await start(tester);
      final prove = c.read(proveTransferProvider);
      for (final (i, kind) in [
        BucketKind.longTerm,
        BucketKind.shortTerm,
        BucketKind.goal,
      ].indexed) {
        final t = await transferFor(kind);
        (await prove(
          paydayId: payday.id,
          transferId: t.id,
          text: sent('${t.amount.ngwee ~/ 100}.00', 'P$i'),
        )).orThrow();
      }
      await settleStreams(tester);
      await openProof(tester, 'Emergency');
      await paste(tester, sent('770.00', 'P9'));
      await check(tester);
      await tapOn(tester, find.widgetWithText(BkButton, l.done));
      await settleStreams(tester);
      expect(path(), Routes.paydayDone(payday.id));
      expect(find.text(l.doneMoved(k('K 3,850'))), findsOneWidget);
      expect(find.textContaining(l.doneAllProven(4)), findsOneWidget);
      expect(find.text(l.doneStreakValue(1)), findsOneWidget);
      expect(find.text('Laptop'), findsOneWidget);
      await tapOn(tester, find.widgetWithText(BkButton, l.doneGoHome));
      await settleStreams(tester);
      expect(path(), Routes.home);
      expect(find.text(l.homeLocked), findsNothing);
    });
  });
}
