import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fakes/fakes_bills.dart';
import '../../helpers.dart';
import '../../support/payday_world.dart';

/// A world with a Bills bucket, the canvas bills and the new repositories.
class BillsWorld extends PaydayWorld {
  BillsWorld() {
    buckets.store.items['bills'] = ok(
      Bucket.create(
        id: 'bills',
        name: 'Bills',
        kind: BucketKind.bills,
        color: BucketColor.business,
        accountId: 'momo',
        sortOrder: 6,
      ),
    );
  }

  final occurrences = InMemoryBillOccurrenceRepository();
  final tariffs = InMemoryFeeTariffRepository();

  late final cycle = GetCurrentCycle(incomes, paydays, settings, clock, zone);
  late final ensure = EnsureBillOccurrences(
    bills,
    occurrences,
    cycle,
    clock,
    zone,
    ids,
  );
  late final spend = SpendWriter(transactions, ledger, ids);
  late final markPaid = MarkBillPaid(
    occurrences,
    bills,
    buckets,
    accounts,
    tariffs,
    spend,
    clock,
    ids,
  );
  late final billsCycle = GetBillsCycle(
    occurrences,
    reservations,
    cycle,
    transactions,
    clock,
    zone,
  );
  late final learn = LearnFee(tariffs);
  late final feesSummary = GetFeesSummary(
    transactions,
    cycle,
    incomes,
    paydays,
  );
  late final recordFee = RecordTransferFee(
    paydays,
    incomes,
    accounts,
    buckets,
    tariffs,
    learn,
    spend,
    clock,
    ids,
  );

  Future<Money> balance(String bucketId) async =>
      BalanceCalculator.balance(ok(await ledger.getEntries()), bucketId);

  Future<BillOccurrence> occurrenceOf(String billName) async {
    final bill = ok(await bills.getAll()).firstWhere((b) => b.name == billName);
    return ok(await occurrences.getForBill(bill.id)).single;
  }
}

