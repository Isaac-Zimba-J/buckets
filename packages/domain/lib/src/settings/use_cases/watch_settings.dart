import 'package:buckets_domain/src/settings/entities/settings.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';

/// Streams the current settings for the Settings screen (SCREENS 25).
final class WatchSettings {
  /// Creates the use case.
  const new(this._settings);

  final SettingsRepository _settings;

  /// Emits the settings and again on every change.
  Stream<Settings> call() => _settings.watch();
}
