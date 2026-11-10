import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/home/presentation/controllers/plan_controller.dart';
import 'package:buckets/features/home/presentation/screens/goals_screen.dart';
import 'package:buckets/features/home/presentation/screens/plan_screen.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../setup/screens/screen_harness.dart';

String k(String text) => text.replaceAll('K ', 'K\u00a0');

Finder iconButton(String label) => find.byWidgetPredicate(
  (w) => w is BkIconButton && w.semanticLabel == label,
);

void main() {
  late ProviderContainer c;
  late FakeClock clock;

  Future<void> start(WidgetTester tester, String location) async {
    clock = FakeClock(DateTime.utc(2026, 10, 25, 6));
    c = ProviderContainer(
      overrides: fakePortOverrides(clock: clock),
      retry: retryUnlessFailure,
    );
    addTearDown(c.dispose);
    (await seedDemo(c)).orThrow();
    (await c.read(completeSetupProvider)()).orThrow();
    await pumpApp(tester, c);
    c.read(routerProvider).go(location);
    await settleStreams(tester);
  }

  group('10 Goals', () {
    testWidgets('empty: pick something to save for', (tester) async {
      c = fakeContainer();
      addTearDown(c.dispose);
      (await c.read(firstRunSeedProvider)()).orThrow();
      await pumpScreen(tester, c, const GoalsScreen());
      await settleStreams(tester);
      expect(find.text(l.goalsEmptyTitle), findsOneWidget);
      expect(find.text(l.goalsAdd), findsOneWidget);
    });

    testWidgets('ready: stats, the goal card with progress and ETA', (
      tester,
    ) async {
      await start(tester, Routes.goals);
      expect(find.text(l.goalsTitle), findsWidgets);
      expect(find.text(l.goalsSavedSoFar), findsOneWidget);
      expect(find.text(l.goalsSavedThisMonth), findsOneWidget);
      expect(find.text('Laptop'), findsOneWidget);
      expect(find.text(l.goalsOf(k('K 9,000'))), findsOneWidget);
      expect(find.byType(BkProgressBar), findsOneWidget);
      expect(find.textContaining(l.goalsPerMonth(k('K 770'))), findsOne);
    });

    testWidgets('new goal from the sheet; reached goal toasts once', (
      tester,
    ) async {
      await start(tester, Routes.goals);
      await tapOn(tester, iconButton(l.goalsNew));
      await type(tester, l.goalName, 'Phone');
      await typeAmount(tester, '1');
      await tapOn(tester, find.text(l.goalPickAccount));
      await tapOn(tester, find.text('[SAVINGS ACCOUNT]').last);
      await tapOn(tester, find.widgetWithText(BkButton, l.save));
      await settleStreams(tester);
      expect(find.text(l.goalSaved), findsOneWidget);
      expect(find.text('Phone'), findsOneWidget);
      expect(find.text(l.goalsNotInSplit), findsOneWidget);

      final phone = (await c.read(bucketRepositoryProvider).getAll())
          .orThrow()
          .firstWhere((b) => b.name == 'Phone');
      (await c.read(ledgerRepositoryProvider).append([
        LedgerEntry.create(
          id: 'gift',
          occurredAt: clock.now(),
          kind: LedgerEntryKind.adjustment,
          bucketId: phone.id,
          amount: const Money.kwacha(1),
        ).orThrow(),
      ])).orThrow();
      await settleStreams(tester);
      expect(find.text(l.goalsCelebrate('Phone')), findsOneWidget);
      await tester.pump(const Duration(seconds: 4));
      await settleStreams(tester);
      expect(find.text(l.goalsCelebrate('Phone')), findsNothing);
      expect(find.text(l.goalsReached), findsOneWidget);
    });
  });

  group('11 Plan', () {
    testWidgets('empty tabs, then a planned buy to tick off', (tester) async {
      await start(tester, Routes.plan);
      expect(find.text(l.planBuyEmptyTitle), findsOneWidget);
      await tapOn(tester, find.text(l.planWishes));
      expect(find.text(l.planWishEmptyTitle), findsOneWidget);
      await tapOn(tester, find.text(l.planToBuy));
      await tapOn(tester, iconButton(l.planAddBuy));
      await type(tester, l.planItemName, 'Gas refill');
      await typeAmount(tester, '450');
      await tapOn(tester, find.widgetWithText(BkChip, 'Living'));
      await tapOn(tester, find.widgetWithText(BkButton, l.save));
      await settleStreams(tester);
      expect(find.text(l.planAdded), findsOneWidget);
      final row = find.widgetWithText(BkCheckRow, 'Gas refill');
      expect(tester.widget<BkCheckRow>(row).checked, isFalse);
      await tapOn(tester, row);
      await settleStreams(tester);
      expect(tester.widget<BkCheckRow>(row).checked, isTrue);
    });

    testWidgets('wish: timer running, then time up and still want it', (
      tester,
    ) async {
      await start(tester, '${Routes.plan}?tab=wishes');
      await tapOn(tester, iconButton(l.planAddWish));
      await type(tester, l.planItemName, 'Speaker');
      await typeAmount(tester, '700');
      await tapOn(tester, find.widgetWithText(BkChip, 'Short-term'));
      await tapOn(tester, find.widgetWithText(BkButton, l.save));
      await settleStreams(tester);
      expect(find.text(l.planHoursLeft(48)), findsOneWidget);
      expect(find.text(l.planAskAgain(48)), findsOneWidget);
      expect(find.text(l.planChangedMind), findsOneWidget);

      clock.now_ = clock.now_.add(const Duration(hours: 48));
      c.invalidate(planControllerProvider);
      await settleStreams(tester);
      expect(find.text(l.planTimeUp), findsOneWidget);
      await tapOn(tester, find.widgetWithText(BkButton, l.planStillWant));
      await settleStreams(tester);
      expect(find.text(l.planApproved), findsOneWidget);
    });

    testWidgets('wish: changed my mind drops it', (tester) async {
      await start(tester, '${Routes.plan}?tab=wishes');
      await tapOn(tester, iconButton(l.planAddWish));
      await type(tester, l.planItemName, 'Speaker');
      await typeAmount(tester, '700');
      await tapOn(tester, find.widgetWithText(BkChip, 'Short-term'));
      await tapOn(tester, find.widgetWithText(BkButton, l.save));
      await settleStreams(tester);
      await tapOn(tester, find.widgetWithText(BkButton, l.planChangedMind));
      await settleStreams(tester);
      expect(find.text(l.planWishEmptyTitle), findsOneWidget);
    });
  });

  testWidgets('Plan opens on the tab from the link', (tester) async {
    c = fakeContainer();
    addTearDown(c.dispose);
    await pumpScreen(tester, c, const PlanScreen(initialTab: PlanTab.wishes));
    await settleStreams(tester);
    expect(find.text(l.planWishEmptyTitle), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
