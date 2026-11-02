import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

final DateTime lastCountAt = DateTime.utc(2026, 10, 25, 16);
final DateTime before = DateTime.utc(2026, 10, 24);
final DateTime after = DateTime.utc(2026, 10, 27);

CashWithdrawal withdrawal(int kwacha, DateTime at) => ok(
  CashWithdrawal.create(
    id: 'w$kwacha',
    amount: Money.kwacha(kwacha),
    fromAccountId: 'momo',
    cashAccountId: 'cash',
    occurredAt: at,
  ),
);

Transaction spend(
  int kwacha,
  DateTime at, {
  String account = 'cash',
  String bucket = 'living',
  Category category = Category.food,
}) => ok(
  Transaction.create(
    id: 't$kwacha${at.day}',
    amount: Money.kwacha(kwacha),
    bucketId: bucket,
    category: category,
    accountId: account,
    occurredAt: at,
    source: TransactionSource.cash,
  ),
);

void main() {
  final last = ok(
    CheckIn.create(
      id: 'c0',
      countedAt: lastCountAt,
      expectedCash: const Money.kwacha(300),
      countedCash: const Money.kwacha(250),
    ),
  );

  group('R-CASH-1 expected cash', () {
    test('last counted + withdrawals since − cash spends since', () {
      expect(
        CashReconciler.expectedCash(
          lastCheckIn: last,
          cashAccountId: 'cash',
          withdrawals: [withdrawal(500, after), withdrawal(900, before)],
          transactions: [
            spend(120, after),
            spend(40, before),
            spend(70, after, account: 'momo'),
          ],
        ),
        // 250 + 500 − 120
        const Money.kwacha(630),
      );
    });

    test('before the first count it starts from K 0', () {
      expect(
        CashReconciler.expectedCash(
          lastCheckIn: null,
          cashAccountId: 'cash',
          withdrawals: [withdrawal(500, before)],
          transactions: [spend(120, after)],
        ),
        const Money.kwacha(380),
      );
    });

    test('entries at the moment of the last count are already counted', () {
      expect(
        CashReconciler.expectedCash(
          lastCheckIn: last,
          cashAccountId: 'cash',
          withdrawals: [withdrawal(500, lastCountAt)],
          transactions: const [],
        ),
        const Money.kwacha(250),
      );
    });
  });

  group('R-CASH-2 positive gap', () {
    test('is recorded as one Untracked adjustment from Living', () {
      final (tx, entry) = ok(
        CashReconciler.recordUntracked(
          gap: const Money.kwacha(150),
          livingBucketId: 'living',
          cashAccountId: 'cash',
          ids: SequentialIds(),
          at: utc,
        ),
      );
      expect(tx.category, Category.untracked);
      expect(tx.amount, const Money.kwacha(150));
      expect(tx.bucketId, 'living');
      expect(tx.accountId, 'cash');
      expect(tx.source, TransactionSource.cash);
      expect(entry.kind, LedgerEntryKind.adjustment);
      expect(entry.amount, const Money.kwacha(-150));
      expect(entry.bucketId, 'living');
      expect(entry.refs.transactionId, tx.id);
    });

    test('only for a positive gap', () {
      expect(
        CashReconciler.recordUntracked(
          gap: Money.zero,
          livingBucketId: 'living',
          cashAccountId: 'cash',
          ids: SequentialIds(),
          at: utc,
        ),
        isErr('gap.notPositive'),
      );
    });
  });

  group('R-CASH-3 negative gap', () {
    test('received cash can be added to Living', () {
      final entry = ok(
        CashReconciler.recordReceived(
          extra: const Money.kwacha(50),
          intoLivingBucketId: 'living',
          ids: SequentialIds(),
          at: utc,
        ),
      )!;
      expect(entry.kind, LedgerEntryKind.adjustment);
      expect(entry.amount, const Money.kwacha(50));
      expect(entry.bucketId, 'living');
    });

    test('kept as Cash in hand, no bucket changes', () {
      expect(
        ok(
          CashReconciler.recordReceived(
            extra: const Money.kwacha(50),
            intoLivingBucketId: null,
            ids: SequentialIds(),
            at: utc,
          ),
        ),
        isNull,
      );
    });

    test('only for extra cash', () {
      expect(
        CashReconciler.recordReceived(
          extra: const Money(-1),
          intoLivingBucketId: 'living',
          ids: SequentialIds(),
          at: utc,
        ),
        isErr('gap.notPositive'),
      );
    });
  });

  group('R-CHECKIN-1 steps', () {
    test('sort first when alerts are waiting, then count, then summary', () {
      expect(CheckInFlow.steps(unsortedAlerts: 3), [
        CheckInStep.sort,
        CheckInStep.count,
        CheckInStep.summary,
      ]);
      expect(CheckInFlow.steps(unsortedAlerts: 0), [
        CheckInStep.count,
        CheckInStep.summary,
      ]);
    });

    test('the gap decides what to ask after counting', () {
      expect(CheckInFlow.gapPrompt(const Money(1)), GapPrompt.missingCash);
      expect(CheckInFlow.gapPrompt(Money.zero), GapPrompt.none);
      expect(CheckInFlow.gapPrompt(const Money(-1)), GapPrompt.receivedCash);
    });
  });

  group('R-CHECKIN-1 week summary', () {
    final week = ok(
      DateWindow.create(DateTime.utc(2026, 10, 25), DateTime.utc(2026, 11)),
    );
    final cycle = ok(
      DateWindow.create(DateTime.utc(2026, 10, 25), DateTime.utc(2026, 11, 25)),
    );
    LedgerEntry e(
      String id,
      LedgerEntryKind kind,
      int kwacha,
      String bucket,
      DateTime at, {
      String? bill,
    }) => ok(
      LedgerEntry.create(
        id: id,
        occurredAt: at,
        kind: kind,
        bucketId: bucket,
        amount: Money.kwacha(kwacha),
        refs: LedgerRefs(billId: bill),
      ),
    );
    final buckets = [
      for (final (id, kind) in [
        ('living', BucketKind.living),
        ('fun', BucketKind.guiltFree),
        ('emergency', BucketKind.emergency),
        ('laptop', BucketKind.goal),
      ])
        ok(
          Bucket.create(
            id: id,
            name: id,
            kind: kind,
            color: BucketColor.goal,
            accountId: 'a',
          ),
        ),
    ];
    final at = DateTime.utc(2026, 10, 27);

    test('spent per bucket this week, saved this cycle, untracked total', () {
      final summary = CheckInFlow.weekSummary(
        entries: [
          e('a1', LedgerEntryKind.allocation, 3080, 'living', at),
          e('a2', LedgerEntryKind.allocation, 2500, 'living', at, bill: 'rent'),
          e('a3', LedgerEntryKind.allocation, 770, 'emergency', at),
          e('a4', LedgerEntryKind.allocation, 770, 'laptop', at),
          e('a5', LedgerEntryKind.allocation, 770, 'fun', at),
          e('s1', LedgerEntryKind.spend, -185, 'living', at),
          e('s2', LedgerEntryKind.spend, -60, 'fun', at),
          e(
            'old',
            LedgerEntryKind.spend,
            -999,
            'living',
            DateTime.utc(2026, 10),
          ),
        ],
        transactions: [
          spend(150, at, category: Category.untracked),
          spend(40, at),
          spend(99, DateTime.utc(2026, 10), category: Category.untracked),
        ],
        buckets: buckets,
        week: week,
        cycle: cycle,
      );
      expect(summary.spentByBucket, {
        'living': const Money.kwacha(185),
        'fun': const Money.kwacha(60),
      });
      expect(summary.savedThisCycle, const Money.kwacha(1540));
      expect(summary.untrackedTotal, const Money.kwacha(150));
    });
  });
}