void main() {
  late BillsWorld w;
  setUp(() async {
    w = BillsWorld();
    await w.canvasSetup();
    ok(await w.ensure());
  });

  test('occurrences exist for the monthly bills only, and only once', () async {
    final all = ok(await w.occurrences.getAll());
    expect(all.map((o) => o.status), everyElement(BillStatus.due));
    expect(all, hasLength(3)); // Rent, ZESCO, Water; School fees is in Jan
    expect(ok(await w.ensure()), isEmpty);
    expect(ok(await w.occurrences.getAll()), hasLength(3));
  });

  test('new bills are paid from the Bills bucket (R-BILL-5)', () async {
    final bills = ok(await w.bills.getAll());
    expect(bills.map((b) => b.paidFromBucketId), everyElement('bills'));
  });

  group('MarkBillPaid (R-BILL-7)', () {
    test('books the spend from Bills and the fee from Living', () async {
      await w.startSalary(ok(await w.incomes.getAll()).first);
      final billsBefore = await w.balance('bills');
      final o = await w.occurrenceOf('Rent');
      final living = ok(await w.buckets.getAll())
          .firstWhere((b) => b.kind == BucketKind.living)
          .id;
      final livingBefore = await w.balance(living);

      final paid = ok(
        await w.markPaid(
          occurrenceId: o.id,
          amount: const Money.kwacha(2500),
          accountId: 'momo',
          fee: const Money.kwacha(18),
          proofRef: 'REF1',
        ),
      );

      expect(paid.status, BillStatus.paid);
      expect(paid.paidAmount, const Money.kwacha(2500));
      expect(await w.balance('bills'), billsBefore - const Money.kwacha(2500));
      expect(await w.balance(living), livingBefore - const Money.kwacha(18));
      final fee = ok(await w.transactions.get(paid.feeTransactionId!));
      expect(fee.feeSource, FeeSource.message);
      expect(fee.feeType, FeeType.billPay);
      expect(fee.parentTransactionId, isNotNull);
      expect(fee.provider, AlertSource.mtnMomo);
    });

    test('with no fee in the message it is estimated from the rates', () async {
      ok(
        await SaveFeeBand(w.tariffs)(
          provider: AlertSource.mtnMomo,
          feeType: FeeType.billPay,
          min: const Money.kwacha(1),
          max: const Money.kwacha(5000),
          fee: const Money.kwacha(20),
        ),
      );
      final o = await w.occurrenceOf('Rent');
      final paid = ok(
        await w.markPaid(
          occurrenceId: o.id,
          amount: const Money.kwacha(2500),
          accountId: 'momo',
        ),
      );
      final fee = ok(await w.transactions.get(paid.feeTransactionId!));
      expect(fee.feeSource, FeeSource.estimated);
      expect(fee.amount, const Money.kwacha(20));
    });

    test(
      'with no message and no rates the fee is recorded as missing',
      () async {
        final o = await w.occurrenceOf('Water');
        final paid = ok(
          await w.markPaid(
            occurrenceId: o.id,
            amount: const Money.kwacha(600),
            accountId: 'momo',
          ),
        );
        final fee = ok(await w.transactions.get(paid.feeTransactionId!));
        expect(fee.feeSource, FeeSource.missing);
        expect(fee.amount, Money.zero);
        // A missing fee books nothing (K 0).
        expect(
          ok(await w.ledger.getEntries())
              .where((e) => e.refs.transactionId == fee.id),
          isEmpty,
        );
      },
    );

    test('paying from cash records no fee at all', () async {
      final o = await w.occurrenceOf('ZESCO');
      final paid = ok(
        await w.markPaid(
          occurrenceId: o.id,
          amount: const Money.kwacha(400),
          accountId: 'cash',
        ),
      );
      expect(paid.feeTransactionId, isNull);
    });

    test('a bill cannot be paid twice or from an unknown account', () async {
      final o = await w.occurrenceOf('Rent');
      ok(
        await w.markPaid(
          occurrenceId: o.id,
          amount: const Money.kwacha(2500),
          accountId: 'momo',
        ),
      );
      expect(
        await w.markPaid(
          occurrenceId: o.id,
          amount: const Money.kwacha(2500),
          accountId: 'momo',
        ),
        isErr('bill.notDue'),
      );
      final other = await w.occurrenceOf('ZESCO');
      expect(
        await w.markPaid(
          occurrenceId: other.id,
          amount: const Money.kwacha(400),
          accountId: 'nowhere',
        ),
        isErr('account.notFound'),
      );
    });
  });

  test('GetBillsCycle totals follow what has been paid (SCREENS 33)', () async {
    var view = ok(await w.billsCycle())!;
    expect(view.rows, hasLength(3));
    expect(view.toPay, const Money.kwacha(3500));
    expect((view.paidCount, view.totalCount), (0, 3));
    expect(view.savingUp.map((s) => s.bill.name), ['School fees']);

    final o = await w.occurrenceOf('Rent');
    ok(
      await w.markPaid(
        occurrenceId: o.id,
        amount: const Money.kwacha(2500),
        accountId: 'cash',
      ),
    );
    view = ok(await w.billsCycle())!;
    expect(view.toPay, const Money.kwacha(1000));
    expect(view.paidTotal, const Money.kwacha(2500));
    expect((view.paidCount, view.totalCount), (1, 3));
  });

  group('fees', () {
    test('learning fills a gap, then asks before changing it', () async {
      final empty = await w.learn(
        provider: AlertSource.mtnMomo,
        feeType: FeeType.send,
        amount: const Money.kwacha(500),
        fee: const Money.kwacha(9),
      );
      expect(ok(empty), isNull);
      final change = ok(
        await w.learn(
          provider: AlertSource.mtnMomo,
          feeType: FeeType.send,
          amount: const Money.kwacha(500),
          fee: const Money.kwacha(11),
        ),
      )!;
      // Nothing changed until the user accepts.
      var band = FeePolicy.bandFor(
        ok(await w.tariffs.find(AlertSource.mtnMomo, FeeType.send)),
        const Money.kwacha(500),
      )!;
      expect(band.fee, const Money.kwacha(9));
      ok(
        await ResolveFeeChange(w.tariffs)(
          provider: AlertSource.mtnMomo,
          feeType: FeeType.send,
          change: change,
          accept: true,
        ),
      );
      band = FeePolicy.bandFor(
        ok(await w.tariffs.find(AlertSource.mtnMomo, FeeType.send)),
        const Money.kwacha(500),
      )!;
      expect(band.fee, const Money.kwacha(11));
    });

    test('bands can be saved, refuse overlaps, and be deleted', () async {
      Future<Result<FeeTariff>> save(int min, int max, int fee) =>
          SaveFeeBand(w.tariffs)(
            provider: AlertSource.airtelMoney,
            feeType: FeeType.send,
            min: Money.kwacha(min),
            max: Money.kwacha(max),
            fee: Money.kwacha(fee),
          );
      ok(await save(1, 100, 1));
      expect(await save(50, 200, 2), isErr('feeTariff.overlap'));
      expect(ok(await save(1, 100, 2)).bands.single.fee, const Money.kwacha(2));
      ok(
        await DeleteFeeBand(w.tariffs)(
          provider: AlertSource.airtelMoney,
          feeType: FeeType.send,
          min: const Money.kwacha(1),
        ),
      );
      expect(
        ok(await w.tariffs.find(AlertSource.airtelMoney, FeeType.send))!.bands,
        isEmpty,
      );
    });

    test(
      'the Fees page adds up fees, missing ones and the share of money moved',
      () async {
        for (final (name, kwacha, fee) in [
          ('Rent', 2500, 18),
          ('Water', 600, null),
        ]) {
          final o = await w.occurrenceOf(name);
          ok(
            await w.markPaid(
              occurrenceId: o.id,
              amount: Money.kwacha(kwacha),
              accountId: 'momo',
              fee: fee == null ? null : Money.kwacha(fee),
            ),
          );
        }
        final s = ok(await w.feesSummary())!;
        expect(s.total, const Money.kwacha(18));
        expect(s.byProvider, {AlertSource.mtnMomo: const Money.kwacha(18)});
        expect(s.byType, {FeeType.billPay: const Money.kwacha(18)});
        expect(s.missingCount, 1);
        // K 18 of K 3,100 moved = 0.58% = 58 basis points.
        expect(s.percentOfMovedBp, 58);
        expect(s.previousTotal, Money.zero);
        expect(
          ok(await ListMissingFees(w.transactions, w.cycle)()),
          hasLength(1),
        );
      },
    );
  });

  group('payday fees (R-FEE-5)', () {
    test('estimates per transfer, then shows the recorded actual', () async {
      final salary = ok(await w.incomes.getAll()).first;
      final payday = await w.startSalary(salary);
      ok(
        await SaveFeeBand(w.tariffs)(
          provider: AlertSource.mtnMomo,
          feeType: FeeType.send,
          min: const Money.kwacha(1),
          max: const Money.kwacha(50000),
          fee: const Money.kwacha(25),
        ),
      );
      final estimate = EstimatePaydayFees(
        w.paydays,
        w.incomes,
        w.accounts,
        w.tariffs,
        w.transactions,
        w.clock,
      );
      var fees = ok(await estimate(payday.id));
      expect(fees.perTransfer, hasLength(payday.transfers.length));
      expect(fees.perTransfer.values.every((f) => !f.isActual), isTrue);
      expect(fees.total, Money.kwacha(25 * payday.transfers.length));

      final first = payday.transfers.first;
      final recorded = ok(
        await w.recordFee(
          paydayId: payday.id,
          transferId: first.id,
          fee: const Money.kwacha(30),
        ),
      )!;
      expect(recorded.feeSource, FeeSource.message);
      fees = ok(await estimate(payday.id));
      expect(
        fees.perTransfer[first.id],
        const TransferFee(Money.kwacha(30), isActual: true),
      );
    });

    test('an unknown rate is unknown, not K 0', () async {
      final payday = await w.startSalary(ok(await w.incomes.getAll()).first);
      final estimate = EstimatePaydayFees(
        w.paydays,
        w.incomes,
        w.accounts,
        w.tariffs,
        w.transactions,
        w.clock,
      );
      expect(
        ok(await estimate(payday.id)).perTransfer.values.map((f) => f.amount),
        everyElement(isNull),
      );
    });
  });
}
