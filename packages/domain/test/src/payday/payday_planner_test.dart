import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

const lusaka = Duration(hours: 2);

Bucket bucket(String id, BucketKind kind, String account) => ok(
  Bucket.create(
    id: id,
    name: id,
    kind: kind,
    color: BucketColor.goal,
    accountId: account,
  ),
);

final List<Bucket> buckets = [
  bucket('living', BucketKind.living, 'momo'),
  bucket('fun', BucketKind.guiltFree, 'momo'),
  bucket('emergency', BucketKind.emergency, 'savings'),
  bucket('short', BucketKind.shortTerm, 'savings'),
  bucket('long', BucketKind.longTerm, 'invest'),
  bucket('laptop', BucketKind.goal, 'savings'),
];

final IncomeSource salary = ok(
  IncomeSource.create(
    id: 'salary',
    name: 'Salary',
    kind: IncomeKind.salary,
    schedule: const MonthlyPay(25),
    landsInAccountId: 'momo',
    splitProfileId: 'p',
  ),
);

final SplitProfile profile = ok(
  SplitProfile.create(
    id: 'p',
    allocations: [
      for (final (id, bp) in [
        ('living', 4000),
        ('fun', 1000),
        ('emergency', 1000),
        ('short', 1000),
        ('long', 2000),
        ('laptop', 1000),
      ])
        Allocation(id, BasisPoints(bp)),
    ],
  ),
);

const bills = [
  BillReservation(
    billId: 'rent',
    bucketId: 'living',
    amount: Money.kwacha(2500),
  ),
  BillReservation(
    billId: 'zesco',
    bucketId: 'living',
    amount: Money.kwacha(400),
  ),
  BillReservation(
    billId: 'water',
    bucketId: 'living',
    amount: Money.kwacha(600),
  ),
  BillReservation(
    billId: 'fees',
    bucketId: 'living',
    amount: Money.kwacha(800),
  ),
];

final now = DateTime.utc(2026, 10, 25, 6);

StartedPayday start({
  IncomeSource? income,
  List<BillReservation> bills = bills,
}) => ok(
  PaydayPlanner.start(
    ids: SequentialIds(),
    income: income ?? salary,
    amount: const Money.kwacha(12000),
    profile: profile,
    buckets: buckets,
    bills: bills,
    now: now,
  ),
);

Map<String, int> kwachaBy(Iterable<(String, Money)> pairs) => {
  for (final (k, v) in pairs) k: v.ngwee ~/ 100,
};

