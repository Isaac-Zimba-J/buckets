import 'dart:math';

import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Allocation a(String bucketId, int bp) => Allocation(bucketId, BasisPoints(bp));

SplitProfile profile(List<Allocation> allocations) =>
    ok(SplitProfile.create(id: 'p', allocations: allocations));

Map<String, int> kwacha(List<BucketShare> shares) => {
  for (final s in shares) s.bucketId: s.amount.ngwee ~/ 100,
};

void main() {
  group('R-SPLIT-2 amount to split', () {
    test('deducts bill reservations first when asked', () {
      expect(
        ok(
          SplitCalculator.amountToSplit(
            income: const Money.kwacha(12000),
            deductBillsFirst: true,
            billReservations: const Money.kwacha(4300),
          ),
        ),
        const Money.kwacha(7700),
      );
    });

    test('ignores bills for side hustles', () {
      expect(
        ok(
          SplitCalculator.amountToSplit(
            income: const Money.kwacha(2000),
            deductBillsFirst: false,
            billReservations: const Money.kwacha(4300),
          ),
        ),
        const Money.kwacha(2000),
      );
    });

    test('fails with billsExceedIncome when bills are more than income', () {
      expect(
        SplitCalculator.amountToSplit(
          income: const Money.kwacha(4000),
          deductBillsFirst: true,
          billReservations: const Money.kwacha(4300),
        ),
        isErr('billsExceedIncome'),
      );
      expect(
        ok(
          SplitCalculator.amountToSplit(
            income: const Money.kwacha(4300),
            deductBillsFirst: true,
            billReservations: const Money.kwacha(4300),
          ),
        ),
        Money.zero,
      );
    });
  });

  group('R-SPLIT-3 split', () {
    test('R-SPLIT-4 canvas example: K 7,700 → 3,080/770/770/770/1,540/770', () {
      final p = profile([
        a('living', 4000),
        a('fun', 1000),
        a('emergency', 1000),
        a('short', 1000),
        a('long', 2000),
        a('laptop', 1000),
      ]);
      expect(
        kwacha(
          SplitCalculator.split(
            const Money.kwacha(7700),
            p,
            livingBucketId: 'living',
          ),
        ),
        {
          'living': 3080,
          'fun': 770,
          'emergency': 770,
          'short': 770,
          'long': 1540,
          'laptop': 770,
        },
      );
    });

    test('floors each share and gives leftover ngwee to Living', () {
      final p = profile([a('x', 3333), a('living', 3333), a('y', 3334)]);
      final shares = SplitCalculator.split(
        const Money(100),
        p,
        livingBucketId: 'living',
      );
      expect([for (final s in shares) s.amount.ngwee], [33, 34, 33]);
    });

    test(
      'without Living, leftover goes to the largest share, first on ties',
      () {
        final p = profile([a('x', 2500), a('y', 5000), a('z', 2500)]);
        expect(
          [
            for (final s in SplitCalculator.split(const Money(3), p))
              s.amount.ngwee,
          ],
          [0, 3, 0],
        );
        final tie = profile([a('x', 3000), a('y', 3500), a('z', 3500)]);
        expect(
          [
            for (final s in SplitCalculator.split(const Money(1), tie))
              s.amount.ngwee,
          ],
          [0, 1, 0],
        );
      },
    );

    test('a Living bucket outside the profile is ignored', () {
      final p = profile([a('x', 5000), a('y', 5000)]);
      expect(
        [
          for (final s in SplitCalculator.split(
            const Money(1),
            p,
            livingBucketId: 'living',
          ))
            s.amount.ngwee,
        ],
        [1, 0],
      );
    });

    test('splitting K 0 gives K 0 to everyone', () {
      final p = profile([a('living', 5000), a('y', 5000)]);
      expect(
        SplitCalculator.split(
          Money.zero,
          p,
          livingBucketId: 'living',
        ).map((s) => s.amount),
        everyElement(Money.zero),
      );
    });

    test('rejects a negative amount', () {
      expect(
        () => SplitCalculator.split(
          const Money(-1),
          profile([a('x', 10000)]),
        ),
        throwsArgumentError,
      );
    });

    test('R-SPLIT-3 property: shares always add up to the amount', () {
      final random = Random(42);
      for (var run = 0; run < 2000; run++) {
        final count = 1 + random.nextInt(8);
        final cuts = [
          for (var i = 0; i < count - 1; i++) random.nextInt(10001),
        ]..sort();
        final bounds = [0, ...cuts, 10000];
        final allocations = [
          for (var i = 0; i < count; i++) a('b$i', bounds[i + 1] - bounds[i]),
        ];
        final amount = Money(random.nextInt(100000000));
        final living = random.nextBool() ? 'b${random.nextInt(count)}' : null;
        final shares = SplitCalculator.split(
          amount,
          profile(allocations),
          livingBucketId: living,
        );
        final total = shares.fold(Money.zero, (sum, s) => sum + s.amount);
        expect(total, amount, reason: 'run $run');
        for (final (i, share) in shares.indexed) {
          final floor = allocations[i].bp.applyTo(amount);
          expect(share.amount >= floor, isTrue, reason: 'run $run');
          expect(share.amount - floor < Money(count), isTrue);
        }
      }
    });
  });
}
