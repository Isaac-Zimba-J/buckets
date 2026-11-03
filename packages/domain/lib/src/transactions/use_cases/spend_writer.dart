import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/policies/spending_policy.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';

/// Saves spending: the transaction, its fee as its own transaction
/// (R-SPEND-2), and one spend entry per bucket (R-SPEND-1). Shared by the
/// logging use cases.
final class SpendWriter {
  /// Creates the writer.
  const new(this._transactions, this._ledger, this._ids);

  final TransactionRepository _transactions;
  final LedgerRepository _ledger;
  final IdGenerator _ids;

  /// Saves [transaction] and, if [fee] is above K 0, its fee.
  Future<Result<Transaction>> write(Transaction transaction, {Money? fee}) =>
      attempt(() async {
        final all = [
          transaction,
          if (fee != null && fee.isPositive)
            unwrap(
              SpendingPolicy.feeTransaction(
                transaction,
                fee: fee,
                id: _ids.newId(),
              ),
            ),
        ];
        final entries = [
          for (final t in all)
            ...unwrap(SpendingPolicy.spendEntries(t, ids: _ids)),
        ];
        for (final t in all) {
          unwrap(await _transactions.save(t));
        }
        unwrap(await _ledger.append(entries));
        return transaction;
      });
}
