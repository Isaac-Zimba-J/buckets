import 'package:buckets_domain/src/receipts/value_objects/receipt_draft.dart';
import 'package:equatable/equatable.dart';

/// A scanned receipt waiting for review (screens 20–21).
final class StoredReceipt with Equatable {
  /// Creates a stored draft.
  const new({required this.id, required this.imagePath, required this.draft});

  /// Unique ID; the transaction's `receiptId` once saved.
  final String id;

  /// The image in app-private storage (R-RECEIPT-3).
  final String imagePath;

  /// What OCR read, as edited so far.
  final ReceiptDraft draft;

  /// This receipt with [draft].
  StoredReceipt withDraft(ReceiptDraft draft) =>
      StoredReceipt(id: id, imagePath: imagePath, draft: draft);

  @override
  List<Object?> get props => [id, imagePath, draft];
}
