import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:drift/native.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../generated_migrations/schema.dart';

// The migration test pattern (DA-11). Each schema version is dumped to
// drift_schemas/ and its helpers generated with `melos run schema`.
void main() {
  late SchemaVerifier verifier;
  setUpAll(() => verifier = SchemaVerifier(GeneratedHelper()));

  test('a new database matches the committed schema', () async {
    final db = BucketsDatabase(NativeDatabase.memory());
    await db.validateDatabaseSchema();
    await db.close();
  });

  test('a v1 database opens at v1 without a migration', () async {
    final db = BucketsDatabase(await verifier.startAt(1));
    await verifier.migrateAndValidate(db, 1);
    await db.close();
  });

  test('a v1 database migrates to v2 (DOC-01: profile, categories, help, '
      'settings columns)', () async {
    final db = BucketsDatabase(await verifier.startAt(1));
    await verifier.migrateAndValidate(db, 2);
    await db.close();
  });
}
