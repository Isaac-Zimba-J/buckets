import 'package:buckets_core/buckets_core.dart';
import 'package:equatable/equatable.dart';

/// History figures for one bill (R-BILL-10, SCREENS 35).
final class BillStats with Equatable {
  /// Creates the stats.
  const new({
    required this.averagePaid,
    required this.onTimeOfLastFive,
    required this.lastFiveCount,
  });

  /// Average of the last 6 paid amounts; null when none were paid.
  final Money? averagePaid;

  /// How many of the last 5 paid occurrences were on time.
  final int onTimeOfLastFive;

  /// How many occurrences that count was taken from (at most 5).
  final int lastFiveCount;

  @override
  List<Object?> get props => [averagePaid, onTimeOfLastFive, lastFiveCount];
}
