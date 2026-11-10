import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/support/ports/system_settings_opener.dart';

/// Opens the app's battery-optimisation settings (SCREENS 30).
final class OpenBatterySettings {
  /// Creates the use case.
  const new(this._opener);

  final SystemSettingsOpener _opener;

  /// Hands off to the system settings.
  Future<Result<void>> call() => _opener.openBatterySettings();
}
