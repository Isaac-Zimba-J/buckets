// Column getters describe themselves; each table is documented instead.
// ignore_for_file: public_member_api_docs

import 'package:buckets_domain/buckets_domain.dart'
    show
        AlertSource,
        AlertStatus,
        MessageDirection,
        TransactionSource,
        WishStatus;
import 'package:drift/drift.dart';

/// Payment alerts with their parsed fields (DOMAIN §8). [rawText] is
/// cleared after 90 days (R-PRIV-2).
@TableIndex(name: 'alerts_reference', columns: {#source, #reference})
@TableIndex(name: 'alerts_received', columns: {#receivedAt})
@TableIndex(name: 'alerts_status', columns: {#status})
@DataClassName('PaymentAlertRow')
class PaymentAlerts extends Table {
  TextColumn get id => text()();
  TextColumn get rawText => text().nullable()();
  TextColumn get source => textEnum<AlertSource>()();
  DateTimeColumn get receivedAt => dateTime()();
  TextColumn get status => textEnum<AlertStatus>()();
  TextColumn get direction => textEnum<MessageDirection>().nullable()();
  IntColumn get amount => integer().nullable()();
  IntColumn get fee => integer().nullable()();
  TextColumn get counterparty => text().nullable()();
  TextColumn get reference => text().nullable()();
  DateTimeColumn get occurredAt => dateTime().nullable()();
  IntColumn get balanceAfter => integer().nullable()();
  RealColumn get confidence => real()();
  BoolColumn get isWithdrawal => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Spending transactions (DOMAIN §10); [category] is the category name.
@TableIndex(name: 'transactions_time', columns: {#occurredAt})
@DataClassName('TransactionRow')
class Transactions extends Table {
  TextColumn get id => text()();
  IntColumn get amount => integer()();
  TextColumn get bucketId => text()();
  TextColumn get category => text()();
  TextColumn get accountId => text()();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get source => textEnum<TransactionSource>()();
  TextColumn get note => text().nullable()();
  TextColumn get alertId => text().nullable()();
  TextColumn get receiptId => text().nullable()();
  TextColumn get billId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// The bucket split of a transaction, in order (R-SPEND-1).
@DataClassName('TransactionLineRow')
class TransactionLines extends Table {
  TextColumn get transactionId => text().references(Transactions, #id)();
  IntColumn get position => integer()();
  TextColumn get bucketId => text()();
  IntColumn get amount => integer()();

  @override
  Set<Column<Object>> get primaryKey => {transactionId, position};
}

/// Cash withdrawals into Cash in hand (R-SPEND-4).
@TableIndex(name: 'withdrawals_time', columns: {#occurredAt})
@DataClassName('CashWithdrawalRow')
class CashWithdrawals extends Table {
  TextColumn get id => text()();
  IntColumn get amount => integer()();
  TextColumn get fromAccountId => text()();
  TextColumn get cashAccountId => text()();
  DateTimeColumn get occurredAt => dateTime()();
  TextColumn get alertId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Merchant rules, one per merchant key (R-SPEND-3).
@DataClassName('MerchantRuleRow')
class MerchantRules extends Table {
  TextColumn get id => text()();
  TextColumn get merchantKey => text().unique()();
  TextColumn get category => text()();
  TextColumn get bucketId => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Scanned receipts waiting for review; the draft is stored as JSON.
@DataClassName('ReceiptRow')
class Receipts extends Table {
  TextColumn get id => text()();
  TextColumn get imagePath => text()();
  TextColumn get draftJson => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Planned purchases (DOMAIN §14); repeat interval in seconds.
@DataClassName('PlannedPurchaseRow')
class PlannedPurchases extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get amount => integer()();
  TextColumn get bucketId => text()();
  DateTimeColumn get due => dateTime().nullable()();
  IntColumn get repeatEverySeconds => integer().nullable()();
  BoolColumn get done => boolean()();
  TextColumn get transactionId => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

/// Wishes cooling off (DOMAIN §14).
@DataClassName('WishRow')
class Wishes extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get amount => integer()();
  TextColumn get bucketId => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get endsAt => dateTime()();
  TextColumn get status => textEnum<WishStatus>()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
