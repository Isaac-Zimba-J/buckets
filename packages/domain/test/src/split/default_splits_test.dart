import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Bucket bucket(
  String id,
  BucketKind kind, {
  int order = 9,
  bool archived = false,
}) => ok(
  Bucket.create(
    id: id,
    name: id,
    kind: kind,
    color: BucketColor.goal,
    accountId: 'a',
    sortOrder: order,
    archived: archived,
  ),
);

Map<String, int> bp(List<Allocation> allocations) => {
  for (final x in allocations) x.bucketId: x.bp.value,
};

void main() {
  final defaults = Bucket.defaults(
    ids: SequentialIds(),
    spendingAccountId: 's',
    savingsAccountId: 'v',
  );
  String idOf(BucketKind kind) => defaults.firstWhere((b) => b.kind == kind).id;
  final living = idOf(BucketKind.living);
  final fun = idOf(BucketKind.guiltFree);
  final emergency = idOf(BucketKind.emergency);
  final short = idOf(BucketKind.shortTerm);
  final long = idOf(BucketKind.longTerm);
  final laptop = bucket('laptop', BucketKind.goal, order: 5);
  final house = bucket('house', BucketKind.goal, order: 6);

  group('R-SPLIT-4 default salary split', () {
    test(
      'Living 40, Guilt-free 10, Emergency 10, Short 10, Long 20, goal 10',
      () {
        expect(bp(ok(DefaultSplits.salary([...defaults, house, laptop]))), {
          living: 4000,
          fun: 1000,
          emergency: 1000,
          short: 1000,
          long: 2000,
          'laptop': 1000,
        });
      },
    );

    test('with no goal, the goal share goes to Long-term (owner decision)', () {
      final archivedGoal = bucket('old', BucketKind.goal, archived: true);
      expect(bp(ok(DefaultSplits.salary([...defaults, archivedGoal]))), {
        living: 4000,
        fun: 1000,
        emergency: 1000,
        short: 1000,
        long: 3000,
      });
    });

    test('adds up to 100% and is a valid profile', () {
      final allocations = ok(DefaultSplits.salary([...defaults, laptop]));
      expect(
        SplitProfile.create(id: 'p', allocations: allocations),
        isA<Object>(),
      );
      expect(SplitProfile.totalOf(allocations), 10000);
    });

    test('the no-goal fallback is configurable and merges shares', () {
      expect(
        bp(
          ok(
            DefaultSplits.salary(
              defaults,
              goalShareFallback: BucketKind.living,
            ),
          ),
        ),
        {living: 5000, fun: 1000, emergency: 1000, short: 1000, long: 2000},
      );
      expect(
        bp(
          ok(
            DefaultSplits.salary(
              defaults,
              goalShareFallback: BucketKind.emergency,
            ),
          ),
        ),
        {living: 4000, fun: 1000, emergency: 2000, short: 1000, long: 2000},
      );
    });

    test('the fallback is unused when there is a goal', () {
      expect(
        bp(
          ok(
            DefaultSplits.salary(
              [...defaults, laptop],
              goalShareFallback: BucketKind.living,
            ),
          ),
        )[living],
        4000,
      );
    });

    test('fails when a default bucket is missing', () {
      expect(
        DefaultSplits.salary(defaults.where((b) => b.id != emergency).toList()),
        isErr('split.missingBucket'),
      );
    });
  });

  group('R-SPLIT-5 default side-hustle split', () {
    final restock = bucket('restock', BucketKind.business);

    test('Restock 30, Long 30, goal 20, Guilt-free 20', () {
      expect(bp(ok(DefaultSplits.sideHustle([...defaults, restock, laptop]))), {
        'restock': 3000,
        long: 3000,
        'laptop': 2000,
        fun: 2000,
      });
    });

    test('without a business bucket, Restock becomes Short-term', () {
      expect(bp(ok(DefaultSplits.sideHustle([...defaults, laptop]))), {
        short: 3000,
        long: 3000,
        'laptop': 2000,
        fun: 2000,
      });
    });

    test('with no goal, the goal share goes to Long-term (owner decision)', () {
      expect(bp(ok(DefaultSplits.sideHustle([...defaults, restock]))), {
        'restock': 3000,
        long: 5000,
        fun: 2000,
      });
    });

    test('the no-goal fallback is configurable', () {
      expect(
        bp(
          ok(
            DefaultSplits.sideHustle(
              defaults,
              goalShareFallback: BucketKind.shortTerm,
            ),
          ),
        ),
        {short: 5000, long: 3000, fun: 2000},
      );
    });
  });
}
