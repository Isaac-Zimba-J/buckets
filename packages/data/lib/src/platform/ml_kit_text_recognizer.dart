import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart' as domain;
import 'package:flutter/services.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'
    as mlkit;

/// Reads text from an image; a seam over ML Kit for tests.
abstract interface class OcrApi {
  /// The text in the image at [path], top to bottom.
  Future<String> recognize(String path);
}

/// [OcrApi] over ML Kit's bundled Latin model: on-device only, no
/// download and no network (ADR-0004, R-RECEIPT-3).
final class MlKitOcrApi implements OcrApi {
  /// Creates the API.
  new();

  final _recognizer = mlkit.TextRecognizer();

  @override
  Future<String> recognize(String path) async =>
      (await _recognizer.processImage(mlkit.InputImage.fromFilePath(path)))
          .text;

  /// Releases the native recognizer.
  Future<void> close() => _recognizer.close();
}

/// [domain.TextRecognizer] on ML Kit.
final class MlKitTextRecognizer implements domain.TextRecognizer {
  /// Creates the recognizer.
  new({OcrApi? api}) : _api = api ?? MlKitOcrApi();

  final OcrApi _api;

  @override
  Future<Result<String>> recognize(String imagePath) async {
    try {
      return Ok(await _api.recognize(imagePath));
    } on PlatformException {
      return const Err(
        PlatformFailure(
          'ocr.failed',
          "We couldn't read this photo. Try again with more light.",
        ),
      );
    }
  }
}
