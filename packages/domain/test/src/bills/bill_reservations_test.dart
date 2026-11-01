import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Bill bill(BillFrequency frequency, Money amount) => ok(
  Bill.create(
    id: 'b',
    name: 'Bill',
    amount: amount,
    frequency: frequency,
    dueDay: frequency.isMonthly ? 1 : null,
    nextDueDate: frequency.isMonthly ? null : utc,
    paidFromBucketId: 'living',
  ),
);

void main() {
  group('R-BILL-1 monthly reservation', () {
    test('a monthly bill reserves its amount', () {
      expect(
        BillReservations.monthly(
          bill(BillFrequency.monthly, const Money.kwacha(2500)),
        ),
        const Money.kwacha(2500),
      );
    });

    test('school fees K 2,400 due in 3 cycles, nothing put aside → K 800', () {
      expect(
        BillReservations.monthly(
          bill(BillFrequency.termly, const Money.kwacha(2400)),
          cyclesUntilDue: 3,
        ),
        const Money.kwacha(800),
      );
    });

    test('subtracts what is put aside and rounds up to the ngwee', () {
      expect(
        BillReservations.monthly(
          bill(BillFrequency.yearly, const Money.kwacha(2400)),
          putAside: const Money.kwacha(1600),
          cyclesUntilDue: 3,
        ),
        const Money(26667),
      );
    });

    test('counts at least 1 cycle', () {
      for (final cycles in [0, -2]) {
        expect(
          BillReservations.monthly(
            bill(BillFrequency.termly, const Money.kwacha(2400)),
            cyclesUntilDue: cycles,
          ),
          const Money.kwacha(2400),
        );
      }
    });

    test('reserves nothing once the bill is fully put aside', () {
      expect(
        BillReservations.monthly(
          bill(BillFrequency.termly, const Money.kwacha(2400)),
          putAside: const Money.kwacha(2500),
          cyclesUntilDue: 2,
        ),
        Money.zero,
      );
    });
  });

  test('R-BILL-3 total = sum of reservations: K 4,300', () {
    expect(
      BillReservations.total(const [
        Money.kwacha(2500),
        Money.kwacha(400),
        Money.kwacha(600),
        Money.kwacha(800),
      ]),
      const Money.kwacha(4300),
    );
    expect(BillReservations.total(const []), Money.zero);
  });
}
