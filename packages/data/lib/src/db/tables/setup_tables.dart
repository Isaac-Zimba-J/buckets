// Column getters describe themselves; each table is documented instead.
// ignore_for_file: public_member_api_docs

import 'package:buckets_domain/buckets_domain.dart'
    show AccountKind, BucketColor, BucketKind, IncomeKind;
import 'package:drift/drift.dart';

/// Accounts (DOMAIN §2).
@DataClassName('AccountRow')
class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get kind => textEnum<AccountKind>()();
  BoolColumn get isSpending => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Match keys of an account, in order (R-ACC-3).
@DataClassName('AccountMatchKeyRow')
class AccountMatchKeys extends Table {
  TextColumn get accountId => text().references(Accounts, #id)();
  IntColumn get position => integer()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {accountId, position};
}

/// Buckets (DOMAIN §3). Balances are never stored (R-BUCKET-4).
@DataClassName('BucketRow')
class Buckets extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get kind => textEnum<BucketKind>()();
  TextColumn get color => textEnum<BucketColor>()();
  TextColumn get accountId => text()();
  BoolColumn get isProtected => boolean()();
  IntColumn get sortOrder => integer()();
  BoolColumn get archived => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Income sources (DOMAIN §4). The schedule is flattened: `monthly` uses
/// [scheduleDay], `fortnightly` uses [scheduleAnchor].
@DataClassName('IncomeSourceRow')
class IncomeSources extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get kind => textEnum<IncomeKind>()();
  IntColumn get expectedAmount => integer().nullable()();
  TextColumn get scheduleKind => text()();
  IntColumn get scheduleDay => integer().nullable()();
  DateTimeColumn get scheduleAnchor => dateTime().nullable()();
  TextColumn get landsInAccountId => text()();
  TextColumn get splitProfileId => text()();
  BoolColumn get deductBillsFirst => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Payer match keys of an income source (R-PARSE-5).
@DataClassName('IncomePayerKeyRow')
class IncomePayerKeys extends Table {
  TextColumn get incomeId => text().references(IncomeSources, #id)();
  IntColumn get position => integer()();
  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {incomeId, position};
}

/// Split profiles (DOMAIN §4).
@DataClassName('SplitProfileRow')
class SplitProfiles extends Table {
  TextColumn get id => text()();
  BoolColumn get holdUntilMonthEnd => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Allocations of a split profile, in order; basis points (R-MONEY-2).
@DataClassName('SplitAllocationRow')
class SplitAllocations extends Table {
  TextColumn get profileId => text().references(SplitProfiles, #id)();
  IntColumn get position => integer()();
  TextColumn get bucketId => text()();
  IntColumn get basisPoints => integer()();

  @override
  Set<Column<Object>> get primaryKey => {profileId, position};
}

/// Bills (DOMAIN §5); frequency in months.
@DataClassName('BillRow')
class Bills extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get amount => integer()();
  IntColumn get frequencyMonths => integer()();
  IntColumn get dueDay => integer().nullable()();
  DateTimeColumn get nextDueDate => dateTime().nullable()();
  TextColumn get paidFromBucketId => text()();
  TextColumn get payeeAccountHint => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// The single settings row (DOMAIN §16); times as minutes of the day.
@DataClassName('SettingsRow')
class SettingsRows extends Table {
  @override
  String get tableName => 'settings';

  IntColumn get id => integer()();
  TextColumn get timeZone => text()();
  IntColumn get quietStartMinutes => integer()();
  IntColumn get quietEndMinutes => integer()();
  IntColumn get snoozeLimit => integer()();
  IntColumn get coolingOffThreshold => integer()();
  IntColumn get coolingOffHours => integer()();
  IntColumn get checkInDay => integer()();
  IntColumn get checkInMinutes => integer()();
  BoolColumn get appLock => boolean()();
  BoolColumn get autoFile => boolean()();
  TextColumn get goalShareFallback => textEnum<BucketKind>()();
  DateTimeColumn get setupCompletedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
