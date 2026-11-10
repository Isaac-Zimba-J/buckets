import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/entities/settings.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Saves the cooling-off and auto-file preferences (Me tab; R-PLAN-1,
/// R-PLAN-2, R-SPEND-3).
final class SavePlanningPreferences {
  /// Creates the use case.
  const new(this._settings);

  final SettingsRepository _settings;

  /// The settings with the given values replaced and validated.
  Future<Result<Settings>> call({
    int? coolingOffHours,
    Money? coolingOffThreshold,
    bool? autoFile,
  }) => attempt(() async {
    final updated = unwrap(
      unwrap(await _settings.get()).copyWith(
        coolingOffHours: coolingOffHours,
        coolingOffThreshold: coolingOffThreshold,
        autoFile: autoFile,
      ),
    );
    unwrap(await _settings.save(updated));
    return updated;
  });
}
