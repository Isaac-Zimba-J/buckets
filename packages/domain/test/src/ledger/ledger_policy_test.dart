import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

LedgerEntry entry(
  String id,
  LedgerEntryKind kind,
  int kwacha, {
  String bucket = 'living',
  String? counter,
}) => ok(
  LedgerEntry.create(
    id: id,
    occurredAt: utc,
    kind: kind,
    bucketId: bucket,
    amount: Money.kwacha(kwacha),
    counterBucketId: counter,
  ),
);

void main() {
  group('R-LEDGER-3 move', () {
    test('writes moveOut −x and moveIn +x with the same time and refs', () {
      final pair = ok(
        LedgerPolicy.move(
          ids: SequentialIds(),
          fromBucketId: 'fun',
          toBucketId: 'living',
          amount: const Money.kwacha(310),
          at: utc,
          refs: const LedgerRefs(transactionId: 't'),
        ),
      );
      expect(
        [
          for (final e in pair)
            (e.kind, e.bucketId, e.counterBucketId, e.amount),
        ],
        [
          (LedgerEntryKind.moveOut, 'fun', 'living', const Money.kwacha(-310)),
          (LedgerEntryKind.moveIn, 'living', 'fun', const Money.kwacha(310)),
        ],
      );
      expect(pair.map((e) => e.id).toSet(), hasLength(2));
      expect(pair.map((e) => e.refs.transactionId), everyElement('t'));
    });

    test('needs a positive amount and two different buckets', () {
      Result<List<LedgerEntry>> move(String to, Money amount, [DateTime? at]) =>
          LedgerPolicy.move(
            ids: SequentialIds(),
            fromBucketId: 'fun',
            toBucketId: to,
            amount: amount,
            at: at ?? utc,
          );
      expect(move('living', Money.zero), isErr('amount.notPositive'));
      expect(move('fun', const Money(1)), isErr('move.sameBucket'));
      expect(
        move('living', const Money(1), DateTime(2026)),
        isErr('occurredAt.notUtc'),
      );
    });
  });

  group('R-LEDGER-1 reverse', () {
    final spend = entry('s', LedgerEntryKind.spend, -185);

    test('appends a reversal with the negated amount', () {
      final reversals = ok(
        LedgerPolicy.reverse(
          [spend],
          existing: [spend],
          ids: SequentialIds(),
          at: utc,
        ),
      );
      final r = reversals.single;
      expect(r.kind, LedgerEntryKind.reversal);
      expect(r.amount, const Money.kwacha(185));
      expect(r.bucketId, 'living');
      expect(r.reversesEntryId, 's');
    });

    test('reverses both halves of a move together', () {
      final pair = [
        entry(
          'o',
          LedgerEntryKind.moveOut,
          -5,
          bucket: 'fun',
          counter: 'living',
        ),
        entry('i', LedgerEntryKind.moveIn, 5, counter: 'fun'),
      ];
      final reversals = ok(
        LedgerPolicy.reverse(
          pair,
          existing: pair,
          ids: SequentialIds(),
          at: utc,
        ),
      );
      expect(
        [for (final r in reversals) (r.bucketId, r.amount, r.counterBucketId)],
        [
          ('fun', const Money.kwacha(5), 'living'),
          ('living', const Money.kwacha(-5), 'fun'),
        ],
      );
    });

    test('an entry can only be reversed once', () {
      final first = ok(
        LedgerPolicy.reverse(
          [spend],
          existing: [spend],
          ids: SequentialIds(),
          at: utc,
        ),
      );
      expect(
        LedgerPolicy.reverse(
          [spend],
          existing: [spend, ...first],
          ids: SequentialIds(),
          at: utc,
        ),
        isErr('ledger.alreadyReversed'),
      );
    });
  });
}
