import 'dart:math';

import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/goals/entities/goal.dart';
import 'package:buckets_domain/src/shared/local_date.dart';
import 'package:buckets_domain/src/split/entities/split_profile.dart';
import 'package:equatable/equatable.dart';

/// A side hustle's split and its monthly totals, newest first.
typedef SideHustleHistory = ({SplitProfile profile, List<Money> lastMonths});

/// When a goal will be reached (R-GOAL-2).
enum GoalEtaKind {
  /// Balance is at or above target.
  reached,

  /// No split feeds the goal yet.
  notInSplit,

  /// Reached in [GoalEta.months] months.
  inMonths,
}

/// A goal's projected finish (R-GOAL-2).
final class GoalEta with Equatable {
  /// Already reached.
  const new reached() : kind = GoalEtaKind.reached, months = 0, date = null;

  /// "Not in any split yet".
  const new notInSplit()
    : kind = GoalEtaKind.notInSplit,
      months = 0,
      date = null;

  /// Reached in [months] months, around [date].
  const new inMonths(this.months, LocalDate this.date)
    : kind = GoalEtaKind.inMonths;

  /// Which case this is.
  final GoalEtaKind kind;

  /// Months to go, for [GoalEtaKind.inMonths].
  final int months;

  /// The projected date, for [GoalEtaKind.inMonths].
  final LocalDate? date;

  @override
  List<Object?> get props => [kind, months, date];
}

/// Goal maths (DOMAIN §13).
abstract final class GoalProjector {
  /// What [bucketId] gets in a usual month (R-GOAL-1): its share of
  /// [salaryToSplit] plus, for each side hustle, its share of the average of
  /// the last 3 monthly totals (K 0 without history). Shares are floored.
  static Money monthlyContribution({
    required String bucketId,
    required Money? salaryToSplit,
    required SplitProfile? salaryProfile,
    required List<SideHustleHistory> sideHustles,
  }) {
    var total = Money.zero;
    if (salaryToSplit != null && salaryProfile != null) {
      total += _share(salaryProfile, bucketId, salaryToSplit);
    }
    for (final hustle in sideHustles) {
      final months = hustle.lastMonths.take(3).toList();
      if (months.isEmpty) continue;
      final sum = months.fold(Money.zero, (s, m) => s + m);
      total += _share(
        hustle.profile,
        bucketId,
        Money(sum.ngwee ~/ months.length),
      );
    }
    return total;
  }

  static Money _share(SplitProfile profile, String bucketId, Money amount) {
    final allocation = profile.allocations
        .where((a) => a.bucketId == bucketId)
        .firstOrNull;
    return allocation?.bp.applyTo(amount) ?? Money.zero;
  }

  /// now + ceil((target − balance) ÷ contribution) months (R-GOAL-2).
  static GoalEta eta(
    Goal goal, {
    required Money balance,
    required Money monthlyContribution,
    required DateTime now,
    required Duration utcOffset,
  }) {
    if (balance >= goal.target) return const GoalEta.reached();
    if (!monthlyContribution.isPositive) return const GoalEta.notInSplit();
    final left = (goal.target - balance).ngwee;
    final per = monthlyContribution.ngwee;
    final months = (left + per - 1) ~/ per;
    final today = LocalDate.ofInstant(now, utcOffset);
    final target = DateTime.utc(today.year, today.month + months);
    final day = min(
      today.day,
      LocalDate.daysInMonth(target.year, target.month),
    );
    return GoalEta.inMonths(months, LocalDate(target.year, target.month, day));
  }

  /// The default Emergency target: 3 × (monthly bill reservations + Living
  /// allocation) (R-GOAL-3).
  static Money emergencyTarget({
    required Money monthlyBillReservations,
    required Money livingAllocation,
  }) => Money((monthlyBillReservations + livingAllocation).ngwee * 3);

  /// Whether to celebrate now: reached and not celebrated before
  /// (R-GOAL-4).
  static bool shouldCelebrate(Goal goal, Money balance) =>
      goal.celebratedAt == null && balance >= goal.target;
}
