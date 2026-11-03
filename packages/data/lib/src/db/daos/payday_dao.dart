import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/db/tables/money_tables.dart';
import 'package:drift/drift.dart';

part 'payday_dao.g.dart';

/// A payday with its transfers and proof references.
typedef PaydayRows = (PaydayRow, List<TransferRow>, List<TransferProofRefRow>);

/// Paydays with their transfers and proof references.
@DriftAccessor(tables: [Paydays, Transfers, TransferProofRefs])
class PaydayDao extends DatabaseAccessor<BucketsDatabase>
    with _$PaydayDaoMixin {
  /// Creates the DAO.
  new(super.attachedDatabase);

  /// Inserts or replaces a payday, its transfers and their proof refs.
  Future<void> save(
    PaydaysCompanion payday,
    List<TransfersCompanion> transferRows,
    List<TransferProofRefsCompanion> refRows,
  ) => transaction(() async {
    await into(paydays).insertOnConflictUpdate(payday);
    final ids = [for (final t in transferRows) t.id.value];
    await (delete(
      transferProofRefs,
    )..where((r) => r.transferId.isIn(ids))).go();
    await batch((b) {
      for (final t in transferRows) {
        b.insert(transfers, t, mode: InsertMode.insertOrReplace);
      }
      b.insertAll(transferProofRefs, refRows);
    });
  });

  /// Every payday with its children, newest first.
  Future<List<PaydayRows>> all() async {
    final rows = await (select(
      paydays,
    )..orderBy([(p) => OrderingTerm.desc(p.startedAt)])).get();
    return await _withChildren(rows);
  }

  /// The payday with [id] and its children, or null.
  Future<PaydayRows?> byId(String id) async {
    final rows = await (select(paydays)..where((p) => p.id.equals(id))).get();
    final found = await _withChildren(rows);
    return found.firstOrNull;
  }

  /// Whether any transfer's proof used [reference] (R-PROOF-1.4).
  Future<bool> isReferenceUsed(String reference) async =>
      (await (select(transferProofRefs)
                ..where((r) => r.reference.equals(reference))
                ..limit(1))
              .get())
          .isNotEmpty;

  /// Emits whenever paydays, transfers or proofs change.
  Stream<void> changes() => tableUpdates(
    TableUpdateQuery.onAllTables([paydays, transfers, transferProofRefs]),
  );

  Future<List<PaydayRows>> _withChildren(List<PaydayRow> rows) async {
    final ids = [for (final p in rows) p.id];
    final transferRows =
        await (select(transfers)
              ..where((t) => t.paydayId.isIn(ids))
              ..orderBy([(t) => OrderingTerm.asc(t.position)]))
            .get();
    final refs =
        await (select(transferProofRefs)
              ..where(
                (r) => r.transferId.isIn([for (final t in transferRows) t.id]),
              )
              ..orderBy([(r) => OrderingTerm.asc(r.position)]))
            .get();
    return [
      for (final p in rows)
        (p, transferRows.where((t) => t.paydayId == p.id).toList(), refs),
    ];
  }
}
