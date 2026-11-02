import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/receipts/ports/receipt_repository.dart';
import 'package:buckets_domain/src/receipts/ports/receipt_text_parser.dart';
import 'package:buckets_domain/src/receipts/ports/text_recognizer.dart';
import 'package:buckets_domain/src/receipts/value_objects/stored_receipt.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';

/// Reads a receipt photo into a draft (screen 20, R-RECEIPT-1).
final class RecognizeReceipt {
  /// Creates the use case.
  const RecognizeReceipt({
    required this._recognizer,
    required this._parser,
    required this._receipts,
    required this._ids,
    required this._clock,
    required this._zone,
  });

  final TextRecognizer _recognizer;
  final ReceiptTextParser _parser;
  final ReceiptRepository _receipts;
  final IdGenerator _ids;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// The stored draft; fails with `receipt.noText` when OCR finds nothing
  /// (the "no text found" state).
  Future<Result<StoredReceipt>> call(String imagePath) => attempt(() async {
    final text = unwrap(await _recognizer.recognize(imagePath));
    if (text.trim().isEmpty) {
      unwrap<void>(
        const Err(
          PlatformFailure(
            'receipt.noText',
            "We couldn't find any text. Try again with more light.",
          ),
        ),
      );
    }
    final receipt = StoredReceipt(
      id: _ids.newId(),
      imagePath: imagePath,
      draft: _parser.parse(text, utcOffset: _zone.offsetAt(_clock.now())),
    );
    unwrap(await _receipts.save(receipt));
    return receipt;
  });
}
