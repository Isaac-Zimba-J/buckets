import 'package:buckets_core/buckets_core.dart';

/// On-device OCR. Nothing leaves the phone (R-RECEIPT-3).
// ignore: one_member_abstracts, it is a port that data implements and tests fake.
abstract interface class TextRecognizer {
  /// The text in the image at [imagePath], top to bottom; empty when none
  /// was found.
  Future<Result<String>> recognize(String imagePath);
}
