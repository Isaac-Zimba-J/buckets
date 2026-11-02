import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/payday/policies/payday_planner.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';

/// Snoozes the payday alarm (R-PAY-4, screen 13).
final class SnoozePaydayAlarm {
  /// Creates the use case.
  const SnoozePaydayAlarm(
    this._paydays,
    this._settings,
    this._clock,
    this._zone,
  );

  final PaydayRepository _paydays;
  final SettingsRepository _settings;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// The payday with the snooze used and `snoozedUntil` set.
  Future<Result<Payday>> call(String paydayId) => attempt(() async {
    final now = _clock.now();
    final (payday, _) = unwrap(
      PaydayPlanner.snooze(
        unwrap(await _paydays.get(paydayId)),
        now: now,
        utcOffset: _zone.offsetAt(now),
        snoozeLimit: unwrap(await _settings.get()).snoozeLimit,
      ),
    );
    unwrap(await _paydays.save(payday));
    return payday;
  });
}
