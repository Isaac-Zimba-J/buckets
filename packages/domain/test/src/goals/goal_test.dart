import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  test('a goal is a bucket with a positive target', () {
    final g = ok(
      Goal.create(bucketId: 'laptop', target: const Money.kwacha(9000)),
    );
    expect(g.bucketId, 'laptop');
    expect(g.targetDate, isNull);
    expect(
      Goal.create(bucketId: 'laptop', target: Money.zero),
      isErr('target.notPositive'),
    );
    expect(
      Goal.create(
        bucketId: 'laptop',
        target: const Money(1),
        targetDate: DateTime(2027),
      ),
      isErr('targetDate.notUtc'),
    );
  });
}
