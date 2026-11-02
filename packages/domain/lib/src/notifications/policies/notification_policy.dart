import 'package:buckets_domain/src/notifications/value_objects/notification_inputs.dart';
import 'package:buckets_domain/src/notifications/value_objects/scheduled_notification.dart';
import 'package:buckets_domain/src/settings/entities/settings.dart';
import 'package:buckets_domain/src/shared/local_date.dart';
import 'package:buckets_domain/src/shared/local_time.dart';

/// Decides every local notification (DOMAIN §12). The adapter only
/// executes; the same inputs and time always give the same schedule.
abstract final class NotificationPolicy {
  /// How often the payday alarm repeats.
  static const paydayRepeat = Duration(minutes: 30);

  /// How far ahead payday repeats are scheduled; replanning extends it.
  static const horizon = Duration(hours: 24);

  /// Alerts closer than this are grouped (N-ALERT).
  static const alertGroupWindow = Duration(minutes: 5);

  /// The minimum gap between non-alarm notifications (R-NOTIF-2).
  static const minGap = Duration(hours: 1);

  /// The whole schedule from [inputs] at [now], sorted by time.
  static List<ScheduledNotification> plan(
    NotificationInputs inputs, {
    required Settings settings,
    required DateTime now,
    required Duration utcOffset,
  }) {
    final clock = _LocalClock(settings, utcOffset);
    final others = <ScheduledNotification>[
      ..._alerts(inputs.alerts, now),
      for (final b in inputs.bills) ?_bill(b, now, clock),
      for (final w in inputs.wishes)
        _at(
          'wish-${w.wishId}',
          NotificationKind.wish,
          w.endsAt.isBefore(now) ? now : w.endsAt,
          'buckets://plan/wish/${w.wishId}',
        ),
      if (inputs.checkIn) _checkIn(now, clock),
      if (inputs.low case final low?) ?_low(low, now, clock),
    ];
    return [
      ..._payday(inputs.payday, now, clock),
      ..._spaced(others, clock),
    ]..sort((a, b) => a.at.compareTo(b.at));
  }

  static ScheduledNotification _at(
    String id,
    NotificationKind kind,
    DateTime at,
    String deepLink, [
    Map<String, String> args = const {},
  ]) => ScheduledNotification(
    id: id,
    kind: kind,
    at: at,
    deepLink: deepLink,
    args: args,
  );

  static List<ScheduledNotification> _payday(
    PaydayAlarmInput? payday,
    DateTime now,
    _LocalClock clock,
  ) {
    if (payday == null || payday.pendingTransfers <= 0) return const [];
    final end = now.add(horizon);
    final result = <ScheduledNotification>[];
    var t = payday.snoozedUntil ?? now;
    while (t.isBefore(end)) {
      t = clock.outOfQuiet(t);
      if (!t.isBefore(end)) break;
      result.add(
        _at(
          'payday-${payday.paydayId}-${result.length}',
          NotificationKind.payday,
          t,
          'buckets://payday/${payday.paydayId}',
          {'pending': '${payday.pendingTransfers}'},
        ),
      );
      t = t.add(paydayRepeat);
    }
    return result;
  }

  static List<ScheduledNotification> _alerts(
    List<AlertInput> alerts,
    DateTime now,
  ) {
    final income = [
      for (final a in alerts.where((a) => a.isIncome))
        _at(
          'income-${a.alertId}',
          NotificationKind.income,
          now,
          'buckets://alert/${a.alertId}',
        ),
    ];
    final payments = alerts.where((a) => !a.isIncome).toList()
      ..sort((a, b) => a.receivedAt.compareTo(b.receivedAt));
    final groups = <List<AlertInput>>[];
    for (final a in payments) {
      final last = groups.lastOrNull?.last;
      if (last != null &&
          a.receivedAt.difference(last.receivedAt) <= alertGroupWindow) {
        groups.last.add(a);
      } else {
        groups.add([a]);
      }
    }
    return [
      ...income,
      for (final g in groups)
        _at(
          'alert-${g.first.alertId}',
          NotificationKind.alert,
          now,
          'buckets://alert/${g.first.alertId}',
          {'count': '${g.length}'},
        ),
    ];
  }

