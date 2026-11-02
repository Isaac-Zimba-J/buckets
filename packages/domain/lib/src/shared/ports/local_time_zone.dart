/// The device time zone (R-TIME-1; default Africa/Lusaka, UTC+2).
// ignore: one_member_abstracts, it is a port that data implements and tests fake.
abstract interface class LocalTimeZone {
  /// The offset from UTC at the instant [utc].
  Duration offsetAt(DateTime utc);
}
