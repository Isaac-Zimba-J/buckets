import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/db/tables/setup_tables.dart';
import 'package:drift/drift.dart';

part 'setup_dao.g.dart';

/// Accounts, buckets, income, splits, bills and settings. Aggregates with
/// child rows are replaced as a whole inside a transaction.
@DriftAccessor(
  tables: [
    Accounts,
    AccountMatchKeys,
    Buckets,
    IncomeSources,
    IncomePayerKeys,
    SplitProfiles,
    SplitAllocations,
    Bills,
    SettingsRows,
  ],
)
class SetupDao extends DatabaseAccessor<BucketsDatabase> with _$SetupDaoMixin {
  /// Creates the DAO.
  new(super.attachedDatabase);

  /// Inserts or replaces an account and its match keys.
  Future<void> saveAccount(
    AccountsCompanion account,
    List<AccountMatchKeysCompanion> keys,
  ) => transaction(() async {
    await into(accounts).insertOnConflictUpdate(account);
    await (delete(
      accountMatchKeys,
    )..where((k) => k.accountId.equals(account.id.value))).go();
    await batch((b) => b.insertAll(accountMatchKeys, keys));
  });

  /// Every account with its match keys in order.
  Future<List<(AccountRow, List<AccountMatchKeyRow>)>>
  accountsWithKeys() async {
    final keys = await (select(
      accountMatchKeys,
    )..orderBy([(k) => OrderingTerm.asc(k.position)])).get();
    return [
      for (final a in await select(accounts).get())
        (a, keys.where((k) => k.accountId == a.id).toList()),
    ];
  }

  /// Inserts or replaces an income source and its payer keys.
  Future<void> saveIncome(
    IncomeSourcesCompanion income,
    List<IncomePayerKeysCompanion> keys,
  ) => transaction(() async {
    await into(incomeSources).insertOnConflictUpdate(income);
    await (delete(
      incomePayerKeys,
    )..where((k) => k.incomeId.equals(income.id.value))).go();
    await batch((b) => b.insertAll(incomePayerKeys, keys));
  });

  /// Every income source with its payer keys in order.
  Future<List<(IncomeSourceRow, List<IncomePayerKeyRow>)>>
  incomesWithKeys() async {
    final keys = await (select(
      incomePayerKeys,
    )..orderBy([(k) => OrderingTerm.asc(k.position)])).get();
    return [
      for (final i in await select(incomeSources).get())
        (i, keys.where((k) => k.incomeId == i.id).toList()),
    ];
  }

  /// Inserts or replaces a split profile and its allocations.
  Future<void> saveSplitProfile(
    SplitProfilesCompanion profile,
    List<SplitAllocationsCompanion> rows,
  ) => transaction(() async {
    await into(splitProfiles).insertOnConflictUpdate(profile);
    await (delete(
      splitAllocations,
    )..where((a) => a.profileId.equals(profile.id.value))).go();
    await batch((b) => b.insertAll(splitAllocations, rows));
  });

  /// A split profile with its allocations in order, or null.
  Future<(SplitProfileRow, List<SplitAllocationRow>)?> splitProfile(
    String id,
  ) async {
    final row = await (select(
      splitProfiles,
    )..where((p) => p.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    final rows =
        await (select(splitAllocations)
              ..where((a) => a.profileId.equals(id))
              ..orderBy([(a) => OrderingTerm.asc(a.position)]))
            .get();
    return (row, rows);
  }
}
