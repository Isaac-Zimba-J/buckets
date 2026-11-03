import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/db/daos/ledger_dao.dart';
import 'package:buckets_data/src/db/daos/payday_dao.dart';
import 'package:buckets_data/src/db/daos/setup_dao.dart';
import 'package:buckets_data/src/db/daos/transaction_dao.dart';
import 'package:buckets_data/src/mappers/activity_mappers.dart';
import 'package:buckets_data/src/mappers/money_mappers.dart';
import 'package:buckets_data/src/mappers/setup_mappers.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

T ok<T>(Result<T> r) => switch (r) {
  Ok(:final value) => value,
  Err(:final failure) => throw StateError('$failure'),
};

final DateTime at = DateTime.utc(2026, 10, 25, 6, 30, 15, 123);

void main() {
  late BucketsDatabase db;
  setUp(() => db = BucketsDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  test('account with match keys', () async {
    final account = ok(
      Account.create(
        id: 'a',
        name: 'Zanaco',
        kind: AccountKind.bank,
        matchKeys: [ok(MatchKey.create('4521')), ok(MatchKey.create('[NAME]'))],
        isSpending: true,
      ),
    );
    final dao = SetupDao(db);
    final (row, keys) = SetupMappers.accountRows(account);
    await dao.saveAccount(row, keys);
    await dao.saveAccount(row, keys); // replacing keeps one copy
    final [(a, k)] = await dao.accountsWithKeys();
    expect(ok(SetupMappers.account(a, k)), account);
  });

  test('bucket', () async {
    final bucket = ok(
      Bucket.create(
        id: 'b',
        name: 'Emergency',
        kind: BucketKind.emergency,
        color: BucketColor.emergency,
        accountId: 'a',
        sortOrder: 2,
      ),
    );
    await db.into(db.buckets).insert(SetupMappers.bucketRow(bucket));
    final row = await db.select(db.buckets).getSingle();
    expect(ok(SetupMappers.bucket(row)), bucket);
  });

  test('income sources for every schedule', () async {
    final dao = SetupDao(db);
    final incomes = [
      for (final (id, schedule) in [
        ('m', const MonthlyPay(25)),
        ('f', FortnightlyPay(at)),
        ('i', const IrregularPay()),
      ])
        ok(
          IncomeSource.create(
            id: id,
            name: 'Income $id',
            kind: IncomeKind.salary,
            schedule: schedule,
            landsInAccountId: 'a',
            splitProfileId: 'p',
            expectedAmount: id == 'i' ? null : const Money.kwacha(12000),
            payerKeys: [ok(MatchKey.create('[EMPLOYER]'))],
          ),
        ),
    ];
    for (final i in incomes) {
      final (row, keys) = SetupMappers.incomeRows(i);
      await dao.saveIncome(row, keys);
    }
    final back = [
      for (final (row, keys) in await dao.incomesWithKeys())
        ok(SetupMappers.income(row, keys)),
    ];
    expect(back, unorderedEquals(incomes));
  });

  test('split profile keeps allocation order', () async {
    final profile = ok(
      SplitProfile.create(
        id: 'p',
        allocations: [
          Allocation('living', BasisPoints(4000)),
          Allocation('long', BasisPoints(6000)),
        ],
      ),
    );
    final dao = SetupDao(db);
    final (row, allocations) = SetupMappers.splitProfileRows(profile);
    await dao.saveSplitProfile(row, allocations);
    final (p, a) = (await dao.splitProfile('p'))!;
    expect(ok(SetupMappers.splitProfile(p, a)), profile);
    expect(await dao.splitProfile('nope'), isNull);
  });

  test('bills, monthly and termly', () async {
    final bills = [
      ok(
        Bill.create(
          id: 'rent',
          name: 'Rent',
          amount: const Money.kwacha(2500),
          frequency: BillFrequency.monthly,
          dueDay: 1,
          paidFromBucketId: 'living',
        ),
      ),
      ok(
        Bill.create(
          id: 'fees',
          name: 'School fees',
          amount: const Money.kwacha(2400),
          frequency: BillFrequency.termly,
          nextDueDate: at,
          paidFromBucketId: 'living',
          payeeAccountHint: '[SCHOOL]',
        ),
      ),
    ];
    for (final b in bills) {
      await db.into(db.bills).insert(SetupMappers.billRow(b));
    }
    final back = [
      for (final row in await db.select(db.bills).get())
        ok(SetupMappers.bill(row)),
    ];
    expect(back, unorderedEquals(bills));
  });

  test('settings', () async {
    final settings = ok(
      Settings.defaults.copyWith(snoozeLimit: 2, setupCompletedAt: at),
    );
    await db.into(db.settingsRows).insert(SetupMappers.settingsRow(settings));
    final row = await db.select(db.settingsRows).getSingle();
    expect(ok(SetupMappers.settings(row)), settings);
  });

  test('ledger entry with every ref', () async {
    final entry = ok(
      LedgerEntry.create(
        id: 'e',
        occurredAt: at,
        kind: LedgerEntryKind.moveIn,
        bucketId: 'living',
        amount: const Money(31000),
        counterBucketId: 'fun',
        refs: const LedgerRefs(
          paydayId: 'p',
          transferId: 't',
          alertId: 'al',
          transactionId: 'tx',
          receiptId: 'r',
          billId: 'b',
          carryOverId: 'c',
        ),
        note: 'cover',
      ),
    );
    final dao = LedgerDao(db);
    await dao.append([MoneyMappers.ledgerEntryRow(entry)]);
    final [row] = await dao.entries(bucketId: 'living');
    expect(ok(MoneyMappers.ledgerEntry(row)), entry);
    expect(await dao.entries(bucketId: 'other'), isEmpty);
  });

  test('payday with transfers and proof refs', () async {
    Transfer t(String id, List<String> refs, TransferStatus s) => ok(
      Transfer.create(
        id: id,
        bucketId: 'b$id',
        toAccountId: 'savings',
        amount: const Money.kwacha(770),
        status: s,
        provenAmount: s == TransferStatus.pending ? null : const Money(1),
        owedAmount: s == TransferStatus.partial ? const Money(76999) : null,
        proofRefs: refs,
        provenAt: s == TransferStatus.pending ? null : at,
      ),
    );
    final payday = ok(
      Payday.create(
        id: 'p',
        incomeSourceId: 'salary',
        amount: const Money.kwacha(12000),
        startedAt: at,
        transfers: [
          t('1', const [], TransferStatus.pending),
          t('2', const ['ZX98', 'QQ11'], TransferStatus.partial),
        ],
        snoozesUsed: 1,
        snoozedUntil: at,
      ),
    );
    final dao = PaydayDao(db);
    final (row, transfers, refs) = MoneyMappers.paydayRows(payday);
    await dao.save(row, transfers, refs);
    await dao.save(row, transfers, refs);
    final (p, ts, rs) = (await dao.byId('p'))!;
    expect(ok(MoneyMappers.payday(p, ts, rs)), payday);
    expect(await dao.isReferenceUsed('QQ11'), isTrue);
    expect(await dao.isReferenceUsed('NOPE'), isFalse);
    expect(await dao.all(), hasLength(1));
  });

  test('held income, goal, check-in', () async {
    final held = ok(
      HeldIncome.create(
        id: 'h',
        incomeSourceId: 'hustle',
        amount: const Money.kwacha(2000),
        receivedAt: at,
        alertId: 'al',
      ),
    );
    final goal = ok(
      Goal.create(
        bucketId: 'laptop',
        target: const Money.kwacha(9000),
        targetDate: at,
        celebratedAt: at,
      ),
    );
    final checkIn = ok(
      CheckIn.create(
        id: 'c',
        countedAt: at,
        expectedCash: const Money.kwacha(400),
        countedCash: const Money.kwacha(350),
      ),
    );
    await db.into(db.heldIncomes).insert(MoneyMappers.heldIncomeRow(held));
    await db.into(db.goals).insert(MoneyMappers.goalRow(goal));
    await db.into(db.checkIns).insert(MoneyMappers.checkInRow(checkIn));
    expect(
      ok(MoneyMappers.heldIncome(await db.select(db.heldIncomes).getSingle())),
      held,
    );
    expect(ok(MoneyMappers.goal(await db.select(db.goals).getSingle())), goal);
    expect(
      ok(MoneyMappers.checkIn(await db.select(db.checkIns).getSingle())),
      checkIn,
    );
  });

  test('payment alerts, parsed and unparsed', () async {
    final alerts = [
      ok(
        PaymentAlert.create(
          id: 'parsed',
          rawText: '[MESSAGE]',
          source: AlertSource.mtnMomo,
          receivedAt: at,
          status: AlertStatus.sorted,
          parsed: ParsedMessage(
            confidence: 0.75,
            direction: MessageDirection.outgoing,
            amount: const Money(18500),
            fee: const Money(250),
            counterparty: '[MERCHANT]',
            reference: 'ZX98',
            occurredAt: at,
            balanceAfter: const Money(120410),
            isWithdrawal: true,
          ),
        ),
      ),
      ok(
        PaymentAlert.create(
          id: 'raw',
          rawText: null,
          source: AlertSource.unknown,
          receivedAt: at,
          parsed: ParsedMessage.unparsed,
        ),
      ),
    ];
    for (final a in alerts) {
      await db.into(db.paymentAlerts).insert(ActivityMappers.alertRow(a));
    }
    final back = [
      for (final row in await db.select(db.paymentAlerts).get())
        ok(ActivityMappers.alert(row)),
    ];
    expect(back, unorderedEquals(alerts));
  });

  test('transaction with lines and a custom category', () async {
    final tx = ok(
      Transaction.create(
        id: 'tx',
        amount: const Money.kwacha(300),
        bucketId: 'living',
        category: ok(Category.create('Rent top-up')),
        accountId: 'momo',
        occurredAt: at,
        source: TransactionSource.receipt,
        note: 'note',
        alertId: 'al',
        receiptId: 'r',
        billId: 'b',
        lines: const [
          TransactionLine('living', Money.kwacha(200)),
          TransactionLine('family', Money.kwacha(100)),
        ],
      ),
    );
    final dao = TransactionDao(db);
    final (row, lines) = ActivityMappers.transactionRows(tx);
    await dao.save(row, lines);
    await dao.save(row, lines);
    final [(r, l)] = await dao.query();
    expect(ok(ActivityMappers.transaction(r, l)), tx);
    expect(ok(ActivityMappers.category('Fees')), Category.fees);
  });

  test('withdrawal, merchant rule, planned buy, wish', () async {
    final w = ok(
      CashWithdrawal.create(
        id: 'w',
        amount: const Money.kwacha(500),
        fromAccountId: 'momo',
        cashAccountId: 'cash',
        occurredAt: at,
      ),
    );
    final rule = MerchantRule(
      id: 'r',
      merchantKey: ok(MerchantKey.create('zesco')),
      category: Category.bill,
      bucketId: 'living',
    );
    final planned = ok(
      PlannedPurchase.create(
        id: 'pp',
        name: 'Gas',
        amount: const Money.kwacha(350),
        bucketId: 'living',
        due: at,
        repeatEvery: const Duration(days: 30),
        done: true,
        transactionId: 'tx',
      ),
    );
    final wish = ok(
      Wish.create(
        id: 'wi',
        name: 'Speaker',
        amount: const Money.kwacha(700),
        bucketId: 'short',
        createdAt: at,
        endsAt: at.add(const Duration(hours: 48)),
        status: WishStatus.approved,
      ),
    );
    await db.into(db.cashWithdrawals).insert(ActivityMappers.withdrawalRow(w));
    await db
        .into(db.merchantRules)
        .insert(ActivityMappers.merchantRuleRow(rule));
    await db
        .into(db.plannedPurchases)
        .insert(ActivityMappers.plannedRow(planned));
    await db.into(db.wishes).insert(ActivityMappers.wishRow(wish));
    expect(
      ok(
        ActivityMappers.withdrawal(
          await db.select(db.cashWithdrawals).getSingle(),
        ),
      ),
      w,
    );
    expect(
      ok(
        ActivityMappers.merchantRule(
          await db.select(db.merchantRules).getSingle(),
        ),
      ),
      rule,
    );
    expect(
      ok(
        ActivityMappers.planned(
          await db.select(db.plannedPurchases).getSingle(),
        ),
      ),
      planned,
    );
    expect(
      ok(ActivityMappers.wish(await db.select(db.wishes).getSingle())),
      wish,
    );
  });

  test('stored receipt draft as JSON', () async {
    final receipt = StoredReceipt(
      id: 'r',
      imagePath: '/private/r.jpg',
      draft: ReceiptDraft(
        merchant: Scored('[MERCHANT]', 0.9),
        date: Scored(at, 0.6),
        total: Scored(const Money(41250), 0.75),
        items: [ReceiptItem('Bread', const Money(2500), 0.95)],
      ),
    );
    await db.into(db.receipts).insert(ActivityMappers.receiptRow(receipt));
    expect(
      ok(ActivityMappers.receipt(await db.select(db.receipts).getSingle())),
      receipt,
    );
  });

  test('a corrupt receipt draft is a StorageFailure', () async {
    await db
        .into(db.receipts)
        .insert(
          ReceiptsCompanion.insert(
            id: 'x',
            imagePath: '/x',
            draftJson: '{oops',
          ),
        );
    final result = ActivityMappers.receipt(
      await db.select(db.receipts).getSingle(),
    );
    expect(result, isA<Err<StoredReceipt>>());
  });
}
