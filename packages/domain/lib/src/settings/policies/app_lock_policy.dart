/// When the app asks to be unlocked (ARCHITECTURE §8: on launch and on
/// resume after a minute away).
abstract final class AppLockPolicy {
  /// How long the app may be in the background before it locks.
  static const grace = Duration(minutes: 1);

  /// Whether to show the lock: never when [enabled] is off; at launch
  /// ([backgroundedAt] null); or when it was away for [grace] or more.
  static bool shouldLock({
    required bool enabled,
    required DateTime? backgroundedAt,
    required DateTime now,
  }) {
    if (!enabled) return false;
    if (backgroundedAt == null) return true;
    return now.difference(backgroundedAt) >= grace;
  }
}
