import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/settings/value_objects/quiet_hours.dart';
import 'package:buckets_domain/src/shared/local_time.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// The user's preferences (DOMAIN §16). Currency display is fixed to K.
final class Settings with Equatable {
  const new _({
    required this.timeZone,
    required this.quietHours,
    required this.snoozeLimit,
    required this.coolingOffThreshold,
    required this.coolingOffHours,
    required this.checkInDay,
    required this.checkInTime,
    required this.appLock,
    required this.autoFile,
    required this.goalShareFallback,
    required this.setupCompletedAt,
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
    BucketKind goalShareFallback = BucketKind.longTerm,
    DateTime? setupCompletedAt,
  }) => validated(
    [
      requireText(timeZone, 'timeZone'),
      requireUtc(setupCompletedAt, 'setupCompletedAt'),
      requireRange(snoozeLimit, 0, 3, 'snoozeLimit'),
      requirePositive(coolingOffThreshold, 'coolingOffThreshold'),
      if (!allowedCoolingOffHours.contains(coolingOffHours))
        const ValidationFailure(
          'coolingOffHours.notAllowed',
          'Cooling-off is 24, 48 or 72 hours.',
        ),
      requireRange(checkInDay, DateTime.monday, DateTime.sunday, 'checkInDay'),
      if (!allowedGoalShareFallbacks.contains(goalShareFallback))
        const ValidationFailure(
          'goalShareFallback.notAllowed',
          'Choose one of the five default buckets.',
        ),
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
      goalShareFallback: goalShareFallback,
      setupCompletedAt: setupCompletedAt,
    ),
  );

  /// A validated copy with the given fields replaced.
  Result<Settings> copyWith({
    String? timeZone,
    QuietHours? quietHours,
    int? snoozeLimit,
    Money? coolingOffThreshold,
    int? coolingOffHours,
    int? checkInDay,
    LocalTime? checkInTime,
    bool? appLock,
    bool? autoFile,
    BucketKind? goalShareFallback,
    DateTime? setupCompletedAt,
  }) => create(
    timeZone: timeZone ?? this.timeZone,
    quietHours: quietHours ?? this.quietHours,
    snoozeLimit: snoozeLimit ?? this.snoozeLimit,
    coolingOffThreshold: coolingOffThreshold ?? this.coolingOffThreshold,
    coolingOffHours: coolingOffHours ?? this.coolingOffHours,
    checkInDay: checkInDay ?? this.checkInDay,
    checkInTime: checkInTime ?? this.checkInTime,
    appLock: appLock ?? this.appLock,
    autoFile: autoFile ?? this.autoFile,
    goalShareFallback: goalShareFallback ?? this.goalShareFallback,
    setupCompletedAt: setupCompletedAt ?? this.setupCompletedAt,
  );

  /// The defaults from DOMAIN.
  static final Settings defaults = switch (create()) {
    Ok(:final value) => value,
    Err() => throw StateError('Default settings are invalid'),
  };

  /// Buckets that can take the goal share when there is no goal: the five
  /// default buckets, which always exist (R-BUCKET-1).
  static const Set<BucketKind> allowedGoalShareFallbacks = {
    BucketKind.living,
    BucketKind.guiltFree,
    BucketKind.emergency,
    BucketKind.shortTerm,
    BucketKind.longTerm,
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

  /// Where the default splits put the goal share when there is no goal
  /// (R-SPLIT-4, R-SPLIT-5).
  final BucketKind goalShareFallback;

  /// When first-run setup was completed, in UTC; null until then. Also the
  /// start of the first pay cycle (R-TIME-3).
  final DateTime? setupCompletedAt;

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
    goalShareFallback,
    setupCompletedAt,
  ];
}
