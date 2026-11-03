import 'package:buckets_domain/buckets_domain.dart';
// latest_all includes zone links such as Africa/Lusaka (→ Africa/Maputo).
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

/// A named IANA time zone, e.g. `Africa/Lusaka` (R-TIME-1). Uses the
/// timezone database bundled with the app; no network.
final class ZoneTimeZone implements LocalTimeZone {
  new _(this._location);

  /// The zone called [name], or [fallback] (Africa/Lusaka) when the name
  /// is unknown.
  factory named(String name) {
    if (!_loaded) {
      tz_data.initializeTimeZones();
      _loaded = true;
    }
    try {
      return ZoneTimeZone._(tz.getLocation(name));
    } on tz.LocationNotFoundException {
      return ZoneTimeZone._(tz.getLocation(fallback));
    }
  }

  /// The default zone (DOMAIN R-TIME-1).
  static const fallback = 'Africa/Lusaka';

  static var _loaded = false;

  final tz.Location _location;

  /// The zone's IANA name.
  String get name => _location.name;

  @override
  Duration offsetAt(DateTime utc) =>
      _location.timeZone(utc.millisecondsSinceEpoch).offset;
}
