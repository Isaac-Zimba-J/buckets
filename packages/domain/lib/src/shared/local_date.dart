import 'package:equatable/equatable.dart';

/// A calendar date in the device time zone, without a time (R-TIME-2).
final class LocalDate with Equatable implements Comparable<LocalDate> {
  /// Creates a date. Throws a [RangeError] for a date that doesn't exist.
  LocalDate(this.year, this.month, this.day) {
    RangeError.checkValueInInterval(month, 1, 12, 'month');
    RangeError.checkValueInInterval(day, 1, daysInMonth(year, month), 'day');
  }

  /// The local date of the UTC instant [utc] at [utcOffset] (R-TIME-1).
  factory LocalDate.ofInstant(DateTime utc, Duration utcOffset) {
    final wall = utc.toUtc().add(utcOffset);
    return LocalDate(wall.year, wall.month, wall.day);
  }

  /// Year.
  final int year;

  /// Month, 1–12.
  final int month;

  /// Day of the month.
  final int day;

  /// Number of days in [month] of [year].
  static int daysInMonth(int year, int month) =>
      DateTime.utc(year, month + 1, 0).day;

  DateTime get _midnight => DateTime.utc(year, month, day);

  /// The UTC instant of this date's local midnight at [utcOffset].
  DateTime startUtc(Duration utcOffset) => _midnight.subtract(utcOffset);

  /// Calendar days from this date to [other]; negative if [other] is earlier.
  int daysUntil(LocalDate other) =>
      other._midnight.difference(_midnight).inDays;

  /// The date [days] later.
  LocalDate addDays(int days) {
    final d = _midnight.add(Duration(days: days));
    return LocalDate(d.year, d.month, d.day);
  }

  @override
  int compareTo(LocalDate other) => _midnight.compareTo(other._midnight);

  @override
  List<Object?> get props => [year, month, day];
}
