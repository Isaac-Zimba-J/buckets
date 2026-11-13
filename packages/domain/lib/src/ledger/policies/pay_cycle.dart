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
    final startLocal = LocalDate.ofInstant(start, utcOffset);
    // Before the first payday, include the start date itself as a candidate
    // payday so that setting up on payday day shows daysLeft = 1, not 30.
    // After first payday, startLocal is the payday's own day, so strictly-after
    // naturally advances to next month.
    final queryDate =
        lastSalaryStartedAt != null ? startLocal : startLocal.addDays(-1);
    final next = nextPaydayAfter(salary, queryDate, utcOffset: utcOffset);
    if (next == null) return null;
    final today = LocalDate.ofInstant(now, utcOffset);
    var end = next.startUtc(utcOffset);
    if (next.compareTo(today) < 0) {
      // next is a past payday. Check whether today itself is a payday day.
      final todayNext = nextPaydayAfter(
        salary,
        today.addDays(-1),
        utcOffset: utcOffset,
      );
      if (todayNext != null && todayNext.compareTo(today) == 0) {
        // Today is payday: end at today's local midnight so daysLeft = 0.
        end = today.startUtc(utcOffset);
      } else {
        // Payday passed; keep cycle open to end of today.
        end = today.addDays(1).startUtc(utcOffset);
      }
    }
    return switch (DateWindow.create(start, end)) {
      Ok(:final value) => value,
      Err() => null,
    };
  }

  /// Paydays of [schedule] on or after [from] and before [until]: the pay
  /// cycles left before a due date, counting the current one (R-BILL-1).
  static int paydaysBetween(
    PaySchedule schedule,
    LocalDate from,
    LocalDate until, {
    required Duration utcOffset,
  }) {
    var count = 0;
    var day = from.addDays(-1);
    while (true) {
      final next = nextPaydayAfter(schedule, day, utcOffset: utcOffset);
      if (next == null || next.compareTo(until) >= 0) return count;
      count++;
      day = next;
    }
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
    return max(0, today.daysUntil(last) + 1);
  }
}
