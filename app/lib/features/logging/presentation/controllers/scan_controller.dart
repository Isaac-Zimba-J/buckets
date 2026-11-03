import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scan_controller.freezed.dart';
part 'scan_controller.g.dart';

/// Screen 20 Scan receipt.
@freezed
sealed class ScanState with _$ScanState {
  /// The camera view.
  const factory ScanState.camera() = ScanCamera;

  /// Reading the photo (skeleton).
  const factory ScanState.processing() = ScanProcessing;

  /// "No text found": banner with retake.
  const factory ScanState.noText() = ScanNoText;

  /// Camera or photo access denied.
  const factory ScanState.permissionDenied() = ScanPermissionDenied;

  /// Read: go to review (screen 21).
  const factory ScanState.recognized({required String receiptId}) =
      ScanRecognized;
}

/// Screen 20 Scan receipt.
@riverpod
class ScanController extends _$ScanController {
  @override
  ScanState build() => const ScanState.camera();

  /// Takes or picks a photo and reads it.
  Future<void> capture(CaptureSource source) async {
    final photo = await ref.read(captureReceiptImageProvider)(source);
    switch (photo) {
      case Err(failure: PermissionFailure()):
        state = const ScanState.permissionDenied();
        return;
      case Err() || Ok(value: null):
        state = const ScanState.camera();
        return;
      case Ok(value: final String path):
        state = const ScanState.processing();
        final read = await ref.read(recognizeReceiptProvider)(path);
        state = switch (read) {
          Ok(:final value) => ScanState.recognized(receiptId: value.id),
          Err() => const ScanState.noText(),
        };
    }
  }

  /// Back to the camera after an error.
  void retake() => state = const ScanState.camera();
}
