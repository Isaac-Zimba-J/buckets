/// The device time zone (R-TIME-1; default Africa/Lusaka, UTC+2).
abstract interface class LocalTimeZone {
  /// The offset from UTC at the instant [utc].
  Duration offsetAt(DateTime utc);
}
