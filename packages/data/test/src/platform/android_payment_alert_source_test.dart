import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/platform/android_payment_alert_source.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel(AndroidPaymentAlertSource.channelName);
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  final source = AndroidPaymentAlertSource();
  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  void answer(Object? Function(MethodCall call) reply) =>
      messenger.setMockMethodCallHandler(channel, (c) async => reply(c));

  test('drain turns native captures into UTC alert texts', () async {
    answer(
      (_) => [
        {
          'package': 'test.momo',
          'text': '[MESSAGE]',
          'postedAt': 1793000000000,
        },
      ],
    );
    final result = await source.drain();
    final [item] = (result as Ok<List<IncomingAlertText>>).value;
    expect(item.packageName, 'test.momo');
    expect(item.text, '[MESSAGE]');
    expect(item.receivedAt.isUtc, isTrue);
    expect(item.receivedAt.millisecondsSinceEpoch, 1793000000000);
  });

  test('an empty queue drains to nothing', () async {
    answer((_) => <Object?>[]);
    expect(
      (await source.drain() as Ok<List<IncomingAlertText>>).value,
      isEmpty,
    );
  });

  test('a platform error is a safe PlatformFailure', () async {
    answer((_) => throw PlatformException(code: 'boom'));
    final result = await source.drain();
    expect(result, isA<Err<List<IncomingAlertText>>>());
    expect((result as Err).failure.code, 'alerts.unavailable');
  });

  test('without a native side nothing is captured', () async {
    expect(
      (await source.drain() as Ok<List<IncomingAlertText>>).value,
      isEmpty,
    );
    expect((await source.isEnabled() as Ok<bool>).value, isFalse);
  });

  test('notification access status and settings', () async {
    final calls = <String>[];
    answer((c) {
      calls.add(c.method);
      return c.method == 'isEnabled' ? true : null;
    });
    expect((await source.isEnabled() as Ok<bool>).value, isTrue);
    expect(await source.openSettings(), isA<Ok<void>>());
    expect(calls, ['isEnabled', 'openSettings']);
  });
}
