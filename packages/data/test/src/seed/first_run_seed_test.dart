import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/repositories/setup_repositories.dart';
import 'package:buckets_data/src/seed/first_run_seed.dart';
import 'package:buckets_data/src/system/uuid_generator.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

T ok<T>(Result<T> r) => switch (r) {
  Ok(:final value) => value,
  Err(:final failure) => fail('$failure'),
};

void main() {
  late BucketsDatabase db;
  late FirstRunSeed seed;
  late DriftAccountRepository accounts;
  late DriftBucketRepository buckets;
  setUp(() {
    db = BucketsDatabase(NativeDatabase.memory());
    accounts = DriftAccountRepository(db);
    buckets = DriftBucketRepository(db);
    seed = FirstRunSeed(
      accounts: accounts,
      buckets: buckets,
      settings: DriftSettingsRepository(db),
      ids: const UuidGenerator(),
    );
  });
  tearDown(() => db.close());

  test('creates Cash in hand and the five default buckets', () async {
    expect(ok(await seed()), isTrue);
    final cash = ok(await accounts.getAll()).single;
    expect(cash.kind, AccountKind.cash);
    expect(cash.name, 'Cash in hand');
    final all = ok(await buckets.getAll());
    expect(all.map((b) => b.kind), [
      BucketKind.living,
      BucketKind.guiltFree,
      BucketKind.emergency,
      BucketKind.shortTerm,
      BucketKind.longTerm,
    ]);
    // No account until screen 05 ("Choose").
    expect(
      all.map((b) => b.accountId),
      everyElement(FirstRunSeed.unassignedAccount),
    );
    expect(ok(await DriftSettingsRepository(db).get()), Settings.defaults);
  });

  test('is idempotent: a second run adds nothing', () async {
    ok(await seed());
    expect(ok(await seed()), isFalse);
    expect(ok(await accounts.getAll()), hasLength(1));
    expect(ok(await buckets.getAll()), hasLength(5));
  });

  test('keeps what the user already has', () async {
    ok(await seed());
    final living = ok(await buckets.getAll()).first;
    ok(await buckets.saveAll([living.withAccount('momo')]));
    ok(await seed());
    expect(ok(await buckets.get(living.id)).accountId, 'momo');
  });

  test('storage errors come back as Err', () async {
    await db.customStatement('DROP TABLE buckets');
    expect(await seed(), isA<Err<bool>>());
  });
}
