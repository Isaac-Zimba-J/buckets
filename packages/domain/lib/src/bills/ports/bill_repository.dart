import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/entities/bill.dart';

/// Stores bills.
abstract interface class BillRepository {
  /// Every bill.
  Future<Result<List<Bill>>> getAll();

  /// The bill with [id], or `NotFoundFailure`.
  Future<Result<Bill>> get(String id);

  /// Inserts or replaces [bill].
  Future<Result<void>> save(Bill bill);

  /// Removes the bill with [id].
  Future<Result<void>> delete(String id);

  /// Every bill, emitting again on change.
  Stream<List<Bill>> watchAll();
}
