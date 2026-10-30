import 'package:buckets_core/buckets_core.dart';
import 'package:test/test.dart';

String describe(Result<int> r) => switch (r) {
  Ok(:final value) => 'ok $value',
  Err(:final failure) => 'err ${failure.code}',
};

void main() {
  test('Result is exhaustively matchable', () {
    expect(describe(const Ok(3)), 'ok 3');
    expect(
      describe(const Err(NotFoundFailure('bucket', 'Not found'))),
      'err bucket',
    );
  });

  test('every Failure carries a code and a message', () {
    const failures = <Failure>[
      ValidationFailure('splitNot100', 'Split must add up to 100%.'),
      NotFoundFailure('notFound', 'Not found.'),
      ConflictFailure('referenceUsed', 'Already used.'),
      StorageFailure('io', 'Could not save.'),
      PlatformFailure('ocr', 'Could not read.'),
      PermissionFailure('notifications', 'Allow notifications.'),
    ];
    for (final f in failures) {
      expect(f.code, isNotEmpty);
      expect(f.toString(), 'Failure(${f.code}): ${f.message}');
    }
  });
}
