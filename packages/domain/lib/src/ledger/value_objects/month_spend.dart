import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:equatable/equatable.dart';

/// Total spending in one calendar month, with the individual spend entries.
final class MonthSpend with Equatable {
  /// Creates a month-spend summary.
  const new({
    required this.year,
    required this.month,
    required this.total,
    required this.entries,
  });

  /// Calendar year.
  final int year;

  /// Calendar month, 1–12.
  final int month;

  /// Net spending (always ≥ zero; reversals are netted out).
  final Money total;

  /// Individual spend entries for this month, newest first.
  final List<LedgerEntry> entries;

  @override
  List<Object?> get props => [year, month, total, entries];
}
