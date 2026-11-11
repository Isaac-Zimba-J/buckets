import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Bucket bucket(BucketKind kind, {String id = 'b'}) => ok(
  Bucket.create(
    id: id,
    name: kind.name,
    kind: kind,
    color: BucketColor.long,
    accountId: 'savings',
  ),
);

LedgerEntry alloc(String bucketId, int kwacha, DateTime at, {String? billId}) =>
    ok(
      LedgerEntry.create(
        id: 'e-$bucketId-${at.millisecondsSinceEpoch}-$kwacha',
        occurredAt: at,
        kind: LedgerEntryKind.allocation,
        bucketId: bucketId,
        amount: Money.kwacha(kwacha),
        refs: billId == null ? LedgerRefs.none : LedgerRefs(billId: billId),
      ),
    );

void main() {
  final t0 = DateTime.utc(2026, 10, 25, 6);
  final before = DateTime.utc(2026, 10);

  group('available (R-MOVE-1)', () {
    test('a saving bucket offers its whole balance', () {
      final b = bucket(BucketKind.shortTerm, id: 's');
      expect(
        MovePolicy.available(b, [alloc('s', 1000, t0)]),
        const Money.kwacha(1000),
      );
    });

    test('a spending bucket offers left to spend, bill money held back', () {
      final b = bucket(BucketKind.living, id: 'l');
      final entries = [
        alloc('l', 1000, t0),
        alloc('l', 300, t0, billId: 'rent'),
      ];
      expect(MovePolicy.available(b, entries), const Money.kwacha(1000));
    });

    test('never below zero', () {
      final b = bucket(BucketKind.shortTerm, id: 's');
      final overspent = ok(
        LedgerEntry.create(
          id: 'e-neg',
          occurredAt: t0,
          kind: LedgerEntryKind.spend,
          bucketId: 's',
          amount: const Money.kwacha(-50),
        ),
      );
      expect(MovePolicy.available(b, [overspent]), Money.zero);
    });
  });

  group('warningFor (R-MOVE-2)', () {
    test('a protected source always warns', () {
      final b = bucket(BucketKind.longTerm, id: 'lt');
      expect(
        MovePolicy.warningFor(
          from: b,
          amount: const Money.kwacha(10),
          entries: [alloc('lt', 1000, before)],
          cycleStart: t0,
        ),
        MoveWarning.fromProtected,
      );
    });

    test('a spending source never warns on the cycle-start rule', () {
      final b = bucket(BucketKind.living, id: 'l');
      expect(
        MovePolicy.warningFor(
          from: b,
          amount: const Money.kwacha(900),
          entries: [alloc('l', 1000, before)],
          cycleStart: t0,
        ),
        isNull,
      );
    });

    test('a saving move below start-of-cycle warns', () {
      final b = bucket(BucketKind.shortTerm, id: 's');
      final entries = [alloc('s', 1000, before), alloc('s', 500, t0)];
      expect(
        MovePolicy.warningFor(
          from: b,
          amount: const Money.kwacha(600),
          entries: entries,
          cycleStart: t0,
        ),
        MoveWarning.belowCycleStart,
      );
    });

    test('a saving move that stays above start-of-cycle does not warn', () {
      final b = bucket(BucketKind.shortTerm, id: 's');
      final entries = [alloc('s', 1000, before), alloc('s', 500, t0)];
      expect(
        MovePolicy.warningFor(
          from: b,
          amount: const Money.kwacha(400),
          entries: entries,
          cycleStart: t0,
        ),
        isNull,
      );
    });

    test('without a cycle, only protected warns', () {
      final s = bucket(BucketKind.shortTerm, id: 's');
      expect(
        MovePolicy.warningFor(
          from: s,
          amount: const Money.kwacha(400),
          entries: [alloc('s', 1000, before)],
          cycleStart: null,
        ),
        isNull,
      );
    });
  });
}
