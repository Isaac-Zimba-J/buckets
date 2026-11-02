import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';
import 'package:buckets_domain/src/shared/date_window.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';
import 'package:equatable/equatable.dart';

/// A step of the Sunday check-in (R-CHECKIN-1).
enum CheckInStep {
  /// Sort unsorted alerts.
  sort,

  /// Count cash.
  count,

  /// Week summary.
  summary,
}

/// What to ask after counting cash.
enum GapPrompt {
  /// Counted matches expected.
  none,

  /// Less cash than expected: log it or record it as Untracked (R-CASH-2).
  missingCash,

  /// More cash than expected: "Did you receive cash?" (R-CASH-3).
  receivedCash,
}

/// The week summary shown at the end of the check-in (R-CHECKIN-1).
final class WeekSummary with Equatable {
  /// Creates a summary.
  const WeekSummary({
    required this.spentByBucket,
    required this.savedThisCycle,
    required this.untrackedTotal,
  });

  /// Spent this week per bucket, only buckets that spent.
  final Map<String, Money> spentByBucket;

  /// Allocated to saving buckets this cycle, excluding bill money.
  final Money savedThisCycle;

  /// Cash recorded as Untracked this week.
  final Money untrackedTotal;

  @override
  List<Object?> get props => [spentByBucket, savedThisCycle, untrackedTotal];
}

/// The Sunday check-in (DOMAIN §15).
abstract final class CheckInFlow {
  /// Sort (only when alerts are waiting), count, then summary.
  static List<CheckInStep> steps({required int unsortedAlerts}) => [
    if (unsortedAlerts > 0) CheckInStep.sort,
    CheckInStep.count,
    CheckInStep.summary,
  ];

  /// What to ask for a gap of expected − counted.
  static GapPrompt gapPrompt(Money gap) => gap.isPositive
      ? GapPrompt.missingCash
      : gap.isNegative
      ? GapPrompt.receivedCash
      : GapPrompt.none;

  /// Spent per bucket in [week], saved in [cycle], and Untracked in [week].
  /// Saving buckets are every bucket except Living and Guilt-free.
  static WeekSummary weekSummary({
    required List<LedgerEntry> entries,
    required List<Transaction> transactions,
    required List<Bucket> buckets,
    required DateWindow week,
    required DateWindow cycle,
  }) {
    final spent = <String, Money>{
      for (final b in buckets)
        b.id: BalanceCalculator.cycleSpend(entries, b.id, week),
    }..removeWhere((_, m) => m.isZero);
    const spending = {BucketKind.living, BucketKind.guiltFree};
    final saving = {
      for (final b in buckets)
        if (!spending.contains(b.kind)) b.id,
    };
    final saved = entries
        .where(
          (e) =>
              e.kind == LedgerEntryKind.allocation &&
              e.refs.billId == null &&
              saving.contains(e.bucketId) &&
              cycle.contains(e.occurredAt),
        )
        .fold(Money.zero, (s, e) => s + e.amount);
    final untracked = transactions
        .where(
          (t) =>
              t.category == Category.untracked && week.contains(t.occurredAt),
        )
        .fold(Money.zero, (s, t) => s + t.amount);
    return WeekSummary(
      spentByBucket: spent,
      savedThisCycle: saved,
      untrackedTotal: untracked,
    );
  }
}
