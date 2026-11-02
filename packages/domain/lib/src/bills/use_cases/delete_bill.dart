import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/ports/bill_repository.dart';

/// Removes a bill (screen 03). Money already put aside stays in its bucket.
final class DeleteBill {
  /// Creates the use case.
  const DeleteBill(this._bills);

  final BillRepository _bills;

  /// Removes the bill with [id].
  Future<Result<void>> call(String id) => _bills.delete(id);
}