  static ScheduledNotification? _bill(
    BillDueInput bill,
    DateTime now,
    _LocalClock clock,
  ) {
    final at = clock.atLocal(bill.dueDate.addDays(-2), LocalTime(9, 0));
    if (at.isBefore(now)) return null;
    return _at(
      'bill-${bill.billId}',
      NotificationKind.bill,
      at,
      'buckets://plan/bills',
    );
  }

  static ScheduledNotification _checkIn(DateTime now, _LocalClock clock) {
    final s = clock.settings;
    var day = clock.today(now);
    while (true) {
      final weekday = DateTime.utc(day.year, day.month, day.day).weekday;
      final at = clock.atLocal(day, s.checkInTime);
      if (weekday == s.checkInDay && at.isAfter(now)) {
        return _at(
          'checkin',
          NotificationKind.checkIn,
          at,
          'buckets://checkin',
        );
      }
      day = day.addDays(1);
    }
  }

  static ScheduledNotification? _low(
    LowLivingInput low,
    DateTime now,
    _LocalClock clock,
  ) {
    final isLow = low.left.ngwee * 5 < low.allocation.ngwee;
    if (!isLow || low.daysLeft <= 7 || low.alreadyNotified) return null;
    var at = clock.atLocal(clock.today(now), LocalTime(12, 0));
    if (!at.isAfter(now)) at = at.add(const Duration(days: 1));
    return _at(
      'low-${low.cycleStart.toIso8601String()}',
      NotificationKind.low,
      at,
      'buckets://bucket/${low.livingBucketId}',
    );
  }

  /// R-NOTIF-1 and R-NOTIF-2: out of quiet hours, an hour apart; alert
  /// notifications that would collide are merged.
  static List<ScheduledNotification> _spaced(
    List<ScheduledNotification> notifications,
    _LocalClock clock,
  ) {
    final sorted = [
      for (final n in notifications) _move(n, clock.outOfQuiet(n.at)),
    ]..sort((a, b) => a.at.compareTo(b.at));
    final kept = <ScheduledNotification>[];
    for (final n in sorted) {
      final last = kept.lastOrNull;
      if (last == null || !n.at.isBefore(last.at.add(minGap))) {
        kept.add(n);
      } else if (last.kind == NotificationKind.alert &&
          n.kind == NotificationKind.alert) {
        final count =
            int.parse(last.args['count']!) + int.parse(n.args['count']!);
        kept.last = _move(last, last.at, {'count': '$count'});
      } else {
        kept.add(_move(n, clock.outOfQuiet(last.at.add(minGap))));
      }
    }
    return kept;
  }

  static ScheduledNotification _move(
    ScheduledNotification n,
    DateTime at, [
    Map<String, String>? args,
  ]) => _at(n.id, n.kind, at, n.deepLink, args ?? n.args);
}

/// Local-time helpers for one plan.
final class _LocalClock {
  _LocalClock(this.settings, this.utcOffset);

  final Settings settings;
  final Duration utcOffset;

  LocalDate today(DateTime now) => LocalDate.ofInstant(now, utcOffset);

  DateTime atLocal(LocalDate date, LocalTime time) =>
      date.startUtc(utcOffset).add(Duration(minutes: time.minutesOfDay));

  /// [t], or the end of the quiet hours it falls in.
  DateTime outOfQuiet(DateTime t) {
    final quiet = settings.quietHours;
    final start = quiet.start.minutesOfDay;
    final end = quiet.end.minutesOfDay;
    final wall = t.add(utcOffset);
    final minute = wall.hour * 60 + wall.minute;
    final wraps = start > end;
    final inQuiet = wraps
        ? minute >= start || minute < end
        : minute >= start && minute < end;
    if (!inQuiet) return t;
    final day = today(t);
    return atLocal(
      wraps && minute >= start ? day.addDays(1) : day,
      quiet.end,
    );
  }
}
