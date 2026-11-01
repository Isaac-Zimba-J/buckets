import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Result<IncomeSource> income({
  IncomeKind kind = IncomeKind.salary,
  Money? expected = const Money.kwacha(12000),
  PaySchedule schedule = const MonthlyPay(25),
  bool? deductBillsFirst,
}) => IncomeSource.create(
  id: 'i',
  name: 'Salary',
  kind: kind,
  expectedAmount: expected,
  schedule: schedule,
  landsInAccountId: 'a',
  splitProfileId: 'p',
  deductBillsFirst: deductBillsFirst,
);

void main() {
  test('salary deducts bills first by default, side hustles do not', () {
    expect(ok(income()).deductBillsFirst, isTrue);
    expect(ok(income(kind: IncomeKind.sideHustle)).deductBillsFirst, isFalse);
    expect(ok(income(deductBillsFirst: false)).deductBillsFirst, isFalse);
  });

  test('expected amount is optional but positive when given', () {
    expect(
      ok(income(expected: null, schedule: const IrregularPay())).expectedAmount,
      isNull,
    );
    expect(income(expected: Money.zero), isErr('expectedAmount.notPositive'));
  });

  test('monthly payday is a day of the month', () {
    expect(income(schedule: const MonthlyPay(0)), isErr('payday.outOfRange'));
    expect(income(schedule: const MonthlyPay(32)), isErr('payday.outOfRange'));
    expect(
      ok(income(schedule: const MonthlyPay(31))).schedule,
      const MonthlyPay(31),
    );
  });

  test('fortnightly anchor is UTC', () {
    expect(
      income(schedule: FortnightlyPay(DateTime(2026, 10, 30))),
      isErr('payday.notUtc'),
    );
    expect(
      ok(income(schedule: FortnightlyPay(utc))).schedule,
      FortnightlyPay(utc),
    );
  });

  test('rejects a blank name', () {
    expect(
      IncomeSource.create(
        id: 'i',
        name: ' ',
        kind: IncomeKind.other,
        schedule: const IrregularPay(),
        landsInAccountId: 'a',
        splitProfileId: 'p',
      ),
      isErr('name.blank'),
    );
  });
}
