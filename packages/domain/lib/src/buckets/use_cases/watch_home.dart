import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/ledger/use_cases/get_current_cycle.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/payday/policies/payday_planner.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/streams.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';
import 'package:equatable/equatable.dart';

/// Everything Home shows (screens 07–08).
final class HomeData with Equatable {
  /// Creates the data.
  const new({
    required this.cycle,
    required this.buckets,
    required this.balances,
    required this.livingLeft,
    required this.perDay,
    required this.guiltFreeLeft,
    required this.unlocked,
    required this.openPayday,
    required this.unsortedCount,
    required this.recent,
  });

  /// Cycle info; `hadPayday` false means the first-run variant (07).
  final CycleInfo cycle;

  /// Active buckets in order.
  final List<Bucket> buckets;

  /// Every bucket's balance (R-LEDGER-2).
  final Map<String, Money> balances;

  /// Living left to spend (R-LEDGER-5).
  final Money livingLeft;

  /// "About K x a day", or null (R-LEDGER-5).
  final Money? perDay;

  /// Guilt-free left to spend.
  final Money guiltFreeLeft;

  /// No lock note on Living and Guilt-free (R-PAY-5).
  final bool unlocked;

  /// The open payday, for the alarm banner.
  final Payday? openPayday;

  /// "N payments to sort".
  final int unsortedCount;

  /// Latest transactions.
  final List<Transaction> recent;

  @override
  List<Object?> get props => [
    cycle,
    buckets,
    balances,
    livingLeft,
    perDay,
    guiltFreeLeft,
    unlocked,
    openPayday,
    unsortedCount,
    recent,
  ];
}

/// Home, live (screens 07–08).
final class WatchHome {
  /// Creates the use case.
  const new({
    required this._ledger,
    required this._buckets,
    required this._paydays,
    required this._alerts,
    required this._transactions,
    required this._cycle,
  });

  final LedgerRepository _ledger;
  final BucketRepository _buckets;
  final PaydayRepository _paydays;
  final AlertRepository _alerts;
  final TransactionRepository _transactions;
  final GetCurrentCycle _cycle;

  /// How many recent transactions Home lists.
  static const recentCount = 5;

  /// Home data, recomputed whenever money, paydays or alerts change.
  Stream<Result<HomeData>> call() => recomputeOn([
    _ledger.watchEntries(),
    _buckets.watchAll(),
    _paydays.watchOpen(),
    _alerts.watchByStatus(AlertStatus.newAlert),
    _transactions.watchRecent(recentCount),
  ], _read);

  Future<Result<HomeData>> _read() => attempt(() async {
    final entries = unwrap(await _ledger.getEntries());
    final buckets = unwrap(await _buckets.getAll())
        .where((b) => !b.archived)
        .toList();
    String? idOf(BucketKind kind) =>
        buckets.where((b) => b.kind == kind).firstOrNull?.id;
    Money left(String? id) =>
        id == null ? Money.zero : BalanceCalculator.leftToSpend(entries, id);
    final cycle = unwrap(await _cycle());
    final living = left(idOf(BucketKind.living));
    final open = await _paydays.watchOpen().first;
    return HomeData(
      cycle: cycle,
      buckets: buckets,
      balances: BalanceCalculator.balances(entries),
      livingLeft: living,
      perDay: cycle.daysLeft == null
          ? null
          : BalanceCalculator.perDay(living, daysLeft: cycle.daysLeft!),
      guiltFreeLeft: left(idOf(BucketKind.guiltFree)),
      unlocked: PaydayPlanner.isUnlocked(open),
      openPayday: open,
      unsortedCount:
          (await _alerts.watchByStatus(AlertStatus.newAlert).first).length,
      recent: await _transactions.watchRecent(recentCount).first,
    );
  });
}
