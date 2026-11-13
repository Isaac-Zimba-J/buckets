import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/mappers/bill_fee_mappers.dart';
import 'package:buckets_data/src/repositories/guard.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:drift/drift.dart';

/// [BillOccurrenceRepository] on drift.
final class DriftBillOccurrenceRepository implements BillOccurrenceRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  SimpleSelectStatement<$BillOccurrencesTable, BillOccurrenceRow> _ordered() =>
      _db.select(_db.billOccurrences)..orderBy([
        (o) => OrderingTerm.asc(o.cycleStart),
        (o) => OrderingTerm.asc(o.dueDate),
      ]);

  List<BillOccurrence> _map(List<BillOccurrenceRow> rows) =>
      mapAllOrThrow(rows, BillFeeMappers.occurrence);

  @override
  Future<Result<List<BillOccurrence>>> getAll() =>
      guard(() async => Ok(_map(await _ordered().get())));

  @override
  Future<Result<List<BillOccurrence>>> getForCycle(LocalDate cycleStart) =>
      guard(() async {
        final rows =
            await (_ordered()..where(
                  (o) => o.cycleStart.equals(BillFeeMappers.date(cycleStart)),
                ))
                .get();
        return Ok(_map(rows));
      });

  @override
  Future<Result<List<BillOccurrence>>> getForBill(String billId) =>
      guard(() async {
        final rows = await (_ordered()..where((o) => o.billId.equals(billId)))
            .get();
        return Ok(_map(rows));
      });

  @override
  Future<Result<void>> save(BillOccurrence occurrence) => guard(() async {
    await _db
        .into(_db.billOccurrences)
        .insertOnConflictUpdate(BillFeeMappers.occurrenceRow(occurrence));
    return const Ok(null);
  });

  @override
  Stream<List<BillOccurrence>> watchAll() => _ordered().watch().map(_map);
}

/// [FeeTariffRepository] on drift: a header row per tariff and a row per
/// band.
final class DriftFeeTariffRepository implements FeeTariffRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  Future<List<FeeTariff>> _all() async {
    final bands = await _db.select(_db.feeBands).get();
    final tariffs = await _db.select(_db.feeTariffs).get();
    return mapAllOrThrow(tariffs, (t) => BillFeeMappers.tariff(t, bands));
  }

  @override
  Future<Result<List<FeeTariff>>> getAll() =>
      guard(() async => Ok(await _all()));

  @override
  Future<Result<FeeTariff?>> find(AlertSource provider, FeeType feeType) =>
      guard(
        () async => Ok(
          (await _all())
              .where((t) => t.provider == provider && t.feeType == feeType)
              .firstOrNull,
        ),
      );

  @override
  Future<Result<void>> save(FeeTariff tariff) => guard(() async {
    await _db.transaction(() async {
      await _db
          .into(_db.feeTariffs)
          .insertOnConflictUpdate(BillFeeMappers.tariffRow(tariff));
      await (_db.delete(_db.feeBands)..where(
            (b) =>
                b.provider.equalsValue(tariff.provider) &
                b.feeType.equalsValue(tariff.feeType),
          ))
          .go();
      for (final row in BillFeeMappers.bandRows(tariff)) {
        await _db.into(_db.feeBands).insert(row);
      }
    });
    return const Ok(null);
  });

  // Watches both tables, so a tariff with no bands still emits.
  @override
  Stream<List<FeeTariff>> watchAll() => _db
      .customSelect('SELECT 1', readsFrom: {_db.feeTariffs, _db.feeBands})
      .watch()
      .asyncMap((_) => _all());
}
