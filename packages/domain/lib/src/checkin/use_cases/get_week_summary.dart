import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/checkin/policies/check_in_flow.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/ledger/use_cases/get_current_cycle.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/date_window.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';

/// The check-in's week summary: the 7 days up to now (R-CHECKIN-1).
final class GetWeekSummary {
  /// Creates the use case.
  const new(
    this._ledger,
    this._transactions,
    this._buckets,
    this._cycle,
    this._clock,
  );

  final LedgerRepository _ledger;
  final TransactionRepository _transactions;
  final BucketRepository _buckets;
  final GetCurrentCycle _cycle;
  final Clock _clock;

  /// The summary.
  Future<Result<WeekSummary>> call() => attempt(() async {
    final end = _clock.now().add(const Duration(seconds: 1));
    final week = unwrap(
      DateWindow.create(end.subtract(const Duration(days: 7)), end),
    );
    final cycle = unwrap(await _cycle()).cycle ?? week;
    return CheckInFlow.weekSummary(
      entries: unwrap(await _ledger.getEntries()),
      transactions: unwrap(await _transactions.getIn(week)),
      buckets: unwrap(await _buckets.getAll()),
      week: week,
      cycle: cycle,
    );
  });
}
