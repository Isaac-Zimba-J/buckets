import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Bucket b(String id, BucketKind kind, {bool protected = false}) => ok(
  Bucket.create(
    id: id,
    name: id,
    kind: kind,
    color: BucketColor.goal,
    accountId: 'a',
    isProtected: protected,
  ),
);

final Bucket living = b('living', BucketKind.living);
final Bucket fun = b('fun', BucketKind.guiltFree);
final Bucket short = b('short', BucketKind.shortTerm);
final Bucket emergency = b('emergency', BucketKind.emergency);
final Bucket long = b('long', BucketKind.longTerm);
final List<Bucket> all = [living, fun, short, emergency, long];

void main() {
  test('R-OVER-1 overspent when the balance is below K 0', () {
    expect(
      OverspendPolicy.overspentBy(const Money.kwacha(-310)),
      const Money.kwacha(310),
    );
    expect(OverspendPolicy.overspentBy(Money.zero), isNull);
    expect(OverspendPolicy.overspentBy(const Money(5)), isNull);
  });

  group('R-OVER-2 cover options', () {
    List<CoverOption> options(
      Bucket overspent, {
      Map<String, Money> balances = const {},
      List<Bucket>? buckets,
    }) => OverspendPolicy.coverOptions(
      overspent: overspent,
      amount: const Money.kwacha(310),
      buckets: buckets ?? all,
      balances: {
        'fun': const Money.kwacha(500),
        'short': const Money.kwacha(1000),
        'emergency': const Money.kwacha(9000),
        'long': const Money.kwacha(9000),
        ...balances,
      },
    );

    test('Guilt-free, then Short-term, then next cycle', () {
      expect(options(living), [
        const CoverFromBucket('fun'),
        const CoverFromBucket('short'),
        const CoverFromNextCycle('living'),
      ]);
    });

    test('only buckets with enough balance', () {
      expect(
        options(living, balances: {'fun': const Money.kwacha(309)}),
        [const CoverFromBucket('short'), const CoverFromNextCycle('living')],
      );
      expect(
        options(living, balances: {'fun': const Money.kwacha(310)}).first,
        const CoverFromBucket('fun'),
      );
      expect(
        options(living, balances: {'fun': Money.zero, 'short': Money.zero}),
        [
          const CoverFromNextCycle('living'),
        ],
      );
    });

    test(
      'Emergency, Long-term and other protected buckets are never offered',
      () {
        final guarded = b('short', BucketKind.shortTerm, protected: true);
        expect(
          options(living, buckets: [living, fun, guarded, emergency, long]),
          [const CoverFromBucket('fun'), const CoverFromNextCycle('living')],
        );
      },
    );

    test('R-OVER-5 Guilt-free is only covered by next cycle Guilt-free', () {
      expect(options(fun), [const CoverFromNextCycle('fun')]);
    });

    test('a Short-term overspend is not covered from itself', () {
      expect(options(short), [
        const CoverFromBucket('fun'),
        const CoverFromNextCycle('short'),
      ]);
    });
  });

  group('R-OVER-3 cover', () {
    Result<List<LedgerEntry>> cover(CoverOption option, [Money? amount]) =>
        OverspendPolicy.cover(
          option,
          overspentBucketId: 'living',
          amount: amount ?? const Money.kwacha(310),
          ids: SequentialIds(),
          at: utc,
        );

    test('from a bucket writes a move for exactly the overspent amount', () {
      final entries = ok(cover(const CoverFromBucket('fun')));
      expect(
        [for (final e in entries) (e.kind, e.bucketId, e.amount)],
        [
          (LedgerEntryKind.moveOut, 'fun', const Money.kwacha(-310)),
          (LedgerEntryKind.moveIn, 'living', const Money.kwacha(310)),
        ],
      );
    });

    test('from next cycle writes a carry-over adjustment', () {
      final entries = ok(cover(const CoverFromNextCycle('living')));
      final e = entries.single;
      expect(e.kind, LedgerEntryKind.adjustment);
      expect(e.amount, const Money.kwacha(310));
      expect(e.refs.carryOverId, e.id);
      expect(OverspendPolicy.pendingCarryOvers(entries), {
        e.id: (bucketId: 'living', amount: const Money.kwacha(310)),
      });
    });

    test('the next payday settles carry-overs, reducing the allocation', () {
      final started = ok(cover(const CoverFromNextCycle('living')));
      final settle = ok(
        OverspendPolicy.settleCarryOvers(
          started,
          paydayId: 'p2',
          ids: SequentialIds(),
          at: utc,
        ),
      );
      final s = settle.single;
      expect(s.kind, LedgerEntryKind.adjustment);
      expect(s.amount, const Money.kwacha(-310));
      expect(s.refs.paydayId, 'p2');
      expect(s.refs.carryOverId, started.single.id);
      expect(s.bucketId, 'living');
      final both = [...started, ...settle];
      expect(OverspendPolicy.pendingCarryOvers(both), isEmpty);
      expect(BalanceCalculator.balance(both, 'living'), Money.zero);
    });

    test('needs a positive amount', () {
      expect(
        cover(const CoverFromNextCycle('living'), Money.zero),
        isErr('amount.notPositive'),
      );
      expect(
        cover(const CoverFromBucket('fun'), Money.zero),
        isErr('amount.notPositive'),
      );
    });
  });

  group('R-OVER-4 split may be too tight', () {
    final cycles = [
      for (final m in [8, 9, 10])
        ok(DateWindow.create(DateTime.utc(2026, m), DateTime.utc(2026, m + 1))),
    ];
    LedgerEntry e(
      String id,
      LedgerEntryKind kind,
      int kwacha,
      int month, [
      int day = 2,
    ]) => ok(
      LedgerEntry.create(
        id: id,
        occurredAt: DateTime.utc(2026, month, day),
        kind: kind,
        bucketId: 'living',
        amount: Money.kwacha(kwacha),
      ),
    );

    test('a cycle counts when the running balance dipped below K 0', () {
      final entries = [
        e('a8', LedgerEntryKind.allocation, 100, 8),
        e('s8', LedgerEntryKind.spend, -150, 8, 3),
        e('c8', LedgerEntryKind.adjustment, 50, 8, 4),
      ];
      expect(
        OverspendPolicy.wasOverspentIn(entries, 'living', cycles[0]),
        isTrue,
      );
      expect(
        OverspendPolicy.wasOverspentIn(entries, 'living', cycles[1]),
        isFalse,
      );
    });

    test('a balance carried in from before the cycle counts', () {
      final entries = [
        e('a8', LedgerEntryKind.allocation, 100, 8),
        e('s9', LedgerEntryKind.spend, -90, 9),
        e('s9b', LedgerEntryKind.spend, -20, 9, 5),
      ];
      expect(
        OverspendPolicy.wasOverspentIn(entries, 'living', cycles[1]),
        isTrue,
      );
    });

    test('tip when overspent in 2 of the last 3 cycles, oldest first', () {
      expect(OverspendPolicy.suggestSplitReview([true, false, true]), isTrue);
      expect(OverspendPolicy.suggestSplitReview([true, false, false]), isFalse);
      expect(
        OverspendPolicy.suggestSplitReview([false, false, false, true, true]),
        isTrue,
      );
      expect(
        OverspendPolicy.suggestSplitReview([true, true, false, false, false]),
        isFalse,
      );
    });
  });
}
