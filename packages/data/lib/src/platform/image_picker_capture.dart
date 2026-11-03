import 'dart:io';

import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// Takes or picks a photo; a seam over image_picker for tests.
abstract interface class PhotoApi {
  /// A temporary path to the photo, or null if cancelled.
  Future<String?> pick(CaptureSource source);

  /// The app-private folder receipts are kept in (R-RECEIPT-3).
  Future<Directory> receiptsDirectory();
}

/// [PhotoApi] over image_picker and path_provider.
final class ImagePickerPhotoApi implements PhotoApi {
  /// Creates the API.
  new();

  final _picker = ImagePicker();

  @override
  Future<String?> pick(CaptureSource source) async => (await _picker.pickImage(
    source: source == CaptureSource.camera
        ? ImageSource.camera
        : ImageSource.gallery,
    // Enough detail for OCR, without filling the phone.
    maxWidth: 2000,
    imageQuality: 85,
  ))?.path;

  @override
  Future<Directory> receiptsDirectory() async {
    final docs = await getApplicationDocumentsDirectory();
    return await Directory('${docs.path}/receipts').create(recursive: true);
  }
}

/// [ImageCapture] that keeps receipt photos in app-private storage; they
/// are never uploaded (R-RECEIPT-3).
final class ImagePickerCapture implements ImageCapture {
  /// Creates the capture; [_ids] names the stored files.
  new({required this._ids, PhotoApi? api})
    : _api = api ?? ImagePickerPhotoApi();

  final IdGenerator _ids;
  final PhotoApi _api;

  @override
  Future<Result<String?>> capture(CaptureSource source) async {
    try {
      final picked = await _api.pick(source);
      if (picked == null) return const Ok(null);
      final dir = await _api.receiptsDirectory();
      final stored = await File(picked).copy('${dir.path}/${_ids.newId()}.jpg');
      return Ok(stored.path);
    } on PlatformException catch (e) {
      return Err(
        e.code.contains('access_denied')
            ? const PermissionFailure(
                'camera',
                'Allow camera and photo access to scan receipts.',
              )
            : const PlatformFailure(
                'capture.failed',
                "Couldn't get the photo.",
              ),
      );
    } on FileSystemException {
      return const Err(
        StorageFailure('capture.save', "Couldn't save the photo. Try again."),
      );
    }
  }
}
