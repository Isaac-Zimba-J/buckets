import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/fees/use_cases/get_fees_summary.dart';
import 'package:buckets_domain/src/fees/value_objects/fees_summary.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';

/// [GetFeesSummary], refreshed when transactions change (SCREENS 36 and the
/// "Fees this cycle" card on 33).
final class WatchFeesSummary {
  /// Creates the use case.
  const new(this._transactions, this._get);

  final TransactionRepository _transactions;
  final GetFeesSummary _get;

  /// Emits the summary now and after each new transaction.
  Stream<FeesSummary?> call() => _transactions
      .watchRecent(1)
      .asyncMap(
        (_) async => switch (await _get()) {
          Ok(:final value) => value,
          Err() => null,
        },
      );
}
