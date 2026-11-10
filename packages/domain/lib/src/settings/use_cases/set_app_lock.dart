import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/entities/settings.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/ports/app_lock.dart';

/// Turns the app lock on or off (Me tab). Either way the user unlocks
/// first, so someone holding the phone can't switch it off; turning it on
/// needs a screen lock on the phone (`appLock.unavailable`).
final class SetAppLock {
  /// Creates the use case.
  const new(this._settings, this._lock);

  final SettingsRepository _settings;
  final AppLock _lock;

  /// The saved settings; `appLock.cancelled` when the unlock was dismissed.
  Future<Result<Settings>> call({required bool enabled}) => attempt(() async {
    if (enabled && !unwrap(await _lock.isAvailable())) {
      unwrap<void>(
        const Err(
          ValidationFailure(
            'appLock.unavailable',
            'Set a screen lock on your phone first.',
          ),
        ),
      );
    }
    if (!unwrap(await _lock.authenticate())) {
      unwrap<void>(
        const Err(
          ValidationFailure('appLock.cancelled', 'Unlock to change this.'),
        ),
      );
    }
    final updated = unwrap(
      unwrap(await _settings.get()).copyWith(appLock: enabled),
    );
    unwrap(await _settings.save(updated));
    return updated;
  });
}
