import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/repositories/drift_data_wiper.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late BucketsDatabase db;
  late FakeNotificationScheduler notifications;
  setUp(() {
    db = BucketsDatabase(NativeDatabase.memory());
    notifications = FakeNotificationScheduler();
  });
  tearDown(() => db.close());

  Future<int> count(String table) async =>
      (await db.customSelect('SELECT COUNT(*) AS c FROM $table').getSingle())
          .read<int>('c');

  Future<void> seed() async {
    await db.customStatement('''
INSERT INTO accounts (id, name, kind, is_spending)
VALUES ('a1', 'Cash', 'cash', 1)''');
    await db.customStatement('''
INSERT INTO ledger_entries (id, occurred_at, kind, bucket_id, amount)
VALUES ('e1', 1793000000, 'allocation', 'living', 100000)''');
    await db.customStatement('''
INSERT INTO categories (name, is_default, archived) VALUES ('Food', 1, 0)''');
  }

  test('wipes every table', () async {
    await seed();
    expect(await count('accounts'), 1);
    expect(await count('ledger_entries'), 1);
    expect(await count('categories'), 1);

    final result = await DriftDataWiper(db, notifications).wipeEverything();
    expect(result, isA<Ok<void>>());
    expect(await count('accounts'), 0);
    expect(await count('ledger_entries'), 0);
    expect(await count('categories'), 0);
  });

  test('cancels all scheduled notifications', () async {
    await DriftDataWiper(db, notifications).wipeEverything();
    expect(notifications.scheduled, isEmpty);
  });

  test('keeps the append-only ledger trigger after a wipe', () async {
    await seed();
    await DriftDataWiper(db, notifications).wipeEverything();
    // A fresh append is allowed...
    await db.customStatement('''
INSERT INTO ledger_entries (id, occurred_at, kind, bucket_id, amount)
VALUES ('e2', 1793000000, 'allocation', 'living', 50000)''');
    // ...but deleting is still blocked (trigger recreated).
    await expectLater(
      db.customStatement("DELETE FROM ledger_entries WHERE id = 'e2'"),
      throwsA(anything),
    );
  });

  test('a fresh database wipes to a usable, empty state', () async {
    await DriftDataWiper(db, notifications).wipeEverything();
    await db.customStatement('''
INSERT INTO accounts (id, name, kind, is_spending)
VALUES ('a2', 'Bank', 'bank', 0)''');
    expect(await count('accounts'), 1);
  });
}
