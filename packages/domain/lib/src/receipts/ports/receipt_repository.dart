import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/receipts/value_objects/stored_receipt.dart';

/// Stores scanned receipts between scan and save (screens 20–21).
abstract interface class ReceiptRepository {
  /// The receipt with [id], or `NotFoundFailure`.
  Future<Result<StoredReceipt>> get(String id);

  /// Inserts or replaces [receipt].
  Future<Result<void>> save(StoredReceipt receipt);
}
