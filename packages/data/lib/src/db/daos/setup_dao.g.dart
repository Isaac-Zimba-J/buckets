// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setup_dao.dart';

// ignore_for_file: type=lint
mixin _$SetupDaoMixin on DatabaseAccessor<BucketsDatabase> {
  $AccountsTable get accounts => attachedDatabase.accounts;
  $AccountMatchKeysTable get accountMatchKeys =>
      attachedDatabase.accountMatchKeys;
  $BucketsTable get buckets => attachedDatabase.buckets;
  $IncomeSourcesTable get incomeSources => attachedDatabase.incomeSources;
  $IncomePayerKeysTable get incomePayerKeys => attachedDatabase.incomePayerKeys;
  $SplitProfilesTable get splitProfiles => attachedDatabase.splitProfiles;
  $SplitAllocationsTable get splitAllocations =>
      attachedDatabase.splitAllocations;
  $BillsTable get bills => attachedDatabase.bills;
  $SettingsRowsTable get settingsRows => attachedDatabase.settingsRows;
  SetupDaoManager get managers => SetupDaoManager(this);
}

class SetupDaoManager {
  final _$SetupDaoMixin _db;
  SetupDaoManager(this._db);
  $$AccountsTableTableManager get accounts =>
      $$AccountsTableTableManager(_db.attachedDatabase, _db.accounts);
  $$AccountMatchKeysTableTableManager get accountMatchKeys =>
      $$AccountMatchKeysTableTableManager(
        _db.attachedDatabase,
        _db.accountMatchKeys,
      );
  $$BucketsTableTableManager get buckets =>
      $$BucketsTableTableManager(_db.attachedDatabase, _db.buckets);
  $$IncomeSourcesTableTableManager get incomeSources =>
      $$IncomeSourcesTableTableManager(_db.attachedDatabase, _db.incomeSources);
  $$IncomePayerKeysTableTableManager get incomePayerKeys =>
      $$IncomePayerKeysTableTableManager(
        _db.attachedDatabase,
        _db.incomePayerKeys,
      );
  $$SplitProfilesTableTableManager get splitProfiles =>
      $$SplitProfilesTableTableManager(_db.attachedDatabase, _db.splitProfiles);
  $$SplitAllocationsTableTableManager get splitAllocations =>
      $$SplitAllocationsTableTableManager(
        _db.attachedDatabase,
        _db.splitAllocations,
      );
  $$BillsTableTableManager get bills =>
      $$BillsTableTableManager(_db.attachedDatabase, _db.bills);
  $$SettingsRowsTableTableManager get settingsRows =>
      $$SettingsRowsTableTableManager(_db.attachedDatabase, _db.settingsRows);
}
