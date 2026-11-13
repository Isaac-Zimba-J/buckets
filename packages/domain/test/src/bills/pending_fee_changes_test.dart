import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fakes/fakes_bills.dart';
import '../../helpers.dart';
import 'bills_fees_use_cases_test.dart' show BillsWorld;

void main() {
  late BillsWorld w;
  late InMemoryPendingFeeChanges pending;
  setUp(() async {
    w = BillsWorld();
    pending = InMemoryPendingFeeChanges();
    await w.canvasSetup();
    ok(await w.ensure());
    ok(
      await SaveFeeBand(w.tariffs)(
        provider: AlertSource.mtnMomo,
        feeType: FeeType.billPay,
        min: const Money.kwacha(1),
        max: const Money.kwacha(5000),
        fee: const Money.kwacha(9),
      ),
    );
  });

  MarkBillPaid markPaid() => MarkBillPaid(
    w.occurrences,
    w.bills,
    w.buckets,
    w.accounts,
    w.tariffs,
    w.spend,
    w.clock,
    w.ids,
    pending,
  );

  test('a bill paid with a different fee in the message is queued', () async {
    await w.startSalary(ok(await w.incomes.getAll()).first);
    final o = await w.occurrenceOf('Rent');
    ok(
      await markPaid()(
        occurrenceId: o.id,
        amount: const Money.kwacha(2500),
        accountId: 'momo',
        fee: const Money.kwacha(12),
        proofRef: 'REF1',
      ),
    );
    final item = pending.items.single;
    expect(item.feeType, FeeType.billPay);
    expect(item.change.newFee, const Money.kwacha(12));
    expect(item.change.band.fee, const Money.kwacha(9));
  });

  test('a fee that matches the saved band queues nothing', () async {
    await w.startSalary(ok(await w.incomes.getAll()).first);
    final o = await w.occurrenceOf('Rent');
    ok(
      await markPaid()(
        occurrenceId: o.id,
        amount: const Money.kwacha(2500),
        accountId: 'momo',
        fee: const Money.kwacha(9),
      ),
    );
    expect(pending.items, isEmpty);
  });

  test('a payday transfer fee that differs from the rate is queued', () async {
    final payday = await w.startSalary(ok(await w.incomes.getAll()).first);
    ok(
      await SaveFeeBand(w.tariffs)(
        provider: AlertSource.mtnMomo,
        feeType: FeeType.send,
        min: const Money.kwacha(1),
        max: const Money.kwacha(50000),
        fee: const Money.kwacha(25),
      ),
    );
    ok(
      await RecordTransferFee(
        w.paydays,
        w.incomes,
        w.accounts,
        w.buckets,
        w.tariffs,
        w.learn,
        w.spend,
        w.clock,
        w.ids,
        pending,
      )(
        paydayId: payday.id,
        transferId: payday.transfers.first.id,
        fee: const Money.kwacha(30),
      ),
    );
    expect(pending.items.single.feeType, FeeType.send);
    expect(pending.items.single.change.newFee, const Money.kwacha(30));
  });

  test('resolving a change, either way, clears it', () async {
    final change = ok(
      await w.learn(
        provider: AlertSource.mtnMomo,
        feeType: FeeType.billPay,
        amount: const Money.kwacha(100),
        fee: const Money.kwacha(11),
      ),
    )!;
    final item = PendingFeeChange(AlertSource.mtnMomo, FeeType.billPay, change);
    for (final accept in [false, true]) {
      ok(await pending.add(item));
      ok(
        await ResolveFeeChange(w.tariffs, pending)(
          provider: AlertSource.mtnMomo,
          feeType: FeeType.billPay,
          change: change,
          accept: accept,
        ),
      );
      expect(pending.items, isEmpty, reason: 'accept: $accept');
    }
  });

  test("GetBillFees sums this year's fees for one bill", () async {
    await w.startSalary(ok(await w.incomes.getAll()).first);
    final rent = await w.occurrenceOf('Rent');
    final zesco = await w.occurrenceOf('ZESCO');
    final fees = GetBillFees(w.occurrences, w.transactions, w.clock, w.zone);
    expect(ok(await fees(rent.billId)), Money.zero);
    for (final (o, kwacha) in [(rent, 18), (zesco, 4)]) {
      ok(
        await w.markPaid(
          occurrenceId: o.id,
          amount: o.expectedAmount,
          accountId: 'momo',
          fee: Money.kwacha(kwacha),
        ),
      );
    }
    expect(ok(await fees(rent.billId)), const Money.kwacha(18));
  });
}
