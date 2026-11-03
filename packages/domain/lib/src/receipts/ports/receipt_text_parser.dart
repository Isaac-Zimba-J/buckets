import 'package:buckets_domain/src/receipts/value_objects/receipt_draft.dart';

/// Reads OCR text into a [ReceiptDraft] (R-RECEIPT-1).
///
/// Implemented only against redacted OCR fixtures in
/// `test/fixtures/receipts/` (AGENTS.md §5); blocked until they exist.
abstract interface class ReceiptTextParser {
  /// The merchant, date, line items and total in [text], each with a
  /// confidence. Never throws; unreadable text gives an empty draft.
  ReceiptDraft parse(String text, {required Duration utcOffset});
}
