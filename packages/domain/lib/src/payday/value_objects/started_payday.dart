import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:equatable/equatable.dart';

/// A new payday and the allocation entries to append with it (R-PAY-1).
final class StartedPayday with Equatable {
  /// Pairs [payday] with its [entries].
  const new(this.payday, this.entries);

  /// The open payday with its transfers.
  final Payday payday;

  /// Allocation entries: one per split share, one per bill reservation.
  final List<LedgerEntry> entries;

  @override
  List<Object?> get props => [payday, entries];
}
