import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/db/daos/transaction_dao.dart';
import 'package:buckets_data/src/mappers/activity_mappers.dart';
import 'package:buckets_data/src/repositories/guard.dart';
import 'package:buckets_data/src/repositories/streams.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:drift/drift.dart';

/// [AlertRepository] on drift.
final class DriftAlertRepository implements AlertRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  @override
  Future<Result<PaymentAlert>> get(String id) => guard(() async {
    final row = await (_db.select(
      _db.paymentAlerts,
    )..where((a) => a.id.equals(id))).getSingleOrNull();
    return row == null ? notFound('alert') : ActivityMappers.alert(row);
  });

  @override
  Future<Result<void>> save(PaymentAlert alert) => guard(() async {
    await _db
        .into(_db.paymentAlerts)
        .insertOnConflictUpdate(ActivityMappers.alertRow(alert));
    return const Ok(null);
  });

  @override
  Future<Result<PaymentAlert?>> findByReference(
    AlertSource source,
    String reference,
  ) => guard(() async {
    final row =
        await (_db.select(_db.paymentAlerts)
              ..where(
                (a) =>
                    a.source.equalsValue(source) &
                    a.reference.equals(reference),
              )
              ..limit(1))
            .getSingleOrNull();
    if (row == null) return const Ok(null);
    return switch (ActivityMappers.alert(row)) {
      Ok(:final value) => Ok(value),
      Err(:final failure) => Err(failure),
    };
  });

  @override
  Future<Result<List<PaymentAlert>>> getReceivedIn(DateWindow window) => guard(
    () async => mapAll(
      await (_db.select(_db.paymentAlerts)..where(
            (a) =>
                a.receivedAt.isBiggerOrEqualValue(window.start) &
                a.receivedAt.isSmallerThanValue(window.end),
          ))
          .get(),
      ActivityMappers.alert,
    ),
  );

  @override
  Future<Result<void>> clearRawTextBefore(DateTime cutoff) => guard(() async {
    await (_db.update(_db.paymentAlerts)
          ..where((a) => a.receivedAt.isSmallerThanValue(cutoff)))
        .write(const PaymentAlertsCompanion(rawText: Value(null)));
    return const Ok(null);
  });

  @override
  Stream<List<PaymentAlert>> watchByStatus(AlertStatus status) =>
      (_db.select(_db.paymentAlerts)
            ..where((a) => a.status.equalsValue(status))
            ..orderBy([(a) => OrderingTerm.asc(a.receivedAt)]))
          .watch()
          .map((rows) => mapAllOrThrow(rows, ActivityMappers.alert));
}

/// [TransactionRepository] on drift.
final class DriftTransactionRepository implements TransactionRepository {
  /// Creates the repository.
  new(this._db) : _dao = TransactionDao(_db);

  final BucketsDatabase _db;
  final TransactionDao _dao;

  Result<Transaction> _map((TransactionRow, List<TransactionLineRow>) r) =>
      ActivityMappers.transaction(r.$1, r.$2);

  @override
  Future<Result<Transaction>> get(String id) => guard(() async {
    final found = await _dao.query(where: (t) => t.id.equals(id));
    return found.isEmpty ? notFound('transaction') : _map(found.single);
  });

  @override
  Future<Result<void>> save(Transaction transaction) => guard(() async {
    final (row, lines) = ActivityMappers.transactionRows(transaction);
    await _dao.save(row, lines);
    return const Ok(null);
  });

  @override
  Future<Result<List<Transaction>>> getIn(DateWindow window) => guard(
    () async => mapAll(
      await _dao.query(
        where: (t) =>
            t.occurredAt.isBiggerOrEqualValue(window.start) &
            t.occurredAt.isSmallerThanValue(window.end),
      ),
      _map,
    ),
  );

  @override
  Future<Result<void>> saveWithdrawal(CashWithdrawal withdrawal) =>
      guard(() async {
        await _db
            .into(_db.cashWithdrawals)
            .insertOnConflictUpdate(ActivityMappers.withdrawalRow(withdrawal));
        return const Ok(null);
      });

  @override
  Future<Result<List<CashWithdrawal>>> getWithdrawalsIn(DateWindow window) =>
      guard(
        () async => mapAll(
          await (_db.select(_db.cashWithdrawals)
                ..where(
                  (w) =>
                      w.occurredAt.isBiggerOrEqualValue(window.start) &
                      w.occurredAt.isSmallerThanValue(window.end),
                )
                ..orderBy([(w) => OrderingTerm.asc(w.occurredAt)]))
              .get(),
          ActivityMappers.withdrawal,
        ),
      );

