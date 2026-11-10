import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_domain/buckets_domain.dart' show LedgerEntryKind;
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BucketsDatabase db;
  setUp(() => db = BucketsDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<Set<String>> names(String type) async => {
    for (final row
        in await db
            .customSelect(
              'SELECT name FROM sqlite_master WHERE type = ?',
              variables: [Variable.withString(type)],
            )
            .get())
      row.read<String>('name'),
  };

  test('schema creates a table per aggregate', () async {
    expect(db.schemaVersion, 2);
    expect(
      await names('table'),
      containsAll(<String>{
        'accounts',
        'account_match_keys',
        'buckets',
        'income_sources',
        'income_payer_keys',
        'split_profiles',
        'split_allocations',
        'bills',
        'settings',
        'profiles',
        'categories',
        'help_feedback',
        'ledger_entries',
        'paydays',
        'transfers',
        'transfer_proof_refs',
        'held_incomes',
        'goals',
        'check_ins',
        'payment_alerts',
        'transactions',
        'transaction_lines',
        'cash_withdrawals',
        'merchant_rules',
        'receipts',
        'planned_purchases',
        'wishes',
      }),
    );
  });

  test('indices on (bucket_id, occurred_at) and references', () async {
    expect(
      await names('index'),
      containsAll(<String>{
        'ledger_bucket_time',
        'alerts_reference',
        'proof_refs_reference',
      }),
    );
  });

  group('R-LEDGER-1 the ledger is append-only', () {
    Future<void> append() => db
        .into(db.ledgerEntries)
        .insert(
          LedgerEntriesCompanion.insert(
            id: 'e1',
            occurredAt: DateTime.utc(2026, 10, 25, 6),
            kind: LedgerEntryKind.allocation,
            bucketId: 'living',
            amount: 308000,
          ),
        );

    test('inserts work', () async {
      await append();
      expect(await db.select(db.ledgerEntries).get(), hasLength(1));
    });

    test('updates are rejected by the database', () async {
      await append();
      await expectLater(
        db.customStatement(
          "UPDATE ledger_entries SET amount = 1 WHERE id = 'e1'",
        ),
        throwsA(isA<SqliteException>()),
      );
    });

    test('deletes are rejected by the database', () async {
      await append();
      await expectLater(
        db.customStatement("DELETE FROM ledger_entries WHERE id = 'e1'"),
        throwsA(isA<SqliteException>()),
      );
      expect(await db.select(db.ledgerEntries).get(), hasLength(1));
    });
  });

  test('UTC timestamps round-trip with sub-second precision', () async {
    final at = DateTime.utc(2026, 10, 25, 6, 30, 15, 123, 456);
    await db
        .into(db.ledgerEntries)
        .insert(
          LedgerEntriesCompanion.insert(
            id: 'e1',
            occurredAt: at,
            kind: LedgerEntryKind.spend,
            bucketId: 'living',
            amount: -18500,
          ),
        );
    final row = await db.select(db.ledgerEntries).getSingle();
    expect(row.occurredAt, at);
    expect(row.occurredAt.isUtc, isTrue);
    expect(row.kind, LedgerEntryKind.spend);
  });
}
