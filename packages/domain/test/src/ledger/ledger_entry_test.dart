import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Result<LedgerEntry> entry(
  LedgerEntryKind kind,
  int ngwee, {
  String? counter,
  String? reverses,
  DateTime? at,
}) => LedgerEntry.create(
  id: 'e',
  occurredAt: at ?? utc,
  kind: kind,
  bucketId: 'living',
  amount: Money(ngwee),
  counterBucketId: counter,
  reversesEntryId: reverses,
);

void main() {
  test('allocations are zero or positive, spends negative', () {
    expect(ok(entry(LedgerEntryKind.allocation, 0)).amount, Money.zero);
    expect(entry(LedgerEntryKind.allocation, -1), isErr('amount.sign'));
    expect(ok(entry(LedgerEntryKind.spend, -1)).amount, const Money(-1));
    expect(entry(LedgerEntryKind.spend, 0), isErr('amount.sign'));
  });

  test('R-LEDGER-3 moves are signed and name the other bucket', () {
    expect(
      ok(entry(LedgerEntryKind.moveOut, -5, counter: 'fun')).counterBucketId,
      'fun',
    );
    expect(
      ok(entry(LedgerEntryKind.moveIn, 5, counter: 'fun')).amount,
      const Money(5),
    );
    expect(
      entry(LedgerEntryKind.moveOut, 5, counter: 'fun'),
      isErr('amount.sign'),
    );
    expect(
      entry(LedgerEntryKind.moveIn, -5, counter: 'fun'),
      isErr('amount.sign'),
    );
    expect(entry(LedgerEntryKind.moveIn, 5), isErr('counterBucketId.missing'));
  });

  test('adjustments may go either way', () {
    expect(entry(LedgerEntryKind.adjustment, -9), isA<Ok<LedgerEntry>>());
    expect(entry(LedgerEntryKind.adjustment, 9), isA<Ok<LedgerEntry>>());
  });

  test('R-LEDGER-1 a reversal names the entry it reverses', () {
    expect(
      entry(LedgerEntryKind.reversal, 5),
      isErr('reversesEntryId.missing'),
    );
    expect(
      ok(entry(LedgerEntryKind.reversal, 5, reverses: 'e0')).reversesEntryId,
      'e0',
    );
  });

  test('R-TIME-1 occurredAt is UTC', () {
    expect(
      entry(LedgerEntryKind.allocation, 1, at: DateTime(2026)),
      isErr('occurredAt.notUtc'),
    );
  });

  test('refs default to none', () {
    final e = ok(entry(LedgerEntryKind.allocation, 1));
    expect(e.refs, LedgerRefs.none);
    expect(const LedgerRefs(paydayId: 'p'), isNot(LedgerRefs.none));
    expect(e.note, isNull);
  });
}
