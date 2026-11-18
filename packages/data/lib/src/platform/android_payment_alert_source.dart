import 'dart:async';

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

  /// Broadcast stream that emits when new payment alerts are queued on the
  /// native side. Used for live ingest while the app is running.
  late final Stream<void> queued = _QueuedStream(_channel).broadcast;

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

/// Internal stream that lazily attaches a method call handler for "queued".
final class _QueuedStream {
  _QueuedStream(this._channel);

  final MethodChannel _channel;
  late final _controller = StreamController<void>.broadcast(
    onListen: _attachHandler,
    onCancel: _detachHandler,
  );

  Stream<void> get broadcast => _controller.stream;

  void _attachHandler() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'queued') {
        _controller.add(null);
      }
    });
  }

  void _detachHandler() {
    _channel.setMethodCallHandler(null);
  }
}
