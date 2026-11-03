import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter/services.dart';

/// [PaymentAlertSource] over the native notification listener in the app's
/// Android code (ARCHITECTURE §6). Also reports and opens notification
/// access, which the listener needs.
final class AndroidPaymentAlertSource implements PaymentAlertSource {
  /// Creates the source on [channel] (overridable for tests).
  new({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel(channelName);

  /// Must match `MainActivity.CHANNEL` in the app's Android code.
  static const channelName = 'com.isaaczimba.buckets/payment_alerts';

  final MethodChannel _channel;

  static const _failed = PlatformFailure(
    'alerts.unavailable',
    "We couldn't read payment notifications. Try again.",
  );

  @override
  Future<Result<List<IncomingAlertText>>> drain() async {
    try {
      final raw = await _channel.invokeListMethod<Object?>('drain') ?? [];
      return Ok([
        for (final item in raw.cast<Map<Object?, Object?>>())
          IncomingAlertText(
            packageName: item['package']! as String,
            text: item['text']! as String,
            receivedAt: DateTime.fromMillisecondsSinceEpoch(
              item['postedAt']! as int,
              isUtc: true,
            ),
          ),
      ]);
    } on PlatformException {
      return const Err(_failed);
    } on MissingPluginException {
      // No native side (tests, non-Android): nothing captured.
      return const Ok([]);
    }
  }

  /// Whether the user has granted notification access to Buckets.
  Future<Result<bool>> isEnabled() async {
    try {
      return Ok(await _channel.invokeMethod<bool>('isEnabled') ?? false);
    } on PlatformException {
      return const Err(_failed);
    } on MissingPluginException {
      return const Ok(false);
    }
  }

  /// Opens Android's notification access settings.
  Future<Result<void>> openSettings() async {
    try {
      await _channel.invokeMethod<void>('openSettings');
      return const Ok(null);
    } on PlatformException {
      return const Err(_failed);
    } on MissingPluginException {
      return const Err(_failed);
    }
  }
}
