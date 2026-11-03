import 'package:buckets_core/buckets_core.dart';
import 'package:test/test.dart';

/// Unwraps an [Ok] or fails the test.
T ok<T>(Result<T> result) => switch (result) {
  Ok(:final value) => value,
  Err(:final failure) => fail('Expected Ok, got $failure'),
};

/// Matches an [Err] whose failure has [code].
Matcher isErr(String code) =>
    isA<Err<Object?>>().having((e) => e.failure.code, 'failure.code', code);

/// Sequential IDs: `id-1`, `id-2`, …
final class SequentialIds implements IdGenerator {
  var _next = 0;

  @override
  String newId() => 'id-${++_next}';
}

/// A UTC instant on 30 Oct 2026.
final utc = DateTime.utc(2026, 10, 30, 7);
