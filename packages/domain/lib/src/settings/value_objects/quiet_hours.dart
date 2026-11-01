import 'package:buckets_domain/src/shared/local_time.dart';
import 'package:equatable/equatable.dart';

/// When only the payday alarm may fire (R-NOTIF-1). May wrap past
/// midnight, e.g. 21:00–07:00.
final class QuietHours with Equatable {
  /// Quiet from [start] to [end].
  const QuietHours(this.start, this.end);

  /// When quiet starts.
  final LocalTime start;

  /// When quiet ends.
  final LocalTime end;

  @override
  List<Object?> get props => [start, end];
}
