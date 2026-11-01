import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/settings/value_objects/quiet_hours.dart';
import 'package:buckets_domain/src/shared/local_time.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// The user's preferences (DOMAIN §16). Currency display is fixed to K.
final class Settings with Equatable {
  const Settings._({
    required this.timeZone,
    required this.quietHours,
    required this.snoozeLimit,
    required this.coolingOffThreshold,
    required this.coolingOffHours,
    required this.checkInDay,
    required this.checkInTime,
    required this.appLock,
    required this.autoFile,
  });

  /// Validates and creates settings; every value has its DOMAIN default.
  static Result<Settings> create({
    String timeZone = 'Africa/Lusaka',
    QuietHours? quietHours,
    int snoozeLimit = 1,
    Money coolingOffThreshold = const Money.kwacha(500),
    int coolingOffHours = 48,
    int checkInDay = DateTime.sunday,
    LocalTime? checkInTime,
    bool appLock = false,
    bool autoFile = false,
  }) => validated(
    [
      requireText(timeZone, 'timeZone'),
      requireRange(snoozeLimit, 0, 3, 'snoozeLimit'),
      requirePositive(coolingOffThreshold, 'coolingOffThreshold'),
      if (!allowedCoolingOffHours.contains(coolingOffHours))
        const ValidationFailure(
          'coolingOffHours.notAllowed',
          'Cooling-off is 24, 48 or 72 hours.',
        ),
      requireRange(checkInDay, DateTime.monday, DateTime.sunday, 'checkInDay'),
    ],
    () => Settings._(
      timeZone: timeZone.trim(),
      quietHours: quietHours ?? QuietHours(LocalTime(21, 0), LocalTime(7, 0)),
      snoozeLimit: snoozeLimit,
      coolingOffThreshold: coolingOffThreshold,
      coolingOffHours: coolingOffHours,
      checkInDay: checkInDay,
      checkInTime: checkInTime ?? LocalTime(18, 0),
      appLock: appLock,
      autoFile: autoFile,
    ),
  );

  /// The defaults from DOMAIN.
  static final Settings defaults = switch (create()) {
    Ok(:final value) => value,
    Err() => throw StateError('Default settings are invalid'),
  };

  /// Cooling-off lengths the user can pick (R-PLAN-2).
  static const allowedCoolingOffHours = {24, 48, 72};

  /// IANA time zone used to evaluate days (R-TIME-1).
  final String timeZone;

  /// When only the payday alarm may fire (R-NOTIF-1).
  final QuietHours quietHours;

  /// Snoozes allowed per payday, 0–3 (R-PAY-4).
  final int snoozeLimit;

  /// Unplanned payments above this suggest a wish (R-PLAN-1).
  final Money coolingOffThreshold;

  /// Wish cooling-off length (R-PLAN-2).
  final int coolingOffHours;

  /// Weekday of the check-in, `DateTime.monday`–`DateTime.sunday`.
  final int checkInDay;

  /// Time of the check-in.
  final LocalTime checkInTime;

  /// Whether the app locks on launch and resume.
  final bool appLock;

  /// Whether alerts matching a merchant rule file themselves (R-SPEND-3).
  final bool autoFile;

  @override
  List<Object?> get props => [
    timeZone,
    quietHours,
    snoozeLimit,
    coolingOffThreshold,
    coolingOffHours,
    checkInDay,
    checkInTime,
    appLock,
    autoFile,
  ];
}
