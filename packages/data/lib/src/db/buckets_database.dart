import 'package:buckets_data/src/db/tables/activity_tables.dart';
import 'package:buckets_data/src/db/tables/money_tables.dart';
import 'package:buckets_data/src/db/tables/setup_tables.dart';
import 'package:buckets_domain/buckets_domain.dart'
    show
        AccountKind,
        AlertSource,
        AlertStatus,
        BucketColor,
        BucketKind,
        IncomeKind,
        LedgerEntryKind,
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
  ],
)
class BucketsDatabase extends _$BucketsDatabase {
  /// Opens the database on executor [e]; use `drift_flutter` in the app and
  /// an in-memory executor in tests.
  new(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      for (final statement in appendOnlyLedger) {
        await customStatement(statement);
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
