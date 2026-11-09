import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/setup/presentation/controllers/bills_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/bucket_accounts_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/income_setup_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/permissions_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/split_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/welcome_controller.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// A container on fakes after the first-run seed, with a MoMo spending
/// account and a savings account.
Future<ProviderContainer> setUpContainer() async {
  final c = ProviderContainer(
    overrides: fakePortOverrides(),
    retry: retryUnlessFailure,
  );
  (await c.read(firstRunSeedProvider)()).orThrow();
  for (final (id, kind, spending) in const [
    ('momo', AccountKind.mtnMomo, true),
    ('savings', AccountKind.bank, false),
  ]) {
    (await c.read(saveAccountProvider)(
      id: id,
      name: id,
      kind: kind,
      isSpending: spending,
    )).orThrow();
  }
  return c;
}

Future<String> addSalary(ProviderContainer c, {int kwacha = 12000}) async {
  await c.read(incomeSetupControllerProvider.future);
  await c
      .read(incomeSetupControllerProvider.notifier)
      .save(
        name: 'Salary',
        kind: IncomeKind.salary,
        landsInAccountId: 'momo',
        expected: Money.kwacha(kwacha),
        paydayOfMonth: 25,
      );
  return c.read(incomeSetupControllerProvider).value!.incomes.single.id;
}

Future<void> addCanvasBills(ProviderContainer c) async {
  await c.read(billsControllerProvider.future);
  for (final (name, kwacha) in const [
    ('Rent', 2500),
    ('ZESCO', 400),
    ('Water', 600),
    ('Transport', 800),
  ]) {
    await c
        .read(billsControllerProvider.notifier)
        .save(
          name: name,
          amount: Money.kwacha(kwacha),
          frequency: BillFrequency.monthly,
          dueDay: 1,
        );
  }
}

