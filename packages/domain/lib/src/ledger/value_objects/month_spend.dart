import 'package:buckets_core/buckets_core.dart';
import 'package:equatable/equatable.dart';

/// Total spending in one calendar month.
final class MonthSpend with Equatable {
  /// Creates a month-spend summary.
  const new({required this.year, required this.month, required this.total});

  /// Calendar year.
  final int year;

  /// Calendar month, 1–12.
  final int month;

  /// Net spending (always ≥ zero; reversals are netted out).
  final Money total;

  @override
  List<Object?> get props => [year, month, total];
}
