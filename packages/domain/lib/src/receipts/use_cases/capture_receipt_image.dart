import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/receipts/ports/image_capture.dart';

/// Takes or picks a receipt photo (screen 20).
final class CaptureReceiptImage {
  /// Creates the use case.
  const new(this._capture);

  final ImageCapture _capture;

  /// The stored image path, or null if the user cancelled.
  Future<Result<String?>> call(CaptureSource source) =>
      _capture.capture(source);
}
