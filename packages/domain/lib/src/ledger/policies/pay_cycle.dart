import 'dart:math';

import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/shared/date_window.dart';
import 'package:buckets_domain/src/shared/local_date.dart';

/// Pay cycles: the budgeting "month" (R-TIME-3).
abstract final class PayCycle {
  /// The first payday of [schedule] strictly after [date], or null for an
  /// irregular schedule. A monthly payday on a day the month doesn't have
  /// falls on the month's last day (owner decision).
  static LocalDate? nextPaydayAfter(
    PaySchedule schedule,
    LocalDate date, {
    required Duration utcOffset,
  }) => switch (schedule) {
    MonthlyPay(:final dayOfMonth) => _nextMonthly(dayOfMonth, date),
    FortnightlyPay(:final anchor) => _nextFortnightly(
      LocalDate.ofInstant(anchor, utcOffset),
      date,
    ),
    IrregularPay() => null,
  };

  static LocalDate _nextMonthly(int dayOfMonth, LocalDate date) {
    LocalDate inMonth(int year, int month) => LocalDate(
      year,
      month,
      min(dayOfMonth, LocalDate.daysInMonth(year, month)),
    );
    final thisMonth = inMonth(date.year, date.month);
    if (thisMonth.compareTo(date) > 0) return thisMonth;
    final next = DateTime.utc(date.year, date.month + 1);
    return inMonth(next.year, next.month);
  }

  static LocalDate _nextFortnightly(LocalDate anchor, LocalDate date) {
    final days = anchor.daysUntil(date);
    // Floor division, so dates before the anchor count back in fortnights.
    final fortnights = days ~/ 14 - (days < 0 && days % 14 != 0 ? 1 : 0);
    return anchor.addDays((fortnights + 1) * 14);
  }

  /// The current pay cycle: from [lastSalaryStartedAt] (or [setupAt] before
  /// the first payday) to local midnight of the next expected [salary]
  /// payday. If that payday has passed without a payday being started, the
  /// cycle stays open until the end of today. Null for irregular salary.
  static DateWindow? current({
    required DateTime? lastSalaryStartedAt,
    required DateTime setupAt,
    required PaySchedule salary,
    required DateTime now,
    required Duration utcOffset,
  }) {
    final start = lastSalaryStartedAt ?? setupAt;
    final next = nextPaydayAfter(
      salary,
      LocalDate.ofInstant(start, utcOffset),
      utcOffset: utcOffset,
    );
    if (next == null) return null;
    var end = next.startUtc(utcOffset);
    if (!now.isBefore(end)) {
      end = LocalDate.ofInstant(now, utcOffset).addDays(1).startUtc(utcOffset);
    }
    return switch (DateWindow.create(start, end)) {
      Ok(:final value) => value,
      Err() => null,
    };
  }

  /// Calendar days from today until [cycle] ends, at least 1 (R-LEDGER-5).
  static int daysLeft(
    DateWindow cycle, {
    required DateTime now,
    required Duration utcOffset,
  }) {
    final today = LocalDate.ofInstant(now, utcOffset);
    final last = LocalDate.ofInstant(
      cycle.end.subtract(const Duration(microseconds: 1)),
      utcOffset,
    );
    return max(1, today.daysUntil(last) + 1);
  }
}
