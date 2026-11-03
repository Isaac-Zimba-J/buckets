import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/use_cases/get_bill_reservations.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/goals/entities/goal.dart';
import 'package:buckets_domain/src/goals/policies/goal_projector.dart';
import 'package:buckets_domain/src/goals/ports/goal_repository.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/local_date.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';
import 'package:buckets_domain/src/shared/streams.dart';
import 'package:buckets_domain/src/split/entities/split_profile.dart';
import 'package:buckets_domain/src/split/policies/split_calculator.dart';
import 'package:buckets_domain/src/split/ports/split_profile_repository.dart';
import 'package:equatable/equatable.dart';

/// A goal card (screen 10).
final class GoalView with Equatable {
  /// Creates a card.
  const GoalView({
    required this.goal,
    required this.name,
    required this.balance,
    required this.monthlyContribution,
    required this.eta,
    required this.celebrate,
  });

  /// The goal.
  final Goal goal;

  /// Its bucket's name.
  final String name;

  /// Saved so far.
  final Money balance;

  /// Expected per month (R-GOAL-1).
  final Money monthlyContribution;

  /// When it will be reached (R-GOAL-2).
  final GoalEta eta;

  /// Show the celebration toast now (R-GOAL-4).
  final bool celebrate;

  @override
  List<Object?> get props => [
    goal,
    name,
    balance,
    monthlyContribution,
    eta,
    celebrate,
  ];
}

/// Goals with progress and ETAs, live (screen 10).
final class WatchGoals {
  /// Creates the use case.
  const WatchGoals({
    required this._goals,
    required this._buckets,
    required this._ledger,
    required this._incomes,
    required this._profiles,
    required this._paydays,
    required this._reservations,
    required this._clock,
    required this._zone,
  });

  final GoalRepository _goals;
  final BucketRepository _buckets;
  final LedgerRepository _ledger;
  final IncomeRepository _incomes;
  final SplitProfileRepository _profiles;
  final PaydayRepository _paydays;
  final GetBillReservations _reservations;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// The goal cards, recomputed when goals or money change.
  Stream<Result<List<GoalView>>> call() =>
      recomputeOn([_goals.watchAll(), _ledger.watchEntries()], _read);

  Future<Result<List<GoalView>>> _read() => attempt(() async {
    final now = _clock.now();
    final offset = _zone.offsetAt(now);
    final entries = unwrap(await _ledger.getEntries());
    final names = {
      for (final b in unwrap(await _buckets.getAll())) b.id: b.name,
    };
    final incomes = unwrap(await _incomes.getAll());
    final salary = incomes
        .where((i) => i.kind == IncomeKind.salary)
        .firstOrNull;
    final (_, bills) = unwrap(await _reservations());
    final salaryToSplit = salary?.expectedAmount == null
        ? null
        : switch (SplitCalculator.amountToSplit(
            income: salary!.expectedAmount!,
            deductBillsFirst: salary.deductBillsFirst,
            billReservations: bills,
          )) {
            Ok(:final value) => value,
            Err() => null,
          };
    final hustles = <SideHustleHistory>[
      for (final h in incomes.where((i) => i.kind == IncomeKind.sideHustle))
        (
          profile: unwrap(await _profiles.get(h.splitProfileId)),
          lastMonths: unwrap(await _monthlyTotals(h.id, now, offset)),
        ),
    ];
    final salaryProfile = salary == null
        ? null
        : unwrap(await _profiles.get(salary.splitProfileId));
    return [
      for (final goal in await _goals.watchAll().first)
        _view(
          goal,
          names,
          entries,
          salaryToSplit,
          salaryProfile,
          hustles,
          now,
          offset,
        ),
    ];
  });

  GoalView _view(
    Goal goal,
    Map<String, String> names,
    List<LedgerEntry> entries,
    Money? salaryToSplit,
    SplitProfile? salaryProfile,
    List<SideHustleHistory> hustles,
    DateTime now,
    Duration offset,
  ) {
    final balance = BalanceCalculator.balance(entries, goal.bucketId);
    final contribution = GoalProjector.monthlyContribution(
      bucketId: goal.bucketId,
      salaryToSplit: salaryToSplit,
      salaryProfile: salaryProfile,
      sideHustles: hustles,
    );
    return GoalView(
      goal: goal,
      name: names[goal.bucketId] ?? '',
      balance: balance,
      monthlyContribution: contribution,
      eta: GoalProjector.eta(
        goal,
        balance: balance,
        monthlyContribution: contribution,
        now: now,
        utcOffset: offset,
      ),
      celebrate: GoalProjector.shouldCelebrate(goal, balance),
    );
  }

  /// A side hustle's totals for the last 3 calendar months before this one,
  /// newest first; empty when it has never paid.
  Future<Result<List<Money>>> _monthlyTotals(
    String incomeId,
    DateTime now,
    Duration offset,
  ) => attempt(() async {
    final paydays = unwrap(
      await _paydays.getAll(),
    ).where((p) => p.incomeSourceId == incomeId).toList();
    if (paydays.isEmpty) return const <Money>[];
    final today = LocalDate.ofInstant(now, offset);
    return [
      for (var back = 1; back <= 3; back++)
        paydays
            .where((p) {
              final d = LocalDate.ofInstant(p.startedAt, offset);
              final m = DateTime.utc(today.year, today.month - back);
              return d.year == m.year && d.month == m.month;
            })
            .fold(Money.zero, (s, p) => s + p.amount),
    ];
  });
}
