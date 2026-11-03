import 'package:buckets_core/buckets_core.dart';

/// The device clock. The only place in the app that reads the current time
/// (AGENTS.md §3).
final class SystemClock implements Clock {
  /// Creates the clock.
  const new();

  @override
  DateTime now() => DateTime.now().toUtc();
}
