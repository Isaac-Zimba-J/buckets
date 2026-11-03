import 'dart:io';

import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/platform/image_picker_capture.dart';
import 'package:buckets_data/src/platform/ml_kit_text_recognizer.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeOcr implements OcrApi {
  String text = '[OCR TEXT]';
  bool fails = false;

  @override
  Future<String> recognize(String path) async {
    if (fails) throw PlatformException(code: 'mlkit');
    return text;
  }
}

class FakePhotos implements PhotoApi {
  new(this.dir);

  final Directory dir;
  String? picked;
  PlatformException? throws;
  CaptureSource? lastSource;

  @override
  Future<String?> pick(CaptureSource source) async {
    lastSource = source;
    if (throws case final e?) throw e;
    return picked;
  }

  @override
  Future<Directory> receiptsDirectory() =>
      Directory('${dir.path}/receipts').create(recursive: true);
}

class Ids implements IdGenerator {
  @override
  String newId() => 'r1';
}

void main() {
  group('MlKitTextRecognizer', () {
    test('returns the recognised text', () async {
      final r = MlKitTextRecognizer(api: FakeOcr());
      expect((await r.recognize('/x.jpg') as Ok<String>).value, '[OCR TEXT]');
    });

    test('a native error is a PlatformFailure', () async {
      final r = MlKitTextRecognizer(api: FakeOcr()..fails = true);
      expect((await r.recognize('/x.jpg') as Err).failure.code, 'ocr.failed');
    });
  });

  group('ImagePickerCapture', () {
    late Directory temp;
    late FakePhotos photos;
    late ImagePickerCapture capture;
    setUp(() async {
      temp = await Directory.systemTemp.createTemp('buckets_capture');
      photos = FakePhotos(temp);
      capture = ImagePickerCapture(ids: Ids(), api: photos);
    });
    tearDown(() => temp.delete(recursive: true));

    test('copies the photo into app-private receipts (R-RECEIPT-3)', () async {
      final original = File('${temp.path}/cache.jpg')..writeAsBytesSync([1, 2]);
      photos.picked = original.path;
      final path =
          (await capture.capture(CaptureSource.camera) as Ok<String?>).value!;
      expect(path, '${temp.path}/receipts/r1.jpg');
      expect(File(path).readAsBytesSync(), [1, 2]);
      expect(photos.lastSource, CaptureSource.camera);
    });

    test('a cancelled pick is null', () async {
      expect(
        (await capture.capture(CaptureSource.gallery) as Ok<String?>).value,
        isNull,
      );
    });

    test('denied access is a PermissionFailure', () async {
      photos.throws = PlatformException(code: 'camera_access_denied');
      final result = await capture.capture(CaptureSource.camera);
      expect(result, isA<Err<String?>>());
      expect((result as Err).failure, isA<PermissionFailure>());
    });

    test('other errors are safe failures', () async {
      photos.throws = PlatformException(code: 'other');
      expect(
        (await capture.capture(CaptureSource.camera) as Err).failure.code,
        'capture.failed',
      );
      photos
        ..throws = null
        ..picked = '${temp.path}/missing.jpg';
      expect(
        (await capture.capture(CaptureSource.camera) as Err).failure.code,
        'capture.save',
      );
    });
  });
}
