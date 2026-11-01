import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/shared/date_window.dart';

/// Derives balances from the ledger; balances are never stored
/// (R-BUCKET-4, DOMAIN §6).
abstract final class BalanceCalculator {
  /// The sum of [bucketId]'s entries (R-LEDGER-2).
  static Money balance(Iterable<LedgerEntry> entries, String bucketId) =>
      _sum(entries.where((e) => e.bucketId == bucketId));

  /// Every bucket's balance, keyed by bucket ID.
  static Map<String, Money> balances(Iterable<LedgerEntry> entries) {
    final result = <String, Money>{};
    for (final e in entries) {
      result.update(
        e.bucketId,
        (sum) => sum + e.amount,
        ifAbsent: () => e.amount,
      );
    }
    return result;
  }

  /// What [bucketId] spent in [cycle]: −(its `spend` entries in the cycle),
  /// with reversed spends netted out of the cycle they were spent in
  /// (R-LEDGER-2, owner decision).
  static Money cycleSpend(
    Iterable<LedgerEntry> entries,
    String bucketId,
    DateWindow cycle,
  ) {
    final spends = {
      for (final e in entries)
        if (e.bucketId == bucketId &&
            e.kind == LedgerEntryKind.spend &&
            cycle.contains(e.occurredAt))
          e.id: e,
    };
    final reversals = entries.where(
      (e) =>
          e.kind == LedgerEntryKind.reversal &&
          spends.containsKey(e.reversesEntryId),
    );
    return -_sum([...spends.values, ...reversals]);
  }

  /// "About K x a day": floor([balance] ÷ [daysLeft], at least 1 day), or
  /// null unless [balance] is above K 0 (R-LEDGER-5).
  static Money? perDay(Money balance, {required int daysLeft}) {
    if (!balance.isPositive) return null;
    return Money(balance.ngwee ~/ (daysLeft < 1 ? 1 : daysLeft));
  }

  /// Money put aside for [billId] and not yet paid, never below K 0
  /// (R-BILL-2). Counts every entry tagged with the bill.
  static Money putAsideForBill(Iterable<LedgerEntry> entries, String billId) {
    final sum = _sum(entries.where((e) => e.refs.billId == billId));
    return sum.isNegative ? Money.zero : sum;
  }

  /// Unpaid bill money held in [bucketId] (owner decision, R-LEDGER-5).
  static Money reservedForBills(
    Iterable<LedgerEntry> entries,
    String bucketId,
  ) {
    final inBucket = entries.where((e) => e.bucketId == bucketId).toList();
    final bills = {for (final e in inBucket) ?e.refs.billId};
    return bills.fold(
      Money.zero,
      (sum, bill) => sum + putAsideForBill(inBucket, bill),
    );
  }

  /// "Left to spend": [bucketId]'s balance minus its unpaid bill money
  /// (R-LEDGER-5).
  static Money leftToSpend(Iterable<LedgerEntry> entries, String bucketId) =>
      balance(entries, bucketId) - reservedForBills(entries, bucketId);

  static Money _sum(Iterable<LedgerEntry> entries) =>
      entries.fold(Money.zero, (sum, e) => sum + e.amount);
}
