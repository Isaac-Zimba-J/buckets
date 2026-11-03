// Column getters describe themselves; each table is documented instead.
// ignore_for_file: public_member_api_docs

import 'package:buckets_domain/buckets_domain.dart'
    show LedgerEntryKind, PaydayStatus, TransferStatus;
import 'package:drift/drift.dart';

/// The append-only ledger (DOMAIN §6). Triggers in `BucketsDatabase` reject
/// every UPDATE and DELETE (R-LEDGER-1); amounts are signed ngwee.
@TableIndex(name: 'ledger_bucket_time', columns: {#bucketId, #occurredAt})
@TableIndex(name: 'ledger_carry_over', columns: {#carryOverId})
@DataClassName('LedgerEntryRow')
class LedgerEntries extends Table {
  TextColumn get id => text()();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get kind => textEnum<LedgerEntryKind>()();
  TextColumn get bucketId => text()();
  IntColumn get amount => integer()();
  TextColumn get counterBucketId => text().nullable()();
  TextColumn get paydayId => text().nullable()();
  TextColumn get transferId => text().nullable()();
  TextColumn get alertId => text().nullable()();
  TextColumn get transactionId => text().nullable()();
  TextColumn get receiptId => text().nullable()();
  TextColumn get billId => text().nullable()();
  TextColumn get carryOverId => text().nullable()();
  TextColumn get note => text().nullable()();
  TextColumn get reversesEntryId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Paydays (DOMAIN §7).
@TableIndex(name: 'paydays_started', columns: {#startedAt})
@DataClassName('PaydayRow')
class Paydays extends Table {
  TextColumn get id => text()();
  TextColumn get incomeSourceId => text()();
  IntColumn get amount => integer()();
  DateTimeColumn get startedAt => dateTime()();
  IntColumn get snoozesUsed => integer()();
  TextColumn get status => textEnum<PaydayStatus>()();
  DateTimeColumn get snoozedUntil => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Transfers of a payday, in order (DOMAIN §7).
@DataClassName('TransferRow')
class Transfers extends Table {
  TextColumn get id => text()();
  TextColumn get paydayId => text().references(Paydays, #id)();
  IntColumn get position => integer()();
  TextColumn get bucketId => text()();
  TextColumn get toAccountId => text()();
  IntColumn get amount => integer()();
  TextColumn get status => textEnum<TransferStatus>()();
  IntColumn get provenAmount => integer().nullable()();
  IntColumn get owedAmount => integer().nullable()();
  DateTimeColumn get provenAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Proof message references of a transfer (R-PROOF-1.4).
@TableIndex(name: 'proof_refs_reference', columns: {#reference})
@DataClassName('TransferProofRefRow')
class TransferProofRefs extends Table {
  TextColumn get transferId => text().references(Transfers, #id)();
  IntColumn get position => integer()();
  TextColumn get reference => text()();

  @override
  Set<Column<Object>> get primaryKey => {transferId, position};
}

/// Side-hustle money held until month end (R-PAY-6).
@DataClassName('HeldIncomeRow')
class HeldIncomes extends Table {
  TextColumn get id => text()();
  TextColumn get incomeSourceId => text()();
  IntColumn get amount => integer()();
  DateTimeColumn get receivedAt => dateTime()();
  TextColumn get alertId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Goals, keyed by bucket (DOMAIN §13).
@DataClassName('GoalRow')
class Goals extends Table {
  TextColumn get bucketId => text()();
  IntColumn get target => integer()();
  DateTimeColumn get targetDate => dateTime().nullable()();
  DateTimeColumn get celebratedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {bucketId};
}

/// Weekly cash counts (DOMAIN §15).
@DataClassName('CheckInRow')
class CheckIns extends Table {
  TextColumn get id => text()();
  DateTimeColumn get countedAt => dateTime()();
  IntColumn get expectedCash => integer()();
  IntColumn get countedCash => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
