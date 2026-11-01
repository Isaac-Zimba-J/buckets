import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/shared/date_window.dart';

/// The append-only ledger (R-LEDGER-1). There is no update or delete.
abstract interface class LedgerRepository {
  /// Appends [entries] in one transaction, so a move's two halves land
  /// together (R-LEDGER-3).
  Future<Result<void>> append(List<LedgerEntry> entries);

  /// Entries in occurrence order, optionally only for [bucketId] and only
  /// inside [window].
  Future<Result<List<LedgerEntry>>> getEntries({
    String? bucketId,
    DateWindow? window,
  });

  /// Like [getEntries], emitting again whenever entries are appended.
  Stream<List<LedgerEntry>> watchEntries({
    String? bucketId,
    DateWindow? window,
  });
}
