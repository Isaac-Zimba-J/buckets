import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

final DateWindow cycle = ok(
  DateWindow.create(
    DateTime.utc(2026, 10, 25, 6),
    DateTime.utc(2026, 11, 24, 22),
  ),
);
final inCycle = DateTime.utc(2026, 10, 30, 7);
final lastCycle = DateTime.utc(2026, 10, 20);

LedgerEntry e(
  String id,
  LedgerEntryKind kind,
  int kwacha, {
  String bucket = 'living',
  DateTime? at,
  String? reverses,
}) => ok(
  LedgerEntry.create(
    id: id,
    occurredAt: at ?? inCycle,
    kind: kind,
    bucketId: bucket,
    amount: Money.kwacha(kwacha),
    counterBucketId:
        kind == LedgerEntryKind.moveIn || kind == LedgerEntryKind.moveOut
        ? 'other'
        : null,
    reversesEntryId: reverses,
  ),
);

void main() {
  final entries = [
    e('a', LedgerEntryKind.allocation, 3080, at: lastCycle),
    e('s1', LedgerEntryKind.spend, -185, at: lastCycle),
    e('a2', LedgerEntryKind.allocation, 3080),
    e('s2', LedgerEntryKind.spend, -320),
    e('s3', LedgerEntryKind.spend, -100),
    e('r3', LedgerEntryKind.reversal, 100, reverses: 's3'),
    e('mi', LedgerEntryKind.moveIn, 310),
    e('mo', LedgerEntryKind.moveOut, -50),
    e('adj', LedgerEntryKind.adjustment, -40),
    e('f1', LedgerEntryKind.allocation, 770, bucket: 'fun'),
    e('f2', LedgerEntryKind.spend, -900, bucket: 'fun'),
  ];

  test('R-LEDGER-2 balance = sum of the bucket entries', () {
    // 3080 − 185 + 3080 − 320 − 100 + 100 + 310 − 50 − 40
    expect(
      BalanceCalculator.balance(entries, 'living'),
      const Money.kwacha(5875),
    );
    expect(BalanceCalculator.balance(entries, 'none'), Money.zero);
  });

  test('balances for every bucket at once', () {
    expect(BalanceCalculator.balances(entries), {
      'living': const Money.kwacha(5875),
      'fun': const Money.kwacha(-130),
    });
  });

  test('R-LEDGER-2 cycle spend counts spends in the cycle only', () {
    expect(
      BalanceCalculator.cycleSpend(entries, 'living', cycle),
      const Money.kwacha(320),
    );
    expect(
      BalanceCalculator.cycleSpend(entries, 'fun', cycle),
      const Money.kwacha(900),
    );
  });

  test('a reversed spend is netted out of its cycle (owner decision)', () {
    final reversedLater = [
      e('s', LedgerEntryKind.spend, -200),
      e(
        'r',
        LedgerEntryKind.reversal,
        200,
        at: DateTime.utc(2026, 12),
        reverses: 's',
      ),
      e('old', LedgerEntryKind.spend, -50, at: lastCycle),
      e('rOld', LedgerEntryKind.reversal, 50, reverses: 'old'),
    ];
    expect(
      BalanceCalculator.cycleSpend(reversedLater, 'living', cycle),
      Money.zero,
    );
  });

  group('R-LEDGER-5 about K x a day', () {
    test('floors balance over days left', () {
      expect(
        BalanceCalculator.perDay(const Money.kwacha(3100), daysLeft: 26),
        const Money(11923),
      );
    });

    test('counts at least one day', () {
      expect(
        BalanceCalculator.perDay(const Money.kwacha(300), daysLeft: 0),
        const Money.kwacha(300),
      );
    });

    test('is shown only when the balance is above K 0', () {
      expect(BalanceCalculator.perDay(Money.zero, daysLeft: 5), isNull);
      expect(BalanceCalculator.perDay(const Money(-1), daysLeft: 5), isNull);
    });
  });
}