void main() {
  group('R-PAY-1 starting a payday', () {
    test('writes an allocation for every bucket in the split', () {
      final started = start();
      final splits = started.entries.where((e) => e.refs.billId == null);
      expect(kwachaBy([for (final e in splits) (e.bucketId, e.amount)]), {
        'living': 3080,
        'fun': 770,
        'emergency': 770,
        'short': 770,
        'long': 1540,
        'laptop': 770,
      });
      expect(
        started.entries.map((e) => e.kind),
        everyElement(LedgerEntryKind.allocation),
      );
      expect(
        started.entries.map((e) => e.refs.paydayId),
        everyElement(started.payday.id),
      );
      expect(started.entries.map((e) => e.occurredAt), everyElement(now));
    });

    test('reserves each bill in its paying bucket (owner decision)', () {
      final billEntries = start().entries
          .where((e) => e.refs.billId != null)
          .toList();
      expect(
        kwachaBy([for (final e in billEntries) (e.refs.billId!, e.amount)]),
        {'rent': 2500, 'zesco': 400, 'water': 600, 'fees': 800},
      );
      expect(billEntries.map((e) => e.bucketId), everyElement('living'));
    });

    test('side hustles skip bills', () {
      final hustle = ok(
        IncomeSource.create(
          id: 'h',
          name: 'Hustle',
          kind: IncomeKind.sideHustle,
          schedule: const IrregularPay(),
          landsInAccountId: 'momo',
          splitProfileId: 'p',
        ),
      );
      final started = start(income: hustle);
      expect(started.entries.where((e) => e.refs.billId != null), isEmpty);
      expect(
        started.entries.fold(Money.zero, (s, e) => s + e.amount),
        const Money.kwacha(12000),
      );
    });

    test('R-SPLIT-2 fails when bills exceed income', () {
      expect(
        PaydayPlanner.start(
          ids: SequentialIds(),
          income: salary,
          amount: const Money.kwacha(4000),
          profile: profile,
          buckets: buckets,
          bills: bills,
          now: now,
        ),
        isErr('billsExceedIncome'),
      );
    });

    test('fails when a split bucket is unknown', () {
      expect(
        PaydayPlanner.start(
          ids: SequentialIds(),
          income: salary,
          amount: const Money.kwacha(12000),
          profile: profile,
          buckets: buckets.where((b) => b.id != 'long').toList(),
          bills: bills,
          now: now,
        ),
        isErr('bucket.notFound'),
      );
    });
  });

  group('R-PAY-2 transfers', () {
    test('only for buckets in another account: 4 transfers, K 3,850', () {
      final p = start().payday;
      expect(kwachaBy([for (final t in p.transfers) (t.bucketId, t.amount)]), {
        'emergency': 770,
        'short': 770,
        'long': 1540,
        'laptop': 770,
      });
      expect(
        p.transfers.fold(Money.zero, (s, t) => s + t.amount),
        const Money.kwacha(3850),
      );
      expect(
        {for (final t in p.transfers) t.bucketId: t.toAccountId}['long'],
        'invest',
      );
      expect(
        p.transfers.map((t) => t.status),
        everyElement(TransferStatus.pending),
      );
      expect(p.status, PaydayStatus.open);
      expect(p.amount, const Money.kwacha(12000));
    });

    test('bill money for a bucket in another account moves too', () {
      final p = start(
        bills: const [
          BillReservation(
            billId: 'fees',
            bucketId: 'short',
            amount: Money.kwacha(800),
          ),
        ],
      ).payday;
      expect(
        p.transfers.firstWhere((t) => t.bucketId == 'short').amount,
        // K 11,200 split → Short-term K 1,120, plus the K 800 bill.
        const Money.kwacha(1920),
      );
    });
  });

  group('R-PAY-3 completion', () {
    Transfer t(TransferStatus status, {Money? owed}) => ok(
      Transfer.create(
        id: 't',
        bucketId: 'b',
        toAccountId: 'a',
        amount: const Money(100),
        status: status,
        owedAmount: owed,
      ),
    );
    Payday withTransfers(List<Transfer> transfers) => ok(
      Payday.create(
        id: 'p',
        incomeSourceId: 's',
        amount: const Money(100),
        startedAt: now,
        transfers: transfers,
      ),
    );

    test('complete when every transfer is proven or self-reported', () {
      final p = withTransfers([
        t(TransferStatus.proven),
        t(TransferStatus.selfReported),
      ]);
      expect(PaydayPlanner.isComplete(p), isTrue);
      expect(PaydayPlanner.refreshStatus(p).status, PaydayStatus.complete);
    });

    test('open while anything is pending or still owed', () {
      expect(
        PaydayPlanner.isComplete(withTransfers([t(TransferStatus.pending)])),
        isFalse,
      );
      expect(
        PaydayPlanner.isComplete(
          withTransfers([t(TransferStatus.partial, owed: const Money(1))]),
        ),
        isFalse,
      );
      expect(
        PaydayPlanner.refreshStatus(withTransfers([t(TransferStatus.pending)]))
            .status,
        PaydayStatus.open,
      );
    });

    test('a payday with no transfers is complete', () {
      expect(PaydayPlanner.isComplete(withTransfers(const [])), isTrue);
    });
  });

  group('R-PAY-4 snooze', () {
    final open = start().payday;
    (Payday, DateTime) snooze(DateTime at, {Payday? p, int limit = 1}) => ok(
      PaydayPlanner.snooze(
        p ?? open,
        now: at,
        utcOffset: lusaka,
        snoozeLimit: limit,
      ),
    );

    test('delays to 20:00 the same day', () {
      final (p, alarmAt) = snooze(DateTime.utc(2026, 10, 25, 8)); // 10:00
      expect(alarmAt, DateTime.utc(2026, 10, 25, 18)); // 20:00 local
      expect(p.snoozesUsed, 1);
      expect(p.snoozedUntil, alarmAt);
    });

    test('at 18:00 and later it delays by 2 hours', () {
      expect(
        snooze(DateTime.utc(2026, 10, 25, 16)).$2,
        DateTime.utc(2026, 10, 25, 18),
      ); // 18:00 → 20:00
      expect(
        snooze(DateTime.utc(2026, 10, 25, 16, 1)).$2,
        DateTime.utc(2026, 10, 25, 18, 1),
      ); // 18:01 → 20:01
      expect(
        snooze(DateTime.utc(2026, 10, 25, 18, 59)).$2,
        DateTime.utc(2026, 10, 25, 20, 59),
      ); // 20:59 → 22:59
    });

    test('is not allowed from 21:00', () {
      for (final at in [
        DateTime.utc(2026, 10, 25, 19), // 21:00
        DateTime.utc(2026, 10, 25, 21, 59), // 23:59
      ]) {
        expect(
          PaydayPlanner.snooze(
            open,
            now: at,
            utcOffset: lusaka,
            snoozeLimit: 1,
          ),
          isErr('snooze.tooLate'),
        );
      }
    });

    test('allowed again after midnight, before 21:00', () {
      expect(
        snooze(DateTime.utc(2026, 10, 25, 23)).$2,
        DateTime.utc(2026, 10, 26, 18),
      ); // 01:00 → 20:00
    });

    test('snoozeAlarmAt previews the same time without using a snooze', () {
      DateTime? at(DateTime now) =>
          PaydayPlanner.snoozeAlarmAt(now, utcOffset: lusaka);
      // 10:00 local → 20:00 local (18:00 UTC).
      expect(at(DateTime.utc(2026, 10, 25, 8)), DateTime.utc(2026, 10, 25, 18));
      // 18:00 local exactly → 20:00 both ways.
      expect(
        at(DateTime.utc(2026, 10, 25, 16)),
        DateTime.utc(2026, 10, 25, 18),
      );
      // 18:01 local → +2 h.
      expect(
        at(DateTime.utc(2026, 10, 25, 16, 1)),
        DateTime.utc(2026, 10, 25, 18, 1),
      );
      // 20:59 local → +2 h; 21:00 local → none.
      expect(
        at(DateTime.utc(2026, 10, 25, 18, 59)),
        DateTime.utc(2026, 10, 25, 20, 59),
      );
      expect(at(DateTime.utc(2026, 10, 25, 19)), isNull);
      for (final now in [
        DateTime.utc(2026, 10, 25, 8),
        DateTime.utc(2026, 10, 25, 17),
      ]) {
        expect(at(now), snooze(now).$2);
      }
    });

    test('respects the snooze limit', () {
      final (once, _) = snooze(DateTime.utc(2026, 10, 25, 8));
      expect(
        PaydayPlanner.snooze(
          once,
          now: DateTime.utc(2026, 10, 25, 9),
          utcOffset: lusaka,
          snoozeLimit: 1,
        ),
        isErr('snooze.noneLeft'),
      );
      expect(
        PaydayPlanner.snooze(
          open,
          now: DateTime.utc(2026, 10, 25, 9),
          utcOffset: lusaka,
          snoozeLimit: 0,
        ),
        isErr('snooze.noneLeft'),
      );
      expect(
        snooze(DateTime.utc(2026, 10, 25, 9), p: once, limit: 2).$1.snoozesUsed,
        2,
      );
    });

    test('a complete payday cannot be snoozed', () {
      final done = ok(
        Payday.create(
          id: 'p',
          incomeSourceId: 's',
          amount: const Money(1),
          startedAt: now,
          transfers: const [],
          status: PaydayStatus.complete,
        ),
      );
      expect(
        PaydayPlanner.snooze(
          done,
          now: DateTime.utc(2026, 10, 25, 9),
          utcOffset: lusaka,
          snoozeLimit: 1,
        ),
        isErr('snooze.notNeeded'),
      );
    });
  });

  test('R-PAY-5 unlocked when complete, snoozed, or no payday is open', () {
    final open = start().payday;
    expect(PaydayPlanner.isUnlocked(null), isTrue);
    expect(PaydayPlanner.isUnlocked(open), isFalse);
    final (snoozed, _) = ok(
      PaydayPlanner.snooze(
        open,
        now: DateTime.utc(2026, 10, 25, 8),
        utcOffset: lusaka,
        snoozeLimit: 1,
      ),
    );
    expect(PaydayPlanner.isUnlocked(snoozed), isTrue);
    expect(
      PaydayPlanner.isUnlocked(
        ok(open.copyWith(status: PaydayStatus.complete)),
      ),
      isTrue,
    );
  });

  group('R-PAY-6 side-hustle holding', () {
    test('releases on the last day of the month at 18:00 local', () {
      expect(
        PaydayPlanner.holdReleaseAt(
          DateTime.utc(2026, 11, 3),
          utcOffset: lusaka,
        ),
        DateTime.utc(2026, 11, 30, 16),
      );
      expect(
        PaydayPlanner.holdReleaseAt(
          DateTime.utc(2028, 2, 10),
          utcOffset: lusaka,
        ),
        DateTime.utc(2028, 2, 29, 16),
      );
    });

    test('after the release time it is next month', () {
      expect(
        PaydayPlanner.holdReleaseAt(
          DateTime.utc(2026, 11, 30, 16),
          utcOffset: lusaka,
        ),
        DateTime.utc(2026, 12, 31, 16),
      );
    });
  });
}
