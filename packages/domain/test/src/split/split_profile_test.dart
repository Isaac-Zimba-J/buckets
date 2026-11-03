import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Allocation a(String bucketId, int bp) => Allocation(bucketId, BasisPoints(bp));

void main() {
  test('R-SPLIT-1 a profile that adds up to 100% is valid', () {
    final p = ok(
      SplitProfile.create(
        id: 'p',
        allocations: [a('living', 4000), a('x', 6000)],
      ),
    );
    expect(p.allocations.map((x) => x.bucketId), ['living', 'x']);
    expect(p.holdUntilMonthEnd, isFalse);
  });

  test('R-SPLIT-1 too much or too little is a ValidationFailure', () {
    final tooMuch = [a('living', 5000), a('x', 6000)];
    expect(
      SplitProfile.create(id: 'p', allocations: tooMuch),
      isErr('split.tooMuch'),
    );
    expect(SplitProfile.totalOf(tooMuch), 11000);
    expect(
      SplitProfile.create(id: 'p', allocations: [a('living', 9000)]),
      isErr('split.tooLittle'),
    );
    expect(
      SplitProfile.create(id: 'p', allocations: []),
      isErr('split.tooLittle'),
    );
  });

  test('a bucket appears only once', () {
    expect(
      SplitProfile.create(id: 'p', allocations: [a('x', 5000), a('x', 5000)]),
      isErr('split.duplicateBucket'),
    );
  });
}
