import 'package:buckets_core/buckets_core.dart';

/// Reads the device's IANA time-zone id (e.g. `Africa/Lusaka`) for "About
/// you" (SCREENS 01b, R-TIME-1). Distinct from `LocalTimeZone`, which only
/// gives the current offset.
abstract interface class DeviceTimeZone {
  /// The current IANA time-zone id.
  Future<Result<String>> current();
}
