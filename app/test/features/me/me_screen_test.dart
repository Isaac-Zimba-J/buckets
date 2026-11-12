import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
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

import '../setup/screens/screen_harness.dart';

String k(String text) => text.replaceAll('K ', 'K\u00a0');

/// A phone with a screen lock; the test decides if unlocking works.
final class TestAppLock implements AppLock {
  TestAppLock({this.available = true});

  final bool available;
  bool unlocks = true;

  @override
  Future<Result<bool>> isAvailable() async => Ok(available);

  @override
  Future<Result<bool>> authenticate() async => Ok(unlocks);
}

void main() {
  late ProviderContainer c;
  late FakeClock clock;
  String path() => c.read(routerProvider).state.uri.path;
  Future<Settings> settings() async =>
      (await c.read(settingsRepositoryProvider).get()).orThrow();

  Future<void> start(
    WidgetTester tester, {
    AppLock? lock,
    bool locked = false,
  }) async {
    clock = FakeClock(DateTime.utc(2026, 10, 25, 6));
    c = ProviderContainer(
      overrides: fakePortOverrides(clock: clock, appLock: lock),
      retry: retryUnlessFailure,
    );
    addTearDown(c.dispose);
    (await seedDemo(c)).orThrow();
    (await c.read(completeSetupProvider)()).orThrow();
    if (locked) {
      final s = (await settings()).copyWith(appLock: true).orThrow();
      (await c.read(settingsRepositoryProvider).save(s)).orThrow();
    }
    await pumpApp(tester, c);
    c.read(routerProvider).go(Routes.me);
    await settleStreams(tester);
  }

  Future<void> switchOf(WidgetTester tester, String title) => tapOn(
    tester,
    find.descendant(
      of: find.widgetWithText(BkToggleRow, title),
      matching: find.byType(Switch),
    ),
  );

  Future<void> goto(WidgetTester tester, String route) async {
    c.read(routerProvider).go(route);
    await settleStreams(tester);
  }

  testWidgets('Me hub links to money, rules, settings, support', (
    tester,
  ) async {
    await start(tester);
    for (final (label, route) in [
      (l.meIncomeSources, Routes.meIncome),
      (l.meBills, Routes.meBills),
      (l.meBucketsAccounts, Routes.meAccounts),
      (l.meRules, Routes.meRules),
      (l.meSettings, Routes.meSettings),
      (l.meHelp, Routes.help),
      (l.meReport, Routes.helpReport),
      (l.meAboutApp, Routes.meAbout),
    ]) {
      await goto(tester, Routes.me);
      await tapOn(tester, find.text(label));
      expect(path(), route);
    }
    await goto(tester, Routes.me);
    await tapOn(tester, find.text(l.meSplitOf('Salary')));
    expect(path(), startsWith('/me/split/'));
  });

  testWidgets('Security: app lock on with a screen lock', (tester) async {
    await start(tester, lock: TestAppLock());
    await goto(tester, Routes.meSecurity);
    await switchOf(tester, l.meAppLock);
    await settleStreams(tester);
    expect((await settings()).appLock, isTrue);
  });

  testWidgets('Security: no screen lock disables the toggle', (tester) async {
    await start(tester, lock: TestAppLock(available: false));
    await goto(tester, Routes.meSecurity);
    expect(find.text(l.securityNoLock), findsOneWidget);
    final row = tester.widget<BkToggleRow>(
      find.widgetWithText(BkToggleRow, l.meAppLock),
    );
    expect(row.onChanged, isNull);
  });

  testWidgets('Settings: payday and spending settings are saved', (
    tester,
  ) async {
    await start(tester);
    await goto(tester, Routes.meSettings);
    await tapOn(tester, find.widgetWithText(BkSegmented<int>, '2'));
    await tapOn(tester, find.text(l.meHours(72)));
    await switchOf(tester, l.meAutoFile);
    await settleStreams(tester);
    final s = await settings();
    expect((s.snoozeLimit, s.coolingOffHours, s.autoFile), (2, 72, true));
  });

  testWidgets('Data & privacy: clear alert history', (tester) async {
    await start(tester);
    await goto(tester, Routes.meData);
    await tapOn(tester, find.text(l.dataClearAlerts));
    await tester.pumpAndSettle();
    await tapOn(tester, find.widgetWithText(BkButton, l.dataClearAlerts));
    await settleStreams(tester);
    expect(path(), Routes.meData);
  });

  testWidgets('Rules: add a category', (tester) async {
    await start(tester);
    await goto(tester, Routes.meRules);
    await tapOn(tester, find.text('+ ${l.rulesAdd}'));
    await type(tester, l.rulesCategoryName, 'Snacks');
    await tapOn(tester, find.widgetWithText(BkButton, l.save));
    await settleStreams(tester);
    expect(find.text('Snacks'), findsOneWidget);
  });

  testWidgets('Rules: delete a saved merchant rule', (tester) async {
    await start(tester);
    await tester.runAsync(() async {
      (await c
              .read(merchantRuleRepositoryProvider)
              .save(
                MerchantRule(
                  id: 'r1',
                  merchantKey: MerchantKey.create('Shoprite').orThrow(),
                  category: Category.food,
                  bucketId: 'living',
                ),
              ))
          .orThrow();
    });
    await goto(tester, Routes.meRules);
    expect(find.text('shoprite'), findsOneWidget);
    await tapOn(
      tester,
      find.descendant(
        of: find.ancestor(
          of: find.text('shoprite'),
          matching: find.byType(BkListRow),
        ),
        matching: find.byType(BkIconButton),
      ),
    );
    await settleStreams(tester);
    expect(find.text('shoprite'), findsNothing);
  });

  testWidgets('locked at launch; unlock; locks again after a minute away', (
    tester,
  ) async {
    final lock = TestAppLock();
    await start(tester, lock: lock, locked: true);
    expect(find.text(l.lockTitle), findsOneWidget);
    lock.unlocks = false;
    await tapOn(tester, find.widgetWithText(BkButton, l.lockUnlock));
    expect(find.text(l.lockTitle), findsOneWidget);
    lock.unlocks = true;
    await tapOn(tester, find.widgetWithText(BkButton, l.lockUnlock));
    await settleStreams(tester);
    expect(find.text(l.lockTitle), findsNothing);

    Future<void> away(Duration d) async {
      [
        AppLifecycleState.inactive,
        AppLifecycleState.hidden,
        AppLifecycleState.paused,
      ].forEach(tester.binding.handleAppLifecycleStateChanged);
      clock.now_ = clock.now_.add(d);
      [
        AppLifecycleState.hidden,
        AppLifecycleState.inactive,
        AppLifecycleState.resumed,
      ].forEach(tester.binding.handleAppLifecycleStateChanged);
      await settleStreams(tester);
    }

    await away(const Duration(seconds: 30));
    expect(find.text(l.lockTitle), findsNothing);
    await away(const Duration(minutes: 1));
    expect(find.text(l.lockTitle), findsOneWidget);
  });
}
