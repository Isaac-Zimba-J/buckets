import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/date_window.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';

/// Stores spending transactions.
abstract interface class TransactionRepository {
  /// The transaction with [id], or `NotFoundFailure`.
  Future<Result<Transaction>> get(String id);

  /// Inserts or replaces [transaction].
  Future<Result<void>> save(Transaction transaction);

  /// Transactions inside [window], in occurrence order.
  Future<Result<List<Transaction>>> getIn(DateWindow window);

  /// The latest [limit] transactions, newest first, emitting on change.
  Stream<List<Transaction>> watchRecent(int limit);
}
