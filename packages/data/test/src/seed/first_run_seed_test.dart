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
  late DriftCategoryRepository categories;
  setUp(() {
    db = BucketsDatabase(NativeDatabase.memory());
    accounts = DriftAccountRepository(db);
    buckets = DriftBucketRepository(db);
    categories = DriftCategoryRepository(db);
    seed = FirstRunSeed(
      accounts: accounts,
      buckets: buckets,
      settings: DriftSettingsRepository(db),
      ids: const UuidGenerator(),
      categories: categories,
    );
  });
  tearDown(() => db.close());

  test('creates Cash in hand, the five default buckets and Bills', () async {
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
      BucketKind.bills,
    ]);
    // No account until screen 05 ("Choose").
    expect(
      all.map((b) => b.accountId),
      everyElement(FirstRunSeed.unassignedAccount),
    );
    expect(ok(await DriftSettingsRepository(db).get()), Settings.defaults);
  });

  test('seeds the default categories, as defaults', () async {
    ok(await seed());
    final all = ok(await categories.getAll());
    expect(all.map((c) => c.name), containsAll(['Food', 'Transport', 'Fees']));
    expect(all.every((c) => c.isDefault), isTrue);
  });

  test(
    'creates the Bills bucket in the spending account (R-BUCKET-7)',
    () async {
      // The user's spending account exists by the time an older install runs.
      ok(
        await accounts.save(
          ok(
            Account.create(
              id: 'momo',
              name: 'MoMo',
              kind: AccountKind.mtnMomo,
              isSpending: true,
            ),
          ),
        ),
      );
      ok(await seed());
      final all = ok(await buckets.getAll());
      final bills = all.where((b) => b.kind == BucketKind.bills).single;
      expect(bills.name, 'Bills');
      expect(bills.isProtected, isFalse);
      expect(bills.sortOrder, all.length - 1);
    },
  );

  test('an install from before DOC-03 gets the Bills bucket once', () async {
    ok(await seed());
    final bills = ok(await buckets.getAll())
        .firstWhere((b) => b.kind == BucketKind.bills);
    // Simulate the older install: remove the bucket, then start the app.
    await db.customStatement("DELETE FROM buckets WHERE id = '${bills.id}'");
    expect(
      ok(await buckets.getAll()).where((b) => b.kind == BucketKind.bills),
      isEmpty,
    );
    expect(ok(await seed()), isTrue);
    expect(ok(await seed()), isFalse);
    expect(
      ok(await buckets.getAll()).where((b) => b.kind == BucketKind.bills),
      hasLength(1),
    );
  });

  test('is idempotent: a second run adds nothing', () async {
    ok(await seed());
    expect(ok(await seed()), isFalse);
    expect(ok(await accounts.getAll()), hasLength(1));
    expect(ok(await buckets.getAll()), hasLength(6)); // five + Bills
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
