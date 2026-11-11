import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/setup/presentation/screens/accounts_screen.dart';
import 'package:buckets/features/setup/presentation/screens/bills_screen.dart';
import 'package:buckets/features/setup/presentation/screens/income_screen.dart';
import 'package:buckets/features/setup/presentation/screens/permissions_screen.dart';
import 'package:buckets/features/setup/presentation/screens/profile_screen.dart';
import 'package:buckets/features/setup/presentation/screens/split_screen.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'screen_harness.dart';

Future<String> salaryId(ProviderContainer c) async =>
    (await c.read(incomeRepositoryProvider).getAll())
        .orThrow()
        .firstWhere((i) => i.kind == IncomeKind.salary)
        .id;

void main() {
  late ProviderContainer c;
  setUp(() => c = fakeContainer());
  tearDown(() => c.dispose());

  testWidgets('01b shows the form: name, greeting, continue', (tester) async {
    await tester.runAsync(() async => (await seedDemo(c)).orThrow());
    await pumpScreen(tester, c, const ProfileScreen());
    expect(find.text(l.profileName), findsOneWidget);
    expect(find.text(l.profileGreeting), findsOneWidget);
    expect(find.text(l.greetingMuliShani), findsWidgets);
    expect(find.text(l.profileCurrencyValue), findsOneWidget);
    // Continue is enabled with no name entered (R-PROFILE-2).
    final button = tester.widget<BkButton>(
      find.widgetWithText(BkButton, l.continueLabel),
    );
    expect(button.onPressed, isNotNull);
  });

  testWidgets('02 validation error keeps the form', (tester) async {
    await tester.runAsync(() async => (await seedDemo(c)).orThrow());
    await pumpScreen(tester, c, const IncomeScreen());
    await tapOn(tester, find.text(l.incomeLandsIn));
    await tapOn(tester, find.widgetWithText(BkRadioCard, '[MOMO ACCOUNT]'));
    await type(tester, l.incomeName, 'Second job');
    await typeAmount(tester, '3000');
    await type(tester, l.incomePayday, '32');
    await tapOn(tester, find.text(l.incomeSave));
    expect(find.text(l.errDay), findsOneWidget);
    expect(find.text('Second job'), findsOneWidget);
  });

  testWidgets('02 from Me: top bar, no Continue', (tester) async {
    await tester.runAsync(() async => (await seedDemo(c)).orThrow());
    await pumpScreen(tester, c, const IncomeScreen(fromMe: true));
    expect(find.byType(BkTopBar), findsOneWidget);
    expect(find.byType(BkFlowHeader), findsNothing);
    expect(find.text(l.continueLabel), findsNothing);
    expect(find.widgetWithText(BkListRow, 'Salary'), findsOneWidget);
  });

  testWidgets('03 ready: bills with the monthly total', (tester) async {
    await tester.runAsync(() async => (await seedDemo(c)).orThrow());
    await pumpScreen(tester, c, const BillsScreen());
    for (final name in ['Rent', 'ZESCO', 'Water', 'Transport']) {
      expect(find.text(name), findsOneWidget);
    }
    expect(find.text(money(const Money.kwacha(4300))), findsOneWidget);
  });

  testWidgets('04 invalid: 110% disables Continue with a reason', (
    tester,
  ) async {
    await tester.runAsync(() async => (await seedDemo(c)).orThrow());
    final id = await tester.runAsync(() => salaryId(c));
    await pumpScreen(tester, c, SplitScreen(incomeId: id!));
    await tapOn(tester, find.text('Living'));
    await type(tester, l.splitShare, '50');
    await tapOn(tester, find.widgetWithText(BkButton, l.save));
    expect(find.text(l.splitTooMuch(110)), findsOneWidget);
    expect(find.text(l.errSplitTotal), findsOneWidget);
  });

  testWidgets('04 bills exceed income: error banner', (tester) async {
    await tester.runAsync(() async {
      (await seedDemo(c)).orThrow();
      (await c.read(saveIncomeSourceProvider)(
        name: 'Small',
        kind: IncomeKind.salary,
        landsInAccountId: 'momo',
        expectedAmount: const Money.kwacha(4000),
        schedule: const MonthlyPay(1),
      )).orThrow();
    });
    final id = await tester.runAsync(
      () async => (await c.read(incomeRepositoryProvider).getAll())
          .orThrow()
          .firstWhere((i) => i.name == 'Small')
          .id,
    );
    await pumpScreen(tester, c, SplitScreen(incomeId: id!));
    expect(find.text(l.splitBillsExceed), findsOneWidget);
  });

  testWidgets('05 unassigned: Choose badges and Set the rest later', (
    tester,
  ) async {
    await tester.runAsync(() async {
      (await c.read(firstRunSeedProvider)()).orThrow();
    });
    await pumpScreen(tester, c, const AccountsScreen());
    expect(find.widgetWithText(BkBadge, l.choose), findsWidgets);
    expect(find.text(l.accountsLater), findsOneWidget);
  });

  testWidgets('05 match key under 3 characters: error', (tester) async {
    await tester.runAsync(() async {
      (await c.read(firstRunSeedProvider)()).orThrow();
    });
    await pumpScreen(tester, c, const AccountsScreen());
    await tapOn(tester, find.text('Living'));
    await tapOn(tester, find.text(l.accountAdd));
    await type(tester, l.accountName, 'Bank');
    await type(tester, l.accountMatchKey, '45');
    await tapOn(tester, find.widgetWithText(BkButton, l.save));
    expect(find.text(l.errMatchKey), findsWidgets);
  });

  testWidgets('06 blocked permission: warning and Open settings', (
    tester,
  ) async {
    final gateway = c.read(permissionGatewayProvider) as FakePermissionGateway;
    gateway.states[AppPermission.notifications] = PermissionState.blocked;
    await pumpScreen(tester, c, const PermissionsScreen());
    expect(find.text(l.permsDenied), findsOneWidget);
    await tapOn(tester, find.text(l.permsOpenSettings));
    expect(gateway.opened, isNotEmpty);
  });

  testWidgets('06 finishing: no spending account, then no income', (
    tester,
  ) async {
    await tester.runAsync(() async {
      (await c.read(firstRunSeedProvider)()).orThrow();
    });
    await pumpScreen(tester, c, const PermissionsScreen());
    await tapOn(tester, find.text(l.permsFinish));
    expect(find.text(l.errNoSpending), findsOneWidget);
    await tester.runAsync(() async {
      (await c.read(saveAccountProvider)(
        id: 'momo',
        name: '[MOMO]',
        kind: AccountKind.mtnMomo,
        isSpending: true,
      )).orThrow();
    });
    await tapOn(tester, find.text(l.permsFinish));
    expect(find.text(l.errNoIncome), findsOneWidget);
  });

  testWidgets('loading skeletons and the error banner with Try again', (
    tester,
  ) async {
    var retried = 0;
    Widget body(AsyncValue<int> v) => AsyncBody<int>(
      value: v,
      data: (n) => Text('$n'),
      onRetry: () => retried++,
    );
    await pumpScreen(tester, c, Scaffold(body: body(const AsyncLoading())));
    expect(find.byType(BkSkeleton), findsNWidgets(3));
    await pumpScreen(
      tester,
      c,
      Scaffold(
        body: body(
          const AsyncError(
            FailureException(StorageFailure('db', 'x')),
            StackTrace.empty,
          ),
        ),
      ),
    );
    expect(find.text(l.errLoad), findsOneWidget);
    await tapOn(tester, find.text(l.tryAgain));
    expect(retried, 1);
  });
}
