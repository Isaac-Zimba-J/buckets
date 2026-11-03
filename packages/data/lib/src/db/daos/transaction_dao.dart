import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/db/tables/activity_tables.dart';
import 'package:drift/drift.dart';

part 'transaction_dao.g.dart';

/// Transactions with their bucket split lines.
@DriftAccessor(tables: [Transactions, TransactionLines])
class TransactionDao extends DatabaseAccessor<BucketsDatabase>
    with _$TransactionDaoMixin {
  /// Creates the DAO.
  new(super.attachedDatabase);

  /// Inserts or replaces a transaction and its lines.
  Future<void> save(
    TransactionsCompanion row,
    List<TransactionLinesCompanion> lines,
  ) => transaction(() async {
    await into(transactions).insertOnConflictUpdate(row);
    await (delete(
      transactionLines,
    )..where((l) => l.transactionId.equals(row.id.value))).go();
    await batch((b) => b.insertAll(transactionLines, lines));
  });

  /// Transactions matching [where] with their lines.
  Future<List<(TransactionRow, List<TransactionLineRow>)>> query({
    Expression<bool> Function($TransactionsTable t)? where,
    bool newestFirst = false,
    int? limit,
  }) async {
    final q = select(transactions);
    if (where != null) q.where(where);
    q.orderBy([
      (t) => newestFirst
          ? OrderingTerm.desc(t.occurredAt)
          : OrderingTerm.asc(t.occurredAt),
    ]);
    if (limit != null) q.limit(limit);
    final rows = await q.get();
    final lines =
        await (select(transactionLines)
              ..where((l) => l.transactionId.isIn([for (final r in rows) r.id]))
              ..orderBy([(l) => OrderingTerm.asc(l.position)]))
            .get();
    return [
      for (final r in rows)
        (r, lines.where((l) => l.transactionId == r.id).toList()),
    ];
  }

  /// Emits whenever transactions or lines change.
  Stream<void> changes() => tableUpdates(
    TableUpdateQuery.onAllTables([transactions, transactionLines]),
  );
}
