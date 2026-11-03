import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/receipts/ports/receipt_repository.dart';
import 'package:buckets_domain/src/receipts/value_objects/receipt_draft.dart';
import 'package:buckets_domain/src/receipts/value_objects/stored_receipt.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Saves the user's edits to a receipt draft (screen 21).
final class UpdateReceiptDraft {
  /// Creates the use case.
  const UpdateReceiptDraft(this._receipts);

  final ReceiptRepository _receipts;

  /// The receipt with [draft].
  Future<Result<StoredReceipt>> call(String receiptId, ReceiptDraft draft) =>
      attempt(() async {
        final updated = unwrap(await _receipts.get(receiptId)).withDraft(draft);
        unwrap(await _receipts.save(updated));
        return updated;
      });
}
