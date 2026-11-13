import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Result<BillOccurrence> occ({
  BillStatus status = BillStatus.due,
  Money? paid,
  DateTime? paidAt,
  LocalDate? due,
  Money expected = const Money.kwacha(2500),
}) => BillOccurrence.create(
  id: 'o1',
  billId: 'rent',
  cycleStart: LocalDate(2026, 10, 25),
  dueDate: due ?? LocalDate(2026, 11, 1),
  expectedAmount: expected,
  status: status,
  paidAmount: paid,
  paidAt: paidAt,
);

void main() {
  group('BillOccurrence (R-BILL-6)', () {
    test('a fresh occurrence is due and unpaid', () {
      final o = ok(occ());
      expect(o.status, BillStatus.due);
      expect(o.paidAmount, isNull);
    });

    test('a paid occurrence needs the amount and the time', () {
      expect(occ(status: BillStatus.paid), isErr('paidAmount.required'));
      expect(
        occ(status: BillStatus.paid, paid: const Money.kwacha(2500)),
        isErr('paidAt.required'),
      );
      expect(
        ok(
          occ(
            status: BillStatus.paid,
            paid: const Money.kwacha(2400),
            paidAt: utc,
          ),
        ).paidAmount,
        const Money.kwacha(2400),
      );
    });

    test('only a paid occurrence has paid fields', () {
      expect(
        occ(paid: const Money.kwacha(1), paidAt: utc),
        isErr('paid.notPaid'),
      );
      expect(
        occ(status: BillStatus.skipped, paidAt: utc),
        isErr('paid.notPaid'),
      );
    });

    test('rejects a zero expected amount and a due date before the cycle', () {
      expect(occ(expected: Money.zero), isErr('expectedAmount.notPositive'));
      expect(occ(due: LocalDate(2026, 10, 1)), isErr('dueDate.beforeCycle'));
    });

    test('paidAt must be UTC (R-TIME-1)', () {
      expect(
        occ(
          status: BillStatus.paid,
          paid: const Money.kwacha(1),
          paidAt: DateTime(2026, 11),
        ),
        isErr('paidAt.notUtc'),
      );
    });
  });

  group('FeeBand / FeeTariff (R-FEE-3)', () {
    Result<FeeBand> band(int min, int max, int fee) => FeeBand.create(
      minAmount: Money.kwacha(min),
      maxAmount: Money.kwacha(max),
      fee: Money.kwacha(fee),
      source: FeeBandSource.user,
    );

    test('contains is inclusive at both ends', () {
      final b = ok(band(1, 100, 1));
      expect(b.contains(const Money.kwacha(1)), isTrue);
      expect(b.contains(const Money.kwacha(100)), isTrue);
      expect(b.contains(const Money.kwacha(101)), isFalse);
    });

    test('rejects a reversed range and a negative fee', () {
      expect(band(100, 1, 1), isErr('feeBand.range'));
      expect(
        FeeBand.create(
          minAmount: Money.zero,
          maxAmount: const Money.kwacha(10),
          fee: const Money(-1),
          source: FeeBandSource.learned,
        ),
        isErr('fee.negative'),
      );
    });

    test('a K 0 fee means no fee and is allowed', () {
      expect(ok(band(1, 10, 0)).fee, Money.zero);
    });

    test('a tariff sorts its bands and refuses overlaps', () {
      final t = ok(
        FeeTariff.create(
          provider: AlertSource.mtnMomo,
          feeType: FeeType.send,
          bands: [ok(band(101, 500, 5)), ok(band(1, 100, 1))],
        ),
      );
      expect(t.bands.first.minAmount, const Money.kwacha(1));
      expect(
        FeeTariff.create(
          provider: AlertSource.mtnMomo,
          feeType: FeeType.send,
          bands: [ok(band(1, 100, 1)), ok(band(100, 500, 5))],
        ),
        isErr('feeTariff.overlap'),
      );
    });
  });

  test('the Bills bucket cannot be removed (R-BUCKET-7)', () {
    final b = ok(
      Bucket.create(
        id: 'bills',
        name: 'Bills',
        kind: BucketKind.bills,
        color: BucketColor.business,
        accountId: 'spend',
      ),
    );
    expect(b.isRemovable, isFalse);
  });
}
