/// How long the app may stay in the background before it asks to be
/// unlocked again (R-SEC-2). The grace period feeds `AppLockPolicy`.
enum LockTimeout {
  /// Lock as soon as the app leaves the foreground.
  immediately(Duration.zero),

  /// Lock after a minute away. The default.
  oneMinute(Duration(minutes: 1)),

  /// Lock after five minutes away.
  fiveMinutes(Duration(minutes: 5));

  new(this.grace);

  /// Time allowed in the background before the app locks.
  final Duration grace;
}
