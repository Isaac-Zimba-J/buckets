import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/platform/android_payment_alert_source.dart';
import 'package:buckets_data/src/platform/notifications_api.dart';
import 'package:buckets_domain/buckets_domain.dart';

/// [PermissionGateway] for Android (screen 06), over the notifications
/// plugin and the native alert listener.
///
/// Camera access is asked for by the picker itself when a photo is taken;
/// a denial comes back from `ImagePickerCapture` as a `PermissionFailure`.
final class PlatformPermissionGateway implements PermissionGateway {
  /// Creates the gateway.
  new({required this._notifications, required this._alerts});

  final NotificationsApi _notifications;
  final AndroidPaymentAlertSource _alerts;

  static PermissionState _state(bool granted) =>
      granted ? PermissionState.granted : PermissionState.denied;

  @override
  Future<Result<PermissionState>> status(AppPermission permission) async =>
      switch (permission) {
        AppPermission.notifications => Ok(
          _state(await _notifications.areEnabled()),
        ),
        AppPermission.exactAlarms => Ok(
          _state(await _notifications.canScheduleExact()),
        ),
        AppPermission.notificationAccess => switch (await _alerts.isEnabled()) {
          Ok(:final value) => Ok(_state(value)),
          Err(:final failure) => Err(failure),
        },
        AppPermission.camera => const Ok(PermissionState.granted),
      };

  @override
  Future<Result<PermissionState>> request(AppPermission permission) async =>
      switch (permission) {
        AppPermission.notifications => Ok(
          _state(await _notifications.requestPermission()),
        ),
        AppPermission.exactAlarms => Ok(
          _state(await _notifications.requestExactAlarms()),
        ),
        // Android has no prompt for notification access; only settings.
        AppPermission.notificationAccess => await status(permission),
        AppPermission.camera => const Ok(PermissionState.granted),
      };

  @override
  Future<Result<void>> openSettings(AppPermission permission) =>
      permission == AppPermission.notificationAccess
      ? _alerts.openSettings()
      : Future.value(const Ok(null));
}
