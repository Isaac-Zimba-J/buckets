import 'package:buckets_data/src/db/tables/activity_tables.dart';
import 'package:buckets_data/src/db/tables/bill_fee_tables.dart';
import 'package:buckets_data/src/db/tables/money_tables.dart';
import 'package:buckets_data/src/db/tables/setup_tables.dart';
import 'package:buckets_domain/buckets_domain.dart'
    show
        AccountKind,
        AlertSource,
        AlertStatus,
        BillStatus,
        BucketColor,
        BucketKind,
        FeeBandSource,
        FeeSource,
        FeeType,
        Greeting,
        IncomeKind,
        LedgerEntryKind,
        LockTimeout,
        MessageDirection,
        PaydayStatus,
        TransactionSource,
        TransferStatus,
        WishStatus;
import 'package:drift/drift.dart';

part 'buckets_database.g.dart';

/// The one database file (ADR-0003). Schema version 1.
@DriftDatabase(
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
    Profiles,
    Categories,
    HelpFeedbacks,
    LedgerEntries,
    Paydays,
    Transfers,
    TransferProofRefs,
    HeldIncomes,
    Goals,
    CheckIns,
    PaymentAlerts,
    Transactions,
    TransactionLines,
    CashWithdrawals,
    MerchantRules,
    Receipts,
    PlannedPurchases,
    Wishes,
    BillOccurrences,
    FeeTariffs,
    FeeBands,
  ],
)
class BucketsDatabase extends _$BucketsDatabase {
  /// Opens the database on executor [e]; use `drift_flutter` in the app and
  /// an in-memory executor in tests.
  new(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      for (final statement in appendOnlyLedger) {
        await customStatement(statement);
      }
    },
    onUpgrade: (m, from, to) async {
      // v2 (DOC-01): the profile, categories and help-feedback tables, and
      // the lock-timeout, hide-amounts and bill-reminders settings columns.
      if (from < 2) {
        await m.createTable(profiles);
        await m.createTable(categories);
        await m.createTable(helpFeedbacks);
        await m.addColumn(settingsRows, settingsRows.lockTimeout);
        await m.addColumn(settingsRows, settingsRows.hideAmounts);
        await m.addColumn(settingsRows, settingsRows.billReminders);
      }
      // v3 (DOC-03): bill occurrences, fee rates, and the fee fields on
      // transactions. Additive: existing bill money stays where it is.
      if (from < 3) {
        await m.createTable(billOccurrences);
        await m.createTable(feeTariffs);
        await m.createTable(feeBands);
        await m.addColumn(transactions, transactions.feeType);
        await m.addColumn(transactions, transactions.provider);
        await m.addColumn(transactions, transactions.feeSource);
        await m.addColumn(transactions, transactions.parentTransactionId);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Triggers that make `ledger_entries` append-only (R-LEDGER-1).
  static const appendOnlyLedger = [
    '''
CREATE TRIGGER ledger_entries_no_update BEFORE UPDATE ON ledger_entries
BEGIN SELECT RAISE(ABORT, 'ledger_entries is append-only'); END''',
    '''
CREATE TRIGGER ledger_entries_no_delete BEFORE DELETE ON ledger_entries
BEGIN SELECT RAISE(ABORT, 'ledger_entries is append-only'); END''',
  ];
}
