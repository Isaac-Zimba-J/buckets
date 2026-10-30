/// Formats dates and times as defined in `docs/design/WRITING.md`.
///
/// Every input is a local wall-clock time: convert UTC instants to the
/// device time zone before calling (R-TIME-1).
abstract final class DateFormatter {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  /// `25 Nov`, or `3 Aug 2027` when [date] is not in the year of [today].
  static String date(DateTime date, {required DateTime today}) =>
      '${date.day} ${month(date, today: today)}';

  /// `Nov`, or `Aug 2027` when [date] is not in the year of [today].
  static String month(DateTime date, {required DateTime today}) {
    final name = _months[date.month - 1];
    return date.year == today.year ? name : '$name ${date.year}';
  }

  /// 24-hour time, `14:32`.
  static String time(DateTime time) =>
      '${_two(time.hour)}:${_two(time.minute)}';

  /// `Today`, `Yesterday`, `Tomorrow`, `in 12 days`, or [date] for days
  /// before yesterday. Days are calendar days (R-TIME-2).
  static String relativeDay(DateTime date, {required DateTime today}) {
    final days = _calendarDay(date).difference(_calendarDay(today)).inDays;
    return switch (days) {
      0 => 'Today',
      -1 => 'Yesterday',
      1 => 'Tomorrow',
      > 1 => 'in $days days',
      _ => DateFormatter.date(date, today: today),
    };
  }

  // UTC midnights so the day count is not skewed by daylight saving.
  static DateTime _calendarDay(DateTime d) =>
      DateTime.utc(d.year, d.month, d.day);

  static String _two(int n) => n.toString().padLeft(2, '0');
}
