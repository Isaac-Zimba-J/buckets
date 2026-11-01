import 'package:buckets_core/buckets_core.dart';

/// Permissions the app asks for.
enum AppPermission {
  /// Showing notifications (Android 13+).
  notifications,

  /// Reading other apps' notifications, for payment alerts.
  notificationAccess,

  /// Exact alarms, for the payday alarm.
  exactAlarms,

  /// The camera, for scanning receipts.
  camera,
}

/// Whether a permission is granted.
enum PermissionState {
  /// Granted.
  granted,

  /// Not granted; asking again may show the system prompt.
  denied,

  /// Not granted and the system won't ask again; only settings can change it.
  blocked,
}

/// Checks and requests platform permissions.
abstract interface class PermissionGateway {
  /// The current state of [permission].
  Future<Result<PermissionState>> status(AppPermission permission);

  /// Shows the system prompt where possible and returns the new state.
  Future<Result<PermissionState>> request(AppPermission permission);

  /// Opens the system settings page for [permission].
  Future<Result<void>> openSettings(AppPermission permission);
}