  @override
  Stream<List<Transaction>> watchRecent(int limit) {
    Future<List<Transaction>> read() async =>
        mapAllOrThrow(await _dao.query(newestFirst: true, limit: limit), _map);
    return _dao.changes().asyncMap((_) => read()).startWithFuture(read);
  }
}

/// [MerchantRuleRepository] on drift; one rule per merchant key.
final class DriftMerchantRuleRepository implements MerchantRuleRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  @override
  Future<Result<MerchantRule?>> findByKey(MerchantKey key) => guard(() async {
    final row = await (_db.select(
      _db.merchantRules,
    )..where((r) => r.merchantKey.equals(key.value))).getSingleOrNull();
    if (row == null) return const Ok(null);
    return switch (ActivityMappers.merchantRule(row)) {
      Ok(:final value) => Ok(value),
      Err(:final failure) => Err(failure),
    };
  });

  @override
  Future<Result<List<MerchantRule>>> getAll() =>
      guard(() async => Ok(_sorted(await _db.select(_db.merchantRules).get())));

  @override
  Stream<List<MerchantRule>> watchAll() =>
      _db.select(_db.merchantRules).watch().map(_sorted);

  List<MerchantRule> _sorted(List<MerchantRuleRow> rows) =>
      mapAllOrThrow(rows, ActivityMappers.merchantRule)
        ..sort((a, b) => a.merchantKey.value.compareTo(b.merchantKey.value));

  @override
  Future<Result<void>> save(MerchantRule rule) => guard(() async {
    await _db.transaction(() async {
      // Replacing a rule for the same merchant keeps one rule per key.
      await (_db.delete(
        _db.merchantRules,
      )..where((r) => r.merchantKey.equals(rule.merchantKey.value))).go();
      await _db
          .into(_db.merchantRules)
          .insertOnConflictUpdate(ActivityMappers.merchantRuleRow(rule));
    });
    return const Ok(null);
  });

  @override
  Future<Result<void>> delete(String id) => guard(() async {
    await (_db.delete(_db.merchantRules)..where((r) => r.id.equals(id))).go();
    return const Ok(null);
  });
}

/// [ReceiptRepository] on drift.
final class DriftReceiptRepository implements ReceiptRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  @override
  Future<Result<StoredReceipt>> get(String id) => guard(() async {
    final row = await (_db.select(
      _db.receipts,
    )..where((r) => r.id.equals(id))).getSingleOrNull();
    return row == null ? notFound('receipt') : ActivityMappers.receipt(row);
  });

  @override
  Future<Result<void>> save(StoredReceipt receipt) => guard(() async {
    await _db
        .into(_db.receipts)
        .insertOnConflictUpdate(ActivityMappers.receiptRow(receipt));
    return const Ok(null);
  });
}

/// [PlanningRepository] on drift.
final class DriftPlanningRepository implements PlanningRepository {
  /// Creates the repository.
  new(this._db);

  final BucketsDatabase _db;

  @override
  Future<Result<void>> savePlanned(PlannedPurchase purchase) => guard(() async {
    await _db
        .into(_db.plannedPurchases)
        .insertOnConflictUpdate(ActivityMappers.plannedRow(purchase));
    return const Ok(null);
  });

  @override
  Future<Result<Wish>> getWish(String id) => guard(() async {
    final row = await (_db.select(
      _db.wishes,
    )..where((w) => w.id.equals(id))).getSingleOrNull();
    return row == null ? notFound('wish') : ActivityMappers.wish(row);
  });

  @override
  Future<Result<void>> saveWish(Wish wish) => guard(() async {
    await _db
        .into(_db.wishes)
        .insertOnConflictUpdate(ActivityMappers.wishRow(wish));
    return const Ok(null);
  });

  @override
  Stream<List<PlannedPurchase>> watchPlanned() => _db
      .select(_db.plannedPurchases)
      .watch()
      .map((rows) => mapAllOrThrow(rows, ActivityMappers.planned));

  @override
  Stream<List<Wish>> watchWishes() => _db
      .select(_db.wishes)
      .watch()
      .map((rows) => mapAllOrThrow(rows, ActivityMappers.wish));
}
