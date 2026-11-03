import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/goals/ports/goal_repository.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';
import 'package:buckets_domain/src/ledger/policies/pay_cycle.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/payday/entities/transfer.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/proof/policies/proof_verifier.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';
import 'package:equatable/equatable.dart';

/// The "payday complete" screen (screen 16).
final class PaydaySummary with Equatable {
  /// Creates a summary.
  const new({
    required this.moved,
    required this.livingLeft,
    required this.guiltFreeLeft,
    required this.perDay,
    required this.streak,
    required this.topGoal,
  });

  /// Total moved to savings this payday.
  final Money moved;

  /// Living left to spend, now unlocked.
  final Money livingLeft;

  /// Guilt-free left to spend, now unlocked.
  final Money guiltFreeLeft;

  /// "About K x a day" for Living, or null (R-LEDGER-5).
  final Money? perDay;

  /// Proven paydays in a row (R-PROOF-5).
  final int streak;

  /// The first goal by order: bucket, balance and target.
  final ({String bucketId, Money balance, Money target})? topGoal;

  @override
  List<Object?> get props => [
    moved,
    livingLeft,
    guiltFreeLeft,
    perDay,
    streak,
    topGoal,
  ];
}

/// Builds the payday-complete summary (screen 16).
final class GetPaydaySummary {
  /// Creates the use case.
  const new({
    required this._paydays,
    required this._ledger,
    required this._buckets,
    required this._goals,
    required this._incomes,
    required this._clock,
    required this._zone,
  });

  final PaydayRepository _paydays;
  final LedgerRepository _ledger;
  final BucketRepository _buckets;
  final GoalRepository _goals;
  final IncomeRepository _incomes;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// The summary for [paydayId].
  Future<Result<PaydaySummary>> call(String paydayId) => attempt(() async {
    final now = _clock.now();
    final offset = _zone.offsetAt(now);
    final payday = unwrap(await _paydays.get(paydayId));
    final entries = unwrap(await _ledger.getEntries());
    final buckets = unwrap(await _buckets.getAll());
    String? idOf(BucketKind kind) =>
        buckets.where((b) => b.kind == kind).firstOrNull?.id;
    Money left(String? id) =>
        id == null ? Money.zero : BalanceCalculator.leftToSpend(entries, id);
    final living = left(idOf(BucketKind.living));
    final salary = unwrap(await _incomes.getAll())
        .where((i) => i.kind == IncomeKind.salary)
        .firstOrNull;
    final cycle = salary == null
        ? null
        : PayCycle.current(
            lastSalaryStartedAt: payday.startedAt,
            setupAt: payday.startedAt,
            salary: salary.schedule,
            now: now,
            utcOffset: offset,
          );
    final goalBucket = buckets.where((b) => b.kind == BucketKind.goal);
    final goal = goalBucket.isEmpty
        ? null
        : unwrap(await _goals.get(goalBucket.first.id));
    return PaydaySummary(
      moved: payday.transfers.fold(Money.zero, (s, t) => s + _moved(t)),
      livingLeft: living,
      guiltFreeLeft: left(idOf(BucketKind.guiltFree)),
      perDay: cycle == null
          ? null
          : BalanceCalculator.perDay(
              living,
              daysLeft: PayCycle.daysLeft(cycle, now: now, utcOffset: offset),
            ),
      streak: ProofVerifier.streak(unwrap(await _paydays.getAll())),
      topGoal: goal == null
          ? null
          : (
              bucketId: goal.bucketId,
              balance: BalanceCalculator.balance(entries, goal.bucketId),
              target: goal.target,
            ),
    );
  });

  static Money _moved(Transfer t) => switch (t.status) {
    TransferStatus.selfReported => t.amount,
    TransferStatus.proven ||
    TransferStatus.partial => t.provenAmount ?? Money.zero,
    TransferStatus.pending => Money.zero,
  };
}
