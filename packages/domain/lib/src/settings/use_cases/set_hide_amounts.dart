import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/entities/settings.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Turns "hide amounts on Home" on or off (SCREENS 26, R-SEC-4).
final class SetHideAmounts {
  /// Creates the use case.
  const new(this._settings);

  final SettingsRepository _settings;

  /// The saved settings with the flag applied.
  Future<Result<Settings>> call({required bool hidden}) => attempt(() async {
    final updated = unwrap(
      unwrap(await _settings.get()).copyWith(hideAmounts: hidden),
    );
    unwrap(await _settings.save(updated));
    return updated;
  });
}
