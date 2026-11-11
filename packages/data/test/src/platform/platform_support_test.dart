import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/platform/platform_support.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel(supportChannelName);
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  void answer(Object? Function(MethodCall call) reply) =>
      messenger.setMockMethodCallHandler(channel, (c) async => reply(c));

  group('PlatformEmailComposer', () {
    final email = PlatformEmailComposer();

    test('passes to/subject/body and succeeds when a draft opens', () async {
      MethodCall? seen;
      answer((c) {
        seen = c;
        return true;
      });
      final result = await email.compose(
        to: 'help@example.test',
        subject: 'Buckets — problem report',
        body: 'Crash on open',
      );
      expect(result, isA<Ok<void>>());
      expect(seen!.method, 'composeEmail');
      final args = seen!.arguments as Map<Object?, Object?>;
      expect(args['to'], 'help@example.test');
      expect(args['subject'], 'Buckets — problem report');
      expect(args['body'], 'Crash on open');
    });

    test('no email app → email.noApp', () async {
      answer((_) => false);
      expect(
        await email.compose(to: 'a@b.c', subject: 's', body: 'b'),
        isA<Err<void>>().having((e) => e.failure.code, 'code', 'email.noApp'),
      );
    });

    test('a platform error → email.noApp', () async {
      answer((_) => throw PlatformException(code: 'boom'));
      expect(
        await email.compose(to: 'a@b.c', subject: 's', body: 'b'),
        isA<Err<void>>().having((e) => e.failure.code, 'code', 'email.noApp'),
      );
    });
  });

  group('PlatformSystemSettingsOpener', () {
    final opener = PlatformSystemSettingsOpener();

    test('each method invokes its channel call', () async {
      final calls = <String>[];
      answer((c) {
        calls.add(c.method);
        return null;
      });
      expect(await opener.openNotificationAccess(), isA<Ok<void>>());
      expect(await opener.openBatterySettings(), isA<Ok<void>>());
      expect(await opener.openStoreListing(), isA<Ok<void>>());
      expect(calls, [
        'openNotificationAccess',
        'openBatterySettings',
        'openStoreListing',
      ]);
    });

    test('a platform error → support.unavailable', () async {
      answer((_) => throw PlatformException(code: 'boom'));
      expect(
        await opener.openStoreListing(),
        isA<Err<void>>().having(
          (e) => e.failure.code,
          'code',
          'support.unavailable',
        ),
      );
    });
  });

  group('PlatformAppInfoReader', () {
    final reader = PlatformAppInfoReader();

    test('maps only the four whitelisted facts', () async {
      answer(
        (_) => {
          'appVersion': '1.0.0',
          'buildNumber': '42',
          'androidVersion': '14',
          'deviceModel': 'Tecno Spark 10',
        },
      );
      final info = (await reader.read() as Ok<AppInfo>).value;
      expect(info.appVersion, '1.0.0');
      expect(info.buildNumber, '42');
      expect(info.androidVersion, '14');
      expect(info.deviceModel, 'Tecno Spark 10');
    });

    test('a platform error → support.unavailable', () async {
      answer((_) => throw PlatformException(code: 'boom'));
      expect(
        await reader.read(),
        isA<Err<AppInfo>>().having(
          (e) => e.failure.code,
          'code',
          'support.unavailable',
        ),
      );
    });
  });
}
