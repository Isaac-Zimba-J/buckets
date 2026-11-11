import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';

/// Why a manual move asks the user to confirm (R-MOVE-2).
enum MoveWarning {
  /// The source is Emergency or Long-term (protected savings).
  fromProtected,

  /// The move drops a saving bucket below its start-of-cycle balance.
  belowCycleStart,
}

/// The rules for moving money between buckets by hand (R-MOVE-1, R-MOVE-2).
abstract final class MovePolicy {
  /// Living and Guilt-free, where "available" is left-to-spend.
  static const Set<BucketKind> _spending = {
    BucketKind.living,
    BucketKind.guiltFree,
  };

  /// The most that can leave [bucket] (R-MOVE-1): left-to-spend for the
  /// spending buckets so reserved bill money stays, otherwise the full
  /// balance. Never below zero.
  static Money available(Bucket bucket, Iterable<LedgerEntry> entries) {
    final raw = _spending.contains(bucket.kind)
        ? BalanceCalculator.leftToSpend(entries, bucket.id)
        : BalanceCalculator.balance(entries, bucket.id);
    return raw.isNegative ? Money.zero : raw;
  }

  /// The confirm the move needs, or null when it is routine (R-MOVE-2).
  /// [cycleStart] is the start of the current pay cycle, or null when the
  /// user has no salary cycle yet.
  static MoveWarning? warningFor({
    required Bucket from,
    required Money amount,
    required Iterable<LedgerEntry> entries,
    required DateTime? cycleStart,
  }) {
    if (from.isProtected) return MoveWarning.fromProtected;
    if (_spending.contains(from.kind) || cycleStart == null) return null;
    final atStart = BalanceCalculator.balance(
      entries.where((e) => e.occurredAt.isBefore(cycleStart)),
      from.id,
    );
    final after = BalanceCalculator.balance(entries, from.id) - amount;
    return after < atStart ? MoveWarning.belowCycleStart : null;
  }
}
