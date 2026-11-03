import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/db/daos/setup_dao.dart';
import 'package:buckets_data/src/mappers/setup_mappers.dart';
import 'package:buckets_data/src/repositories/guard.dart';
import 'package:buckets_data/src/repositories/streams.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:drift/drift.dart';

/// [AccountRepository] on drift.
final class DriftAccountRepository implements AccountRepository {
  /// Creates the repository.
  new(BucketsDatabase db) : _dao = SetupDao(db), _db = db;

  final SetupDao _dao;
  final BucketsDatabase _db;

  Future<List<Account>> _all() async => mapAllOrThrow(
    await _dao.accountsWithKeys(),
    (r) => SetupMappers.account(r.$1, r.$2),
  );

  @override
  Future<Result<List<Account>>> getAll() => guard(() async => Ok(await _all()));

  @override
  Future<Result<Account>> get(String id) => guard(() async {
    final found = (await _all()).where((a) => a.id == id).firstOrNull;
    return found == null ? notFound('account') : Ok(found);
  });

  @override
  Future<Result<void>> save(Account account) => guard(() async {
    final (row, keys) = SetupMappers.accountRows(account);
    await _dao.saveAccount(row, keys);
    return const Ok(null);
  });

  @override
  Stream<List<Account>> watchAll() => _db
      .tableUpdates(
        TableUpdateQuery.onAllTables([_db.accounts, _db.accountMatchKeys]),
      )
      .asyncMap((_) => _all())
      .startWithFuture(_all);
}

/// [BucketRepository] on drift.
final class DriftBucketRepository implements BucketRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  SimpleSelectStatement<$BucketsTable, BucketRow> _sorted() =>
      _db.select(_db.buckets)..orderBy([(b) => OrderingTerm.asc(b.sortOrder)]);

  @override
  Future<Result<List<Bucket>>> getAll() =>
      guard(() async => mapAll(await _sorted().get(), SetupMappers.bucket));

  @override
  Future<Result<Bucket>> get(String id) => guard(() async {
    final row = await (_db.select(
      _db.buckets,
    )..where((b) => b.id.equals(id))).getSingleOrNull();
    return row == null ? notFound('bucket') : SetupMappers.bucket(row);
  });

  @override
  Future<Result<void>> saveAll(List<Bucket> buckets) => guard(() async {
    await _db.batch(
      (b) => b.insertAllOnConflictUpdate(
        _db.buckets,
        buckets.map(SetupMappers.bucketRow),
      ),
    );
    return const Ok(null);
  });

  @override
  Stream<List<Bucket>> watchAll() =>
      _sorted().watch().map((rows) => mapAllOrThrow(rows, SetupMappers.bucket));
}

/// [IncomeRepository] on drift.
final class DriftIncomeRepository implements IncomeRepository {
  /// Creates the repository.
  new(BucketsDatabase db) : _dao = SetupDao(db);

  final SetupDao _dao;

  Future<List<IncomeSource>> _all() async => mapAllOrThrow(
    await _dao.incomesWithKeys(),
    (r) => SetupMappers.income(r.$1, r.$2),
  );

  @override
  Future<Result<List<IncomeSource>>> getAll() =>
      guard(() async => Ok(await _all()));

  @override
  Future<Result<IncomeSource>> get(String id) => guard(() async {
    final found = (await _all()).where((i) => i.id == id).firstOrNull;
    return found == null ? notFound('income') : Ok(found);
  });

  @override
  Future<Result<void>> save(IncomeSource source) => guard(() async {
    final (row, keys) = SetupMappers.incomeRows(source);
    await _dao.saveIncome(row, keys);
    return const Ok(null);
  });
}

/// [SplitProfileRepository] on drift.
final class DriftSplitProfileRepository implements SplitProfileRepository {
  /// Creates the repository.
  new(BucketsDatabase db) : _dao = SetupDao(db);

  final SetupDao _dao;

  @override
  Future<Result<SplitProfile>> get(String id) => guard(() async {
    final found = await _dao.splitProfile(id);
    return found == null
        ? notFound('split')
        : SetupMappers.splitProfile(found.$1, found.$2);
  });

  @override
  Future<Result<void>> save(SplitProfile profile) => guard(() async {
    final (row, allocations) = SetupMappers.splitProfileRows(profile);
    await _dao.saveSplitProfile(row, allocations);
    return const Ok(null);
  });
}

/// [BillRepository] on drift.
final class DriftBillRepository implements BillRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  @override
  Future<Result<List<Bill>>> getAll() => guard(
    () async => mapAll(await _db.select(_db.bills).get(), SetupMappers.bill),
  );

  @override
  Future<Result<void>> save(Bill bill) => guard(() async {
    await _db
        .into(_db.bills)
        .insertOnConflictUpdate(SetupMappers.billRow(bill));
    return const Ok(null);
  });

  @override
  Future<Result<void>> delete(String id) => guard(() async {
    await (_db.delete(_db.bills)..where((b) => b.id.equals(id))).go();
    return const Ok(null);
  });

  @override
  Stream<List<Bill>> watchAll() => _db
      .select(_db.bills)
      .watch()
      .map((rows) => mapAllOrThrow(rows, SetupMappers.bill));
}

/// [SettingsRepository] on drift: `Settings.defaults` until first saved.
final class DriftSettingsRepository implements SettingsRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  Result<Settings> _read(SettingsRow? row) =>
      row == null ? Ok(Settings.defaults) : SetupMappers.settings(row);

  @override
  Future<Result<Settings>> get() => guard(
    () async => _read(await _db.select(_db.settingsRows).getSingleOrNull()),
  );

  @override
  Future<Result<void>> save(Settings settings) => guard(() async {
    await _db
        .into(_db.settingsRows)
        .insertOnConflictUpdate(SetupMappers.settingsRow(settings));
    return const Ok(null);
  });

  @override
  Stream<Settings> watch() => _db
      .select(_db.settingsRows)
      .watchSingleOrNull()
      .map(
        (row) => switch (_read(row)) {
          Ok(:final value) => value,
          Err(:final failure) => throw StorageReadError(failure),
        },
      );
}
