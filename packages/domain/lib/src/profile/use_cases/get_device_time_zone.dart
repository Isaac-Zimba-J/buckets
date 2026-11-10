import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/ports/device_time_zone.dart';

/// Reads the device's IANA time zone to pre-fill "About you" (SCREENS 01b).
final class GetDeviceTimeZone {
  /// Creates the use case.
  const new(this._zone);

  final DeviceTimeZone _zone;

  /// The device time-zone id, e.g. `Africa/Lusaka`.
  Future<Result<String>> call() => _zone.current();
}
