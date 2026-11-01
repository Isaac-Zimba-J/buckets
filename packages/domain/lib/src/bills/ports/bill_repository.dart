import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/entities/bill.dart';

/// Stores bills.
abstract interface class BillRepository {
  /// Every bill.
  Future<Result<List<Bill>>> getAll();

  /// Inserts or replaces [bill].
  Future<Result<void>> save(Bill bill);

  /// Removes the bill with [id].
  Future<Result<void>> delete(String id);

  /// Every bill, emitting again on change.
  Stream<List<Bill>> watchAll();
}
