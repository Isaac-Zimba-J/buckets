import 'package:buckets_core/buckets_core.dart';

/// Opens system or store screens that Buckets links to from help and about
/// (SCREENS 30, 32). It only hands off to the OS; it changes nothing itself.
abstract interface class SystemSettingsOpener {
  /// Opens the notification-access settings page.
  Future<Result<void>> openNotificationAccess();

  /// Opens the app's battery-optimisation settings page.
  Future<Result<void>> openBatterySettings();

  /// Opens the app's store listing.
  Future<Result<void>> openStoreListing();
}
