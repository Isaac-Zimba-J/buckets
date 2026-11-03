import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/db/daos/ledger_dao.dart';
import 'package:buckets_data/src/db/daos/payday_dao.dart';
import 'package:buckets_data/src/mappers/money_mappers.dart';
import 'package:buckets_data/src/repositories/guard.dart';
import 'package:buckets_data/src/repositories/streams.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:drift/drift.dart';

/// [LedgerRepository] on drift: append and read only (R-LEDGER-1).
final class DriftLedgerRepository implements LedgerRepository {
  /// Creates the repository.
  new(BucketsDatabase db) : _dao = LedgerDao(db);

  final LedgerDao _dao;

  @override
  Future<Result<void>> append(List<LedgerEntry> entries) => guard(() async {
    await _dao.append(entries.map(MoneyMappers.ledgerEntryRow).toList());
    return const Ok(null);
  });

  @override
  Future<Result<List<LedgerEntry>>> getEntries({
    String? bucketId,
    DateWindow? window,
  }) => guard(
    () async => mapAll(
      await _dao.entries(
        bucketId: bucketId,
        from: window?.start,
        until: window?.end,
      ),
      MoneyMappers.ledgerEntry,
    ),
  );

  @override
  Stream<List<LedgerEntry>> watchEntries({
    String? bucketId,
    DateWindow? window,
  }) => _dao
      .watchEntries(bucketId: bucketId, from: window?.start, until: window?.end)
      .map((rows) => mapAllOrThrow(rows, MoneyMappers.ledgerEntry));
}

/// [PaydayRepository] on drift.
final class DriftPaydayRepository implements PaydayRepository {
  /// Creates the repository.
  new(BucketsDatabase db) : _dao = PaydayDao(db);

  final PaydayDao _dao;

  Result<Payday> _map(PaydayRows r) => MoneyMappers.payday(r.$1, r.$2, r.$3);

  Future<List<Payday>> _all() async => mapAllOrThrow(await _dao.all(), _map);

  @override
  Future<Result<Payday>> get(String id) => guard(() async {
    final found = await _dao.byId(id);
    return found == null ? notFound('payday') : _map(found);
  });

  @override
  Future<Result<List<Payday>>> getAll() => guard(() async => Ok(await _all()));

  @override
  Future<Result<void>> save(Payday payday) => guard(() async {
    final (row, transfers, refs) = MoneyMappers.paydayRows(payday);
    await _dao.save(row, transfers, refs);
    return const Ok(null);
  });

  @override
  Future<Result<bool>> isProofReferenceUsed(String reference) =>
      guard(() async => Ok(await _dao.isReferenceUsed(reference)));

  Stream<T> _watch<T>(Future<T> Function() read) =>
      _dao.changes().asyncMap((_) => read()).startWithFuture(read);

  @override
  Stream<Payday> watch(String id) => _watch(() async {
    final found = await _dao.byId(id);
    if (found == null) {
      throw const StorageReadError(
        NotFoundFailure('notFound', 'That payday no longer exists.'),
      );
    }
    return switch (_map(found)) {
      Ok(:final value) => value,
      Err(:final failure) => throw StorageReadError(failure),
    };
  });

  @override
  Stream<Payday?> watchOpen() => _watch(
    () async =>
        (await _all()).where((p) => p.status == PaydayStatus.open).firstOrNull,
  );
}

/// [HeldIncomeRepository] on drift.
final class DriftHeldIncomeRepository implements HeldIncomeRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  @override
  Future<Result<List<HeldIncome>>> getFor(String incomeSourceId) => guard(
    () async => mapAll(
      await (_db.select(_db.heldIncomes)
            ..where((h) => h.incomeSourceId.equals(incomeSourceId))
            ..orderBy([(h) => OrderingTerm.asc(h.receivedAt)]))
          .get(),
      MoneyMappers.heldIncome,
    ),
  );

  @override
  Future<Result<void>> add(HeldIncome held) => guard(() async {
    await _db.into(_db.heldIncomes).insert(MoneyMappers.heldIncomeRow(held));
    return const Ok(null);
  });

  @override
  Future<Result<void>> remove(List<String> ids) => guard(() async {
    await (_db.delete(_db.heldIncomes)..where((h) => h.id.isIn(ids))).go();
    return const Ok(null);
  });
}

/// [GoalRepository] on drift.
final class DriftGoalRepository implements GoalRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  @override
  Future<Result<Goal?>> get(String bucketId) => guard(() async {
    final row = await (_db.select(
      _db.goals,
    )..where((g) => g.bucketId.equals(bucketId))).getSingleOrNull();
    if (row == null) return const Ok(null);
    return switch (MoneyMappers.goal(row)) {
      Ok(:final value) => Ok(value),
      Err(:final failure) => Err(failure),
    };
  });

  @override
  Future<Result<void>> save(Goal goal) => guard(() async {
    await _db
        .into(_db.goals)
        .insertOnConflictUpdate(MoneyMappers.goalRow(goal));
    return const Ok(null);
  });

  @override
  Stream<List<Goal>> watchAll() => _db
      .select(_db.goals)
      .watch()
      .map((rows) => mapAllOrThrow(rows, MoneyMappers.goal));
}

/// [CheckInRepository] on drift.
final class DriftCheckInRepository implements CheckInRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  @override
  Future<Result<CheckIn?>> latest() => guard(() async {
    final row =
        await (_db.select(_db.checkIns)
              ..orderBy([(c) => OrderingTerm.desc(c.countedAt)])
              ..limit(1))
            .getSingleOrNull();
    if (row == null) return const Ok(null);
    return switch (MoneyMappers.checkIn(row)) {
      Ok(:final value) => Ok(value),
      Err(:final failure) => Err(failure),
    };
  });

  @override
  Future<Result<void>> save(CheckIn checkIn) => guard(() async {
    await _db
        .into(_db.checkIns)
        .insertOnConflictUpdate(MoneyMappers.checkInRow(checkIn));
    return const Ok(null);
  });
}
