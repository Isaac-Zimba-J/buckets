import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/entities/settings.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Turns bill reminders on or off (SCREENS 25; DOMAIN §12).
final class SetBillReminders {
  /// Creates the use case.
  const new(this._settings);

  final SettingsRepository _settings;

  /// The saved settings with the flag applied.
  Future<Result<Settings>> call({required bool enabled}) => attempt(() async {
    final updated = unwrap(
      unwrap(await _settings.get()).copyWith(billReminders: enabled),
    );
    unwrap(await _settings.save(updated));
    return updated;
  });
}
