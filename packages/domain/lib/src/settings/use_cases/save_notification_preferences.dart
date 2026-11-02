import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/entities/settings.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/settings/value_objects/quiet_hours.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/local_time.dart';

/// Saves alarm and reminder preferences (screen 06, Me tab).
final class SaveNotificationPreferences {
  /// Creates the use case.
  const SaveNotificationPreferences(this._settings);

  final SettingsRepository _settings;

  /// The settings with the given values replaced and validated.
  Future<Result<Settings>> call({
    QuietHours? quietHours,
    int? snoozeLimit,
    int? checkInDay,
    LocalTime? checkInTime,
  }) => attempt(() async {
    final updated = unwrap(
      unwrap(await _settings.get()).copyWith(
        quietHours: quietHours,
        snoozeLimit: snoozeLimit,
        checkInDay: checkInDay,
        checkInTime: checkInTime,
      ),
    );
    unwrap(await _settings.save(updated));
    return updated;
  });
}
