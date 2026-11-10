import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/home/presentation/screens/home_screen.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../setup/screens/screen_harness.dart';

Future<void> completeSetup(ProviderContainer c) async =>
    (await c.read(completeSetupProvider)()).orThrow();

void main() {
  // The container is made inside each test so the fakes and the widgets
  // share the test's fake-async zone.
  late ProviderContainer c;
  void start() {
    c = fakeContainer();
    addTearDown(c.dispose);
  }

  testWidgets('07 before the first payday: countdown and tiles', (
    tester,
  ) async {
    start();
    (await c.read(firstRunSeedProvider)()).orThrow();
    (await c.read(saveIncomeSourceProvider)(
      name: 'Salary',
      kind: IncomeKind.salary,
      landsInAccountId: 'momo',
      schedule: const MonthlyPay(25),
    )).orThrow();
    await pumpScreen(tester, c, const HomeScreen());
    await settleStreams(tester);
    expect(find.text(l.homeTitleFirstRun), findsOneWidget);
    expect(find.text(l.homePaydayIn(31)), findsOneWidget);
    expect(find.text('25 Nov'), findsOneWidget);
    expect(find.byType(BkBucketTile), findsNWidgets(5));
    expect(find.byType(BkTabBar), findsOneWidget);
    expect(find.byType(BkFab), findsOneWidget);
  });

  testWidgets('08 mid-cycle: canvas numbers, payday banner, locked', (
    tester,
  ) async {
    start();
    (await seedDemo(c)).orThrow();
    await pumpScreen(tester, c, const HomeScreen());
    await settleStreams(tester);
    expect(find.text(money(const Money.kwacha(3080))), findsWidgets);
    expect(find.text(money(const Money.kwacha(770))), findsWidgets);
    expect(find.text(l.homePaydayBanner(4)), findsOneWidget);
    expect(find.text(l.homeLocked), findsOneWidget);
    expect(find.text(l.homeRecentEmpty), findsOneWidget);
  });

  testWidgets('08 payments to sort and a recent payment', (tester) async {
    start();
    (await seedDemo(c)).orThrow();
    final living = (await c.read(bucketRepositoryProvider).getAll())
        .orThrow()
        .firstWhere((b) => b.kind == BucketKind.living)
        .id;
    (await c.read(logCashPaymentProvider)(
      amount: const Money.kwacha(80),
      category: Category.food,
      bucketId: living,
    )).orThrow();
    (await c
            .read(alertRepositoryProvider)
            .save(
              PaymentAlert.create(
                id: 'a1',
                rawText: null,
                source: AlertSource.mtnMomo,
                receivedAt: c.read(clockProvider).now(),
                parsed: ParsedMessage(
                  confidence: 1,
                  direction: MessageDirection.outgoing,
                  amount: const Money.kwacha(185),
                ),
              ).orThrow(),
            ))
        .orThrow();
    await pumpScreen(tester, c, const HomeScreen());
    await settleStreams(tester);
    expect(find.text(l.homeToSort(1)), findsOneWidget);
    expect(find.text('Food'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text(money(const Money.kwacha(-80))), findsOneWidget);
  });

  testWidgets('navigation: tile, banner, FAB, tabs', (tester) async {
    start();
    (await seedDemo(c)).orThrow();
    await completeSetup(c);
    await pumpApp(tester, c);
    String path() => c.read(routerProvider).state.uri.path;
    Future<void> home() async {
      c.read(routerProvider).go(Routes.home);
      await settleStreams(tester);
    }

    await home();
    await tapOn(tester, find.widgetWithText(BkBucketTile, 'Emergency'));
    expect(path(), startsWith('/bucket/'));
    await home();
    await tapOn(tester, find.text(l.homePaydayBanner(4)));
    expect(path(), startsWith('/payday/'));
    await home();
    await tapOn(tester, find.byType(BkFab));
    expect(path(), Routes.log);
    await home();
    await tapOn(tester, find.text(l.tabGoals));
    expect(path(), Routes.goals);
  });
}
