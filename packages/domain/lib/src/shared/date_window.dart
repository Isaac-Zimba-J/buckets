import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// A span of time from [start] (inclusive) to [end] (exclusive), e.g. a pay
/// cycle (R-TIME-3).
final class DateWindow with Equatable {
  const new _(this.start, this.end);

  /// Validates and creates a window. Both ends are UTC and [end] is after
  /// [start].
  static Result<DateWindow> create(DateTime start, DateTime end) => validated([
    requireUtc(start, 'start'),
    requireUtc(end, 'end'),
    if (!end.isAfter(start))
      const ValidationFailure('window.empty', 'The end must be after start.'),
  ], () => DateWindow._(start, end));

  /// First instant inside the window.
  final DateTime start;

  /// First instant after the window.
  final DateTime end;

  /// Whether [time] is inside the window.
  bool contains(DateTime time) => !time.isBefore(start) && time.isBefore(end);

  @override
  List<Object?> get props => [start, end];
}
