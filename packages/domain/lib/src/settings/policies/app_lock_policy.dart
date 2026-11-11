import 'package:buckets_domain/src/settings/value_objects/lock_timeout.dart';

/// When the app asks to be unlocked (ARCHITECTURE §8: on launch, and on
/// resume once it has been in the background for the lock timeout).
abstract final class AppLockPolicy {
  /// Whether to show the lock: never when [enabled] is off; at launch
  /// ([backgroundedAt] null); or when it was away for at least the
  /// [timeout]'s grace (R-SEC-2). `immediately` locks on any backgrounding.
  static bool shouldLock({
    required bool enabled,
    required DateTime? backgroundedAt,
    required DateTime now,
    LockTimeout timeout = LockTimeout.oneMinute,
  }) {
    if (!enabled) return false;
    if (backgroundedAt == null) return true;
    return now.difference(backgroundedAt) >= timeout.grace;
  }
}
