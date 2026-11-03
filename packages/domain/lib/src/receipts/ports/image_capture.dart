import 'package:buckets_core/buckets_core.dart';

/// Where a receipt image comes from.
enum CaptureSource {
  /// Take a photo.
  camera,

  /// Pick an existing photo.
  gallery,
}

/// Gets a receipt image into app-private storage (R-RECEIPT-3).
abstract interface class ImageCapture {
  /// The stored image's path, or null when the user cancelled. Fails with
  /// `PermissionFailure` when camera or photo access is denied.
  Future<Result<String?>> capture(CaptureSource source);
}
