import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

const lusaka = Duration(hours: 2);

SplitProfile profile(Map<String, int> bp) => ok(
  SplitProfile.create(
    id: 'p',
    allocations: [
      for (final MapEntry(:key, :value) in bp.entries)
        Allocation(key, BasisPoints(value)),
    ],
  ),
);

final SplitProfile salary = profile({
  'living': 4000,
  'fun': 1000,
  'emergency': 1000,
  'short': 1000,
  'long': 2000,
  'laptop': 1000,
});

final SplitProfile hustle = profile({
  'restock': 3000,
  'long': 3000,
  'laptop': 2000,
  'fun': 2000,
});

Goal goal(int targetKwacha, {DateTime? celebratedAt}) => ok(
  Goal.create(
    bucketId: 'laptop',
    target: Money.kwacha(targetKwacha),
    celebratedAt: celebratedAt,
  ),
);

void main() {
  group('R-GOAL-1 monthly contribution', () {
    test('salary allocation of the amount to split', () {
      expect(
        GoalProjector.monthlyContribution(
          bucketId: 'laptop',
          salaryToSplit: const Money.kwacha(7700),
          salaryProfile: salary,
          sideHustles: const [],
        ),
        const Money.kwacha(770),
      );
    });

    test('plus side-hustle share of its 3-month average', () {
      expect(
        GoalProjector.monthlyContribution(
          bucketId: 'laptop',
          salaryToSplit: const Money.kwacha(7700),
          salaryProfile: salary,
          sideHustles: [
            (
              profile: hustle,
              lastMonths: const [
                Money.kwacha(1000),
                Money.kwacha(2000),
                Money.kwacha(3000),
                Money.kwacha(9000), // older than 3 months: ignored
              ],
            ),
          ],
        ),
        // 770 + 20% × 2,000
        const Money.kwacha(1170),
      );
    });

    test('a side hustle with no history adds nothing', () {
      expect(
        GoalProjector.monthlyContribution(
          bucketId: 'laptop',
          salaryToSplit: null,
          salaryProfile: null,
          sideHustles: [(profile: hustle, lastMonths: const [])],
        ),
        Money.zero,
      );
    });

    test('a bucket in no split gets nothing', () {
      expect(
        GoalProjector.monthlyContribution(
          bucketId: 'house',
          salaryToSplit: const Money.kwacha(7700),
          salaryProfile: salary,
          sideHustles: [
            (profile: hustle, lastMonths: const [Money.kwacha(1000)]),
          ],
        ),
        Money.zero,
      );
    });
  });

  group('R-GOAL-2 ETA', () {
    final now = DateTime.utc(2026, 10, 30, 7);

    test('now + ceil(remaining / contribution) months', () {
      final eta = GoalProjector.eta(
        goal(9000),
        balance: const Money.kwacha(1300),
        monthlyContribution: const Money.kwacha(770),
        now: now,
        utcOffset: lusaka,
      );
      // 7,700 left / 770 = exactly 10 months.
      expect(eta, GoalEta.inMonths(10, LocalDate(2027, 8, 30)));
      final rounded = GoalProjector.eta(
        goal(9000),
        balance: const Money.kwacha(1299),
        monthlyContribution: const Money.kwacha(770),
        now: now,
        utcOffset: lusaka,
      );
      expect(rounded, GoalEta.inMonths(11, LocalDate(2027, 9, 30)));
    });

    test('month ends clamp to the last day', () {
      expect(
        GoalProjector.eta(
          goal(100),
          balance: Money.zero,
          monthlyContribution: const Money.kwacha(100),
          now: DateTime.utc(2027, 1, 31, 7),
          utcOffset: lusaka,
        ),
        GoalEta.inMonths(1, LocalDate(2027, 2, 28)),
      );
    });

    test('"not in any split yet" when the contribution is K 0', () {
      expect(
        GoalProjector.eta(
          goal(9000),
          balance: Money.zero,
          monthlyContribution: Money.zero,
          now: now,
          utcOffset: lusaka,
        ),
        const GoalEta.notInSplit(),
      );
    });

    test('reached when the balance is at or above target', () {
      expect(
        GoalProjector.eta(
          goal(9000),
          balance: const Money.kwacha(9000),
          monthlyContribution: Money.zero,
          now: now,
          utcOffset: lusaka,
        ),
        const GoalEta.reached(),
      );
    });
  });

  test('R-GOAL-3 emergency target = 3 × (bills + Living): K 22,140', () {
    expect(
      GoalProjector.emergencyTarget(
        monthlyBillReservations: const Money.kwacha(4300),
        livingAllocation: const Money.kwacha(3080),
      ),
      const Money.kwacha(22140),
    );
  });

  group('R-GOAL-4 reached', () {
    test('celebrate once, the first time the balance reaches the target', () {
      expect(
        GoalProjector.shouldCelebrate(goal(9000), const Money.kwacha(9000)),
        isTrue,
      );
      expect(
        GoalProjector.shouldCelebrate(goal(9000), const Money.kwacha(8999)),
        isFalse,
      );
      final done = ok(goal(9000).celebrated(utc));
      expect(done.celebratedAt, utc);
      expect(
        GoalProjector.shouldCelebrate(done, const Money.kwacha(9500)),
        isFalse,
      );
    });

    test('celebratedAt must be UTC', () {
      expect(
        Goal.create(
          bucketId: 'laptop',
          target: const Money(1),
          celebratedAt: DateTime(2026),
        ),
        isErr('celebratedAt.notUtc'),
      );
    });
  });
}
