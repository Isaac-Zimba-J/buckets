import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import '../../support/world.dart';

void main() {
  late World w;
  setUp(() => w = World());

  group('GetSetupStatus and CompleteSetup', () {
    test('setup is incomplete until completed', () async {
      expect(ok(await GetSetupStatus(w.settings)()), isFalse);
    });

    test('completing needs an income, then records the time', () async {
      final complete = CompleteSetup(
        w.accounts,
        w.buckets,
        w.incomes,
        w.settings,
        w.clock,
      );
      expect(await complete(), isErr('setup.noIncome'));
      await SaveIncomeSource(
        w.incomes,
        w.profiles,
        w.buckets,
        w.settings,
        w.ids,
      )(
        name: 'Salary',
        kind: IncomeKind.salary,
        landsInAccountId: 'momo',
        schedule: const MonthlyPay(25),
      );
      final settings = ok(await complete());
      expect(settings.setupCompletedAt, w.clock.now());
      expect(ok(await GetSetupStatus(w.settings)()), isTrue);
    });

    test('completing checks the account rules (R-ACC-2)', () async {
      w.accounts.store.items.remove('cash');
      await w.incomes.save(
        ok(
          IncomeSource.create(
            id: 'i',
            name: 'Salary',
            kind: IncomeKind.salary,
            schedule: const MonthlyPay(25),
            landsInAccountId: 'momo',
            splitProfileId: 'p',
          ),
        ),
      );
      expect(
        await CompleteSetup(
          w.accounts,
          w.buckets,
          w.incomes,
          w.settings,
          w.clock,
        )(),
        isErr('accounts.noCash'),
      );
    });

    test('storage failures come back as Err', () async {
      w.settings.store.failing = true;
      expect(await GetSetupStatus(w.settings)(), isErr('storage'));
    });
  });

  group('SaveIncomeSource', () {
    SaveIncomeSource save() =>
        SaveIncomeSource(w.incomes, w.profiles, w.buckets, w.settings, w.ids);

    test('a new salary gets the default salary split (R-SPLIT-4)', () async {
      final income = ok(
        await save()(
          name: 'Salary',
          kind: IncomeKind.salary,
          landsInAccountId: 'momo',
          expectedAmount: const Money.kwacha(12000),
          schedule: const MonthlyPay(25),
        ),
      );
      expect(income.deductBillsFirst, isTrue);
      final profile = ok(await w.profiles.get(income.splitProfileId));
      expect(SplitProfile.totalOf(profile.allocations), 10000);
      // No goal yet: Long-term takes the goal share (R-SPLIT-4a).
      expect(
        {for (final a in profile.allocations) a.bucketId: a.bp.value}[w
            .bucketOf(BucketKind.longTerm)],
        3000,
      );
      expect(ok(await ListIncomeSources(w.incomes)()), [income]);
    });

    test('a side hustle defaults to irregular without bills first', () async {
      final income = ok(
        await save()(
          name: 'Tutoring',
          kind: IncomeKind.sideHustle,
          landsInAccountId: 'momo',
        ),
      );
      expect(income.schedule, const IrregularPay());
      expect(income.deductBillsFirst, isFalse);
    });

    test('editing keeps the split and settings', () async {
      final first = ok(
        await save()(
          name: 'Salary',
          kind: IncomeKind.salary,
          landsInAccountId: 'momo',
          schedule: const MonthlyPay(25),
        ),
      );
      final edited = ok(
        await save()(
          id: first.id,
          name: 'Main job',
          kind: IncomeKind.salary,
          landsInAccountId: 'momo',
        ),
      );
      expect(edited.splitProfileId, first.splitProfileId);
      expect(edited.schedule, const MonthlyPay(25));
      expect(edited.name, 'Main job');
    });

    test('validation errors from screen 02', () async {
      expect(
        await save()(
          name: 'Salary',
          kind: IncomeKind.salary,
          landsInAccountId: 'momo',
          expectedAmount: Money.zero,
          schedule: const MonthlyPay(25),
        ),
        isErr('expectedAmount.notPositive'),
      );
      expect(
        await save()(
          name: 'Salary',
          kind: IncomeKind.salary,
          landsInAccountId: 'momo',
        ),
        isErr('payday.outOfRange'),
      );
    });
  });

  group('Bills', () {
    test('saved bills are paid from Living by default and listed', () async {
      final bill = ok(
        await SaveBill(w.bills, w.buckets, w.ids)(
          name: 'Rent',
          amount: const Money.kwacha(2500),
          frequency: BillFrequency.monthly,
          dueDay: 1,
        ),
      );
      expect(bill.paidFromBucketId, w.bucketOf(BucketKind.living));
      expect(await ListBills(w.bills)().first, [bill]);
      ok(await DeleteBill(w.bills)(bill.id));
      expect(await ListBills(w.bills)().first, isEmpty);
    });

    test('R-BILL-1/3 reservations and total: canvas K 4,300', () async {
      final save = SaveBill(w.bills, w.buckets, w.ids);
      for (final (name, kwacha) in [
        ('Rent', 2500),
        ('ZESCO', 400),
        ('Water', 600),
      ]) {
        await save(
          name: name,
          amount: Money.kwacha(kwacha),
          frequency: BillFrequency.monthly,
          dueDay: 1,
        );
      }
      await save(
        name: 'School fees',
        amount: const Money.kwacha(2400),
        frequency: BillFrequency.termly,
        nextDueDate: DateTime.utc(2027, 1, 10),
      );
      await w.incomes.save(
        ok(
          IncomeSource.create(
            id: 'salary',
            name: 'Salary',
            kind: IncomeKind.salary,
            schedule: const MonthlyPay(25),
            landsInAccountId: 'momo',
            splitProfileId: 'p',
          ),
        ),
      );
      final (lines, total) = ok(
        await GetBillReservations(
          w.bills,
          w.ledger,
          w.incomes,
          w.clock,
          w.zone,
        )(),
      );
      expect(total, const Money.kwacha(4300));
      final fees = lines.firstWhere((l) => l.bill.name == 'School fees');
      expect(fees.reservation.amount, const Money.kwacha(800));
      expect(fees.putAside, Money.zero);
    });
  });

  group('Splits', () {
    final allocations = [
      for (final (id, bp) in [
        ('living', 4000),
        ('fun', 1000),
        ('emergency', 1000),
        ('short', 1000),
        ('long', 2000),
        ('laptop', 1000),
      ])
        Allocation(id, BasisPoints(bp)),
    ];

    test('PreviewSplit shows the canvas example', () {
      final preview = const PreviewSplit()(
        income: const Money.kwacha(12000),
        deductBillsFirst: true,
        billReservations: const Money.kwacha(4300),
        allocations: allocations,
        livingBucketId: 'living',
      );
      expect(preview.totalBasisPoints, 10000);
      expect(preview.amountToSplit, const Money.kwacha(7700));
      expect(
        preview.shares.first,
        const BucketShare('living', Money.kwacha(3080)),
      );
      expect(preview.failure, isNull);
    });

    test('PreviewSplit invalid states from screen 04', () {
      final tooMuch = const PreviewSplit()(
        income: const Money.kwacha(12000),
        deductBillsFirst: true,
        billReservations: const Money.kwacha(4300),
        allocations: [...allocations, Allocation('extra', BasisPoints(1000))],
      );
      expect(tooMuch.totalBasisPoints, 11000);
      expect(tooMuch.failure?.code, 'split.tooMuch');
      expect(tooMuch.shares, isEmpty);
      expect(tooMuch.amountToSplit, const Money.kwacha(7700));
      final bills = const PreviewSplit()(
        income: const Money.kwacha(4000),
        deductBillsFirst: true,
        billReservations: const Money.kwacha(4300),
        allocations: allocations,
      );
      expect(bills.failure?.code, 'billsExceedIncome');
      expect(bills.amountToSplit, isNull);
    });

    test('SaveSplitProfile saves only a valid split', () async {
      final save = SaveSplitProfile(w.profiles);
      ok(await save(id: 'p', allocations: allocations));
      expect(ok(await w.profiles.get('p')).allocations, allocations);
      expect(
        await save(id: 'p', allocations: allocations.take(2).toList()),
        isErr('split.tooLittle'),
      );
    });
  });

  group('Accounts and buckets', () {
    test('SaveAccount validates match keys (R-ACC-3)', () async {
      final save = SaveAccount(w.accounts, w.ids);
      expect(
        await save(name: 'Zanaco', kind: AccountKind.bank, matchKeys: ['45']),
        isErr('matchKey.tooShort'),
      );
      final a = ok(
        await save(name: 'Zanaco', kind: AccountKind.bank, matchKeys: ['4521']),
      );
      expect(a.matchKeys.single.value, '4521');
    });

    test(
      'a new spending account takes the flag from the old one (R-ACC-1)',
      () async {
        ok(
          await SaveAccount(w.accounts, w.ids)(
            name: 'Airtel',
            kind: AccountKind.airtelMoney,
            isSpending: true,
          ),
        );
        final all = ok(await w.accounts.getAll());
        expect(all.where((a) => a.isSpending), hasLength(1));
        expect(AccountRules.validate(all), isA<Ok<List<Account>>>());
      },
    );

    test(
      'ListBucketsWithAccounts warns for savings in the spending account',
      () async {
        final emergency = w.bucketOf(BucketKind.emergency);
        ok(await AssignBucketAccount(w.buckets, w.accounts)(emergency, 'momo'));
        final rows = ok(await ListBucketsWithAccounts(w.buckets, w.accounts)());
        expect(rows, hasLength(5));
        final byKind = {for (final r in rows) r.bucket.kind: r};
        expect(byKind[BucketKind.emergency]!.warning, isTrue);
        expect(byKind[BucketKind.living]!.warning, isFalse);
        expect(byKind[BucketKind.longTerm]!.account!.id, 'savings');
      },
    );

    test(
      'a bucket without a known account shows as needing a choice',
      () async {
        w.accounts.store.items.remove('savings');
        final rows = ok(await ListBucketsWithAccounts(w.buckets, w.accounts)());
        expect(
          rows.where((r) => r.account == null).map((r) => r.bucket.kind),
          [BucketKind.emergency, BucketKind.shortTerm, BucketKind.longTerm],
        );
      },
    );

    test('assigning to a missing account fails', () async {
      expect(
        await AssignBucketAccount(w.buckets, w.accounts)(
          w.bucketOf(BucketKind.emergency),
          'nope',
        ),
        isErr('notFound'),
      );
    });
  });

  group('Permissions and preferences (screen 06)', () {
    test('status, request and settings', () async {
      expect(
        ok(await GetPermissionStatus(w.permissions)(AppPermission.camera)),
        PermissionState.denied,
      );
      w.permissions.grantOnRequest = PermissionState.blocked;
      expect(
        ok(await RequestNotificationPermission(w.permissions)()),
        PermissionState.blocked,
      );
      ok(await OpenNotificationAccessSettings(w.permissions)());
      expect(w.permissions.opened, [AppPermission.notificationAccess]);
    });

    test('preferences are validated and saved', () async {
      final save = SaveNotificationPreferences(w.settings);
      expect(ok(await save(snoozeLimit: 2)).snoozeLimit, 2);
      expect(ok(await w.settings.get()).snoozeLimit, 2);
      expect(await save(snoozeLimit: 9), isErr('snoozeLimit.outOfRange'));
    });
  });
}
