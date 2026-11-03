import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Unwraps an [Ok] or fails the test.
T ok<T>(Result<T> r) => switch (r) {
  Ok(:final value) => value,
  Err(:final failure) => fail('Expected Ok, got $failure'),
};

/// Matches an [Err] with [code].
Matcher isErr(String code) =>
    isA<Err<Object?>>().having((e) => e.failure.code, 'code', code);

/// A fixed UTC instant.
final DateTime at = DateTime.utc(2026, 10, 25, 6, 30);

/// Runs [contract] against each implementation in [makers], giving each
/// test a fresh one. Drift makers get a fresh in-memory database.
void runContract<T>(
  String port,
  Map<String, T Function(BucketsDatabase db)> makers,
  void Function(T Function() subject) contract,
) {
  for (final MapEntry(key: name, value: make) in makers.entries) {
    group('$port ($name)', () {
      late BucketsDatabase db;
      late T subject;
      setUp(() {
        db = BucketsDatabase(NativeDatabase.memory());
        subject = make(db);
      });
      tearDown(() => db.close());
      contract(() => subject);
    });
  }
}
