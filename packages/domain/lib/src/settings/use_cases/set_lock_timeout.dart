import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/entities/settings.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/settings/value_objects/lock_timeout.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Sets how long the app may be in the background before it locks (SCREENS
/// 26, R-SEC-2).
final class SetLockTimeout {
  /// Creates the use case.
  const new(this._settings);

  final SettingsRepository _settings;

  /// The saved settings with [timeout] applied.
  Future<Result<Settings>> call(LockTimeout timeout) => attempt(() async {
    final updated = unwrap(
      unwrap(await _settings.get()).copyWith(lockTimeout: timeout),
    );
    unwrap(await _settings.save(updated));
    return updated;
  });
}
