import 'package:equatable/equatable.dart';

/// A wall-clock time of day in the device time zone, e.g. 21:00.
final class LocalTime with Equatable {
  /// Creates a time. Throws a [RangeError] for an impossible time.
  new(this.hour, this.minute) {
    RangeError.checkValueInInterval(hour, 0, 23, 'hour');
    RangeError.checkValueInInterval(minute, 0, 59, 'minute');
  }

  /// Hour, 0–23.
  final int hour;

  /// Minute, 0–59.
  final int minute;

  /// Minutes since midnight.
  int get minutesOfDay => hour * 60 + minute;

  @override
  List<Object?> get props => [hour, minute];
}
