import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

LedgerEntry e(
  String id,
  LedgerEntryKind kind,
  int kwacha, {
  String? bill,
  String? reverses,
  String bucket = 'living',
}) => ok(
  LedgerEntry.create(
    id: id,
    occurredAt: utc,
    kind: kind,
    bucketId: bucket,
    amount: Money.kwacha(kwacha),
    refs: LedgerRefs(billId: bill),
    reversesEntryId: reverses,
  ),
);

void main() {
  final entries = [
    e('split', LedgerEntryKind.allocation, 3080),
    e('rent', LedgerEntryKind.allocation, 2500, bill: 'rent'),
    e('fees1', LedgerEntryKind.allocation, 800, bill: 'fees'),
    e('fees2', LedgerEntryKind.allocation, 800, bill: 'fees'),
    e('food', LedgerEntryKind.spend, -185),
    e('paidRent', LedgerEntryKind.spend, -2600, bill: 'rent'),
  ];

  test('R-BILL-2 put aside per bill, never below K 0', () {
    expect(
      BalanceCalculator.putAsideForBill(entries, 'fees'),
      const Money.kwacha(1600),
    );
    expect(BalanceCalculator.putAsideForBill(entries, 'rent'), Money.zero);
  });

  test('reserved = unpaid bill money in the bucket', () {
    expect(
      BalanceCalculator.reservedForBills(entries, 'living'),
      const Money.kwacha(1600),
    );
    expect(BalanceCalculator.reservedForBills(entries, 'fun'), Money.zero);
  });

  test('R-LEDGER-5 left to spend = balance − reserved bill money', () {
    // 3080 + 2500 + 1600 − 185 − 2600 = 4395; minus 1600 reserved
    expect(
      BalanceCalculator.balance(entries, 'living'),
      const Money.kwacha(4395),
    );
    expect(
      BalanceCalculator.leftToSpend(entries, 'living'),
      const Money.kwacha(2795),
    );
  });

  test('a reversed bill payment puts the money back aside', () {
    final undone = [
      ...entries,
      e(
        'undo',
        LedgerEntryKind.reversal,
        2600,
        bill: 'rent',
        reverses: 'paidRent',
      ),
    ];
    expect(
      BalanceCalculator.putAsideForBill(undone, 'rent'),
      const Money.kwacha(2500),
    );
  });
}
