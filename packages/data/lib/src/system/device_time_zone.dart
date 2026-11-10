import 'package:buckets_data/src/system/zone_time_zone.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

/// Reads the phone's time zone name, falling back to Africa/Lusaka.
abstract final class DeviceTimeZoneLoader {
  /// The device's zone, or the fallback if the platform can't say.
  static Future<ZoneTimeZone> load() async {
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      return ZoneTimeZone.named(info.identifier);
    } on Exception {
      return ZoneTimeZone.named(ZoneTimeZone.fallback);
    }
  }
}
