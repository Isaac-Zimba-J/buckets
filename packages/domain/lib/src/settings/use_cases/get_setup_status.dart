import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Whether first-run setup is done (screen 01, routing guard).
final class GetSetupStatus {
  /// Creates the use case.
  const new(this._settings);

  final SettingsRepository _settings;

  /// True once `CompleteSetup` has run.
  Future<Result<bool>> call() => attempt(
    () async => unwrap(await _settings.get()).setupCompletedAt != null,
  );
}
