import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter/services.dart';

/// The MethodChannel for support, about and settings hand-offs. Must match
/// `MainActivity.SUPPORT_CHANNEL` in the app's Android code.
const supportChannelName = 'com.isaaczimba.buckets/support';

const _unavailable = PlatformFailure(
  'support.unavailable',
  "We couldn't open that just now. Try again.",
);

/// [EmailComposer] over a native ACTION_SENDTO intent (R-SUPPORT-1). The app
/// only opens a draft; the user reviews and sends.
final class PlatformEmailComposer implements EmailComposer {
  /// Creates the adapter on [channel] (overridable for tests).
  new({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel(supportChannelName);

  final MethodChannel _channel;

  @override
  Future<Result<void>> compose({
    required String to,
    required String subject,
    required String body,
  }) async {
    try {
      final opened = await _channel.invokeMethod<bool>('composeEmail', {
        'to': to,
        'subject': subject,
        'body': body,
      });
      return (opened ?? false)
          ? const Ok(null)
          : const Err(
              PlatformFailure('email.noApp', 'No email app to send with.'),
            );
    } on PlatformException {
      return const Err(PlatformFailure('email.noApp', 'No email app.'));
    } on MissingPluginException {
      return const Err(PlatformFailure('email.noApp', 'No email app.'));
    }
  }
}

/// [SystemSettingsOpener] over native intents (SCREENS 30, 32).
final class PlatformSystemSettingsOpener implements SystemSettingsOpener {
  /// Creates the adapter on [channel] (overridable for tests).
  new({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel(supportChannelName);

  final MethodChannel _channel;

  Future<Result<void>> _open(String method) async {
    try {
      await _channel.invokeMethod<void>(method);
      return const Ok(null);
    } on PlatformException {
      return const Err(_unavailable);
    } on MissingPluginException {
      return const Err(_unavailable);
    }
  }

  @override
  Future<Result<void>> openNotificationAccess() =>
      _open('openNotificationAccess');

  @override
  Future<Result<void>> openBatterySettings() => _open('openBatterySettings');

  @override
  Future<Result<void>> openStoreListing() => _open('openStoreListing');
}

/// [AppInfoReader] over a native call that returns only the four whitelisted
/// facts (R-SUPPORT-2).
final class PlatformAppInfoReader implements AppInfoReader {
  /// Creates the adapter on [channel] (overridable for tests).
  new({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel(supportChannelName);

  final MethodChannel _channel;

  @override
  Future<Result<AppInfo>> read() async {
    try {
      final map = await _channel.invokeMapMethod<String, Object?>('appInfo');
      if (map == null) return const Err(_unavailable);
      return Ok(
        AppInfo(
          appVersion: (map['appVersion'] ?? '') as String,
          buildNumber: (map['buildNumber'] ?? '') as String,
          androidVersion: (map['androidVersion'] ?? '') as String,
          deviceModel: (map['deviceModel'] ?? '') as String,
        ),
      );
    } on PlatformException {
      return const Err(_unavailable);
    } on MissingPluginException {
      return const Err(_unavailable);
    }
  }
}
