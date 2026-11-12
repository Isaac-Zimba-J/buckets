import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/ledger/use_cases/get_current_cycle.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';

/// Fees this cycle whose amount is unknown, for review (SCREENS 36, R-FEE-2).
final class ListMissingFees {
  /// Creates the use case.
  const new(this._transactions, this._cycle);

  final TransactionRepository _transactions;
  final GetCurrentCycle _cycle;

  /// The `missing` fee transactions of the current cycle, newest first.
  Future<Result<List<Transaction>>> call() => attempt(() async {
    final window = unwrap(await _cycle()).cycle;
    if (window == null) return const [];
    return unwrap(await _transactions.getIn(window))
        .where((t) => t.feeSource == FeeSource.missing)
        .toList()
      ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
  });
}
