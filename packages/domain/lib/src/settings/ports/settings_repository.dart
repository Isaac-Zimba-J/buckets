import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/entities/settings.dart';

/// Stores the user's settings; returns `Settings.defaults` until saved.
abstract interface class SettingsRepository {
  /// The current settings.
  Future<Result<Settings>> get();

  /// Replaces the settings.
  Future<Result<void>> save(Settings settings);

  /// The current settings, emitting again on change.
  Stream<Settings> watch();
}
