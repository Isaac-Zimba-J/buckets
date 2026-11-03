import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/db/tables/money_tables.dart';
import 'package:drift/drift.dart';

part 'ledger_dao.g.dart';

/// The ledger's only access path: append and read. There is no update or
/// delete here, and triggers reject them in SQL too (R-LEDGER-1).
@DriftAccessor(tables: [LedgerEntries])
class LedgerDao extends DatabaseAccessor<BucketsDatabase>
    with _$LedgerDaoMixin {
  /// Creates the DAO.
  new(super.attachedDatabase);

  /// Appends [rows] in one transaction (R-LEDGER-3).
  Future<void> append(List<LedgerEntriesCompanion> rows) =>
      batch((b) => b.insertAll(ledgerEntries, rows));

  SimpleSelectStatement<$LedgerEntriesTable, LedgerEntryRow> _query({
    String? bucketId,
    DateTime? from,
    DateTime? until,
  }) {
    final q = select(ledgerEntries);
    if (bucketId != null) q.where((e) => e.bucketId.equals(bucketId));
    if (from != null) q.where((e) => e.occurredAt.isBiggerOrEqualValue(from));
    if (until != null) q.where((e) => e.occurredAt.isSmallerThanValue(until));
    return q..orderBy([(e) => OrderingTerm.asc(e.occurredAt)]);
  }

  /// Entries in occurrence order, filtered by bucket and `[from, until)`.
  Future<List<LedgerEntryRow>> entries({
    String? bucketId,
    DateTime? from,
    DateTime? until,
  }) => _query(bucketId: bucketId, from: from, until: until).get();

  /// Like [entries], emitting again on every append.
  Stream<List<LedgerEntryRow>> watchEntries({
    String? bucketId,
    DateTime? from,
    DateTime? until,
  }) => _query(bucketId: bucketId, from: from, until: until).watch();
}
