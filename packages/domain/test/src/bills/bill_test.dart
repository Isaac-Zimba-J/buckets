import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Result<Bill> bill(
  BillFrequency frequency, {
  int? dueDay,
  DateTime? nextDueDate,
  Money amount = const Money.kwacha(2400),
}) => Bill.create(
  id: 'b',
  name: 'School fees',
  amount: amount,
  frequency: frequency,
  dueDay: dueDay,
  nextDueDate: nextDueDate,
  paidFromBucketId: 'living',
);

void main() {
  test('frequencies are counted in months', () {
    expect(BillFrequency.monthly.months, 1);
    expect(BillFrequency.termly.months, 4);
    expect(BillFrequency.yearly.months, 12);
    expect(const BillFrequency.everyNMonths(6).months, 6);
    expect(BillFrequency.monthly.isMonthly, isTrue);
    expect(BillFrequency.termly.isMonthly, isFalse);
  });

  test('a monthly bill needs a due day of the month', () {
    expect(ok(bill(BillFrequency.monthly, dueDay: 1)).dueDay, 1);
    expect(bill(BillFrequency.monthly), isErr('dueDay.outOfRange'));
    expect(bill(BillFrequency.monthly, dueDay: 32), isErr('dueDay.outOfRange'));
  });

  test('other frequencies need a UTC next due date', () {
    expect(ok(bill(BillFrequency.termly, nextDueDate: utc)).nextDueDate, utc);
    expect(bill(BillFrequency.termly), isErr('nextDueDate.missing'));
    expect(
      bill(BillFrequency.yearly, nextDueDate: DateTime(2027)),
      isErr('nextDueDate.notUtc'),
    );
    expect(
      bill(const BillFrequency.everyNMonths(0), nextDueDate: utc),
      isErr('frequency.outOfRange'),
    );
  });

  test('amount must be positive and the name filled in', () {
    expect(
      bill(BillFrequency.monthly, dueDay: 1, amount: Money.zero),
      isErr('amount.notPositive'),
    );
    expect(
      Bill.create(
        id: 'b',
        name: '',
        amount: const Money.kwacha(1),
        frequency: BillFrequency.monthly,
        dueDay: 1,
        paidFromBucketId: 'living',
      ),
      isErr('name.blank'),
    );
  });
}
