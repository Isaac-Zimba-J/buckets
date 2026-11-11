import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/repositories/support_repositories.dart';
import 'package:buckets_data/src/support/help_content.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

T ok<T>(Result<T> r) => switch (r) {
  Ok(:final value) => value,
  Err(:final failure) => fail('$failure'),
};

void main() {
  late BucketsDatabase db;
  setUp(() => db = BucketsDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  group('BundledHelpContentRepository', () {
    test('all returns the bundled articles', () async {
      final all = ok(await BundledHelpContentRepository(db).all());
      expect(all, isNotEmpty);
      expect(all.map((a) => a.id), contains('how-payday-works'));
    });

    test('get finds an article or returns null', () async {
      final repo = BundledHelpContentRepository(db);
      expect(ok(await repo.get('app-lock'))!.title, 'Locking the app');
      expect(ok(await repo.get('missing')), isNull);
    });

    test('recordFeedback stores and replaces the verdict', () async {
      final repo = BundledHelpContentRepository(db);
      ok(await repo.recordFeedback('app-lock', helpful: true));
      ok(await repo.recordFeedback('app-lock', helpful: false));
      final rows = await db.select(db.helpFeedbacks).get();
      expect(rows, hasLength(1));
      expect(rows.single.articleId, 'app-lock');
      expect(rows.single.helpful, isFalse);
    });

    test('every bundled article has a unique id', () {
      final ids = helpArticles.map((a) => a.id).toList();
      expect(ids.toSet(), hasLength(ids.length));
    });
  });

  group('DriftStorageManager', () {
    test('a fresh database reports zero items and a non-zero size', () async {
      final summary = ok(await DriftStorageManager(db).summary());
      expect(summary.alertCount, 0);
      expect(summary.receiptCount, 0);
      expect(summary.databaseBytes, greaterThan(0));
    });
  });
}
