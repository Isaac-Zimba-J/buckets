import 'package:buckets_core/buckets_core.dart';

/// The device PIN or biometric lock, for the optional app lock.
abstract interface class AppLock {
  /// Whether the device has a PIN or biometric set up.
  Future<Result<bool>> isAvailable();

  /// Asks the user to unlock; true when they did.
  Future<Result<bool>> authenticate();
}
