/// The only source of the current time (AGENTS.md §3).
///
/// Implemented by `SystemClock` in `data`; tests use a fixed fake.
abstract interface class Clock {
  /// The current instant, in UTC (R-TIME-1).
  DateTime now();
}