void main() {
  late ProviderContainer c;
  setUp(() async => c = await setUpContainer());
  tearDown(() => c.dispose());

  test('01 Welcome: not set up, then set up', () async {
    expect(await c.read(welcomeControllerProvider.future), isFalse);
    await addSalary(c);
    (await c.read(completeSetupProvider)()).orThrow();
    c.invalidate(welcomeControllerProvider);
    expect(await c.read(welcomeControllerProvider.future), isTrue);
  });

  group('02 Income', () {
    test('ready: empty, then the saved income', () async {
      expect(
        (await c.read(incomeSetupControllerProvider.future)).incomes,
        isEmpty,
      );
      await addSalary(c);
      final income = c
          .read(incomeSetupControllerProvider)
          .value!
          .incomes
          .single;
      expect(income.expected, const Money.kwacha(12000));
      expect(income.paydayOfMonth, 25);
    });

    test('validation errors keep the form (amount ≤ 0, payday)', () async {
      await c.read(incomeSetupControllerProvider.future);
      final notifier = c.read(incomeSetupControllerProvider.notifier);
      expect(
        await notifier.save(
          name: 'Salary',
          kind: IncomeKind.salary,
          landsInAccountId: 'momo',
          expected: Money.zero,
          paydayOfMonth: 25,
        ),
        isFalse,
      );
      expect(
        c.read(incomeSetupControllerProvider).value!.errorCode,
        'expectedAmount.notPositive',
      );
      await notifier.save(
        name: 'Salary',
        kind: IncomeKind.salary,
        landsInAccountId: 'momo',
        paydayOfMonth: 32,
      );
      expect(
        c.read(incomeSetupControllerProvider).value!.errorCode,
        'payday.outOfRange',
      );
    });
  });

  group('03 Bills', () {
    test('empty, then ready with the K 4,300 total (R-BILL-3)', () async {
      expect(await c.read(billsControllerProvider.future), isA<BillsEmpty>());
      await addCanvasBills(c);
      final ready = c.read(billsControllerProvider).value! as BillsReady;
      expect(ready.bills, hasLength(4));
      expect(ready.total, const Money.kwacha(4300));
    });

    test('validation error, then delete back to empty', () async {
      await c.read(billsControllerProvider.future);
      final notifier = c.read(billsControllerProvider.notifier);
      expect(
        await notifier.save(
          name: '',
          amount: const Money(1),
          frequency: BillFrequency.monthly,
          dueDay: 1,
        ),
        isFalse,
      );
      expect(
        (c.read(billsControllerProvider).value! as BillsEmpty).errorCode,
        'name.blank',
      );
      await addCanvasBills(c);
      final ready = c.read(billsControllerProvider).value! as BillsReady;
      for (final b in ready.bills) {
        await notifier.delete(b.id);
      }
      expect(c.read(billsControllerProvider).value, isA<BillsEmpty>());
    });
  });

  group('04 Split', () {
    test('valid default split for the canvas income', () async {
      final income = await addSalary(c);
      await addCanvasBills(c);
      final split = await c.read(splitControllerProvider(income).future);
      expect(split.status, SplitStatus.valid);
      expect(split.totalBasisPoints, 10000);
      expect(split.amountToSplit, const Money.kwacha(7700));
      expect(split.rows.first.share, const Money.kwacha(3080));
    });

    test('invalid at 110%, valid again, then saved', () async {
      final income = await addSalary(c);
      await c.read(splitControllerProvider(income).future);
      final notifier = c.read(splitControllerProvider(income).notifier);
      final living = c.read(splitControllerProvider(income)).value!.rows.first;
      notifier.setShare(living.bucketId, 5000);
      var split = c.read(splitControllerProvider(income)).value!;
      expect(split.status, SplitStatus.invalid);
      expect(split.totalBasisPoints, 11000);
      expect(await notifier.save(), isFalse);
      notifier.setShare(living.bucketId, 4000);
      expect(await notifier.save(), isTrue);
      split = c.read(splitControllerProvider(income)).value!;
      expect(split.saved, isTrue);
    });

    test('bills exceed income (R-SPLIT-2)', () async {
      final income = await addSalary(c, kwacha: 4000);
      await addCanvasBills(c);
      c.invalidate(splitControllerProvider(income));
      final split = await c.read(splitControllerProvider(income).future);
      expect(split.status, SplitStatus.billsExceedIncome);
    });

    test('a missing income is the error state', () async {
      final sub = c.listen(splitControllerProvider('nope'), (_, _) {});
      await expectLater(
        c.read(splitControllerProvider('nope').future),
        throwsA(isA<FailureException>()),
      );
      expect(c.read(splitControllerProvider('nope')).hasError, isTrue);
      sub.close();
    });
  });

  group('05 Where buckets live', () {
    test('some unassigned, then all assigned', () async {
      var state = await c.read(bucketAccountsControllerProvider.future);
      expect(state.someUnassigned, isTrue);
      expect(
        state.accounts.map((a) => a.id),
        unorderedEquals(['momo', 'savings']),
      );
      final notifier = c.read(bucketAccountsControllerProvider.notifier);
      for (final b in state.buckets) {
        expect(await notifier.assign(b.bucketId, 'savings'), isTrue);
      }
      state = c.read(bucketAccountsControllerProvider).value!;
      expect(state.someUnassigned, isFalse);
    });

    test('match key validation error (R-ACC-3)', () async {
      await c.read(bucketAccountsControllerProvider.future);
      final ok = await c
          .read(bucketAccountsControllerProvider.notifier)
          .saveAccount(
            name: 'Zanaco',
            kind: AccountKind.bank,
            matchKeys: ['45'],
          );
      expect(ok, isFalse);
      expect(
        c.read(bucketAccountsControllerProvider).value!.errorCode,
        'matchKey.tooShort',
      );
    });
  });

  group('06 Alarms & alerts', () {
    test('denied, then granted after asking', () async {
      var state = await c.read(permissionsControllerProvider.future);
      expect(state.denied, isTrue);
      final notifier = c.read(permissionsControllerProvider.notifier);
      for (final p in [
        AppPermission.notifications,
        AppPermission.exactAlarms,
      ]) {
        await notifier.request(p);
      }
      state = c.read(permissionsControllerProvider).value!;
      expect(
        state.permissions[AppPermission.notifications],
        PermissionState.granted,
      );
    });

    test('blocked: Open settings opens the settings page', () async {
      final gateway =
          c.read(permissionGatewayProvider) as FakePermissionGateway;
      gateway.states[AppPermission.notifications] = PermissionState.blocked;
      await c.read(permissionsControllerProvider.future);
      await c
          .read(permissionsControllerProvider.notifier)
          .openSettings(AppPermission.notifications);
      expect(gateway.opened, [AppPermission.notifications]);
    });

    test('completing needs an income; then completed', () async {
      await c.read(permissionsControllerProvider.future);
      final notifier = c.read(permissionsControllerProvider.notifier);
      expect(await notifier.complete(), isFalse);
      expect(
        c.read(permissionsControllerProvider).value!.errorCode,
        'setup.noIncome',
      );
      await addSalary(c);
      expect(await notifier.complete(), isTrue);
      expect(c.read(permissionsControllerProvider).value!.completed, isTrue);
      expect(
        (await c.read(settingsRepositoryProvider).get())
            .orThrow()
            .setupCompletedAt,
        isNotNull,
      );
    });
  });
}
