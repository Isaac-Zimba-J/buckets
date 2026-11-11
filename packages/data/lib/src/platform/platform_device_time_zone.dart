import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

/// [DeviceTimeZone] over `flutter_timezone`. Falls back to Africa/Lusaka
/// when the platform can't say (R-TIME-1), so "About you" always has a zone.
final class PlatformDeviceTimeZone implements DeviceTimeZone {
  /// Creates the adapter.
  const new();

  /// The fallback zone id.
  static const fallback = 'Africa/Lusaka';

  @override
  Future<Result<String>> current() async {
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      final id = info.identifier.trim();
      return Ok(id.isEmpty ? fallback : id);
    } on Exception {
      return const Ok(fallback);
    }
  }
}
