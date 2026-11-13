import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

const lusaka = Duration(hours: 2);
final start = LocalDate(2026, 10, 25);
final end = LocalDate(2026, 11, 25);

Bill monthly(int day, {String id = 'rent', String? payee}) => ok(
  Bill.create(
    id: id,
    name: id,
    amount: const Money.kwacha(2500),
    frequency: BillFrequency.monthly,
    paidFromBucketId: 'bills',
    dueDay: day,
    payeeAccountHint: payee,
  ),
);

Bill termly(DateTime next) => ok(
  Bill.create(
    id: 'fees',
    name: 'School fees',
    amount: const Money.kwacha(2400),
    frequency: BillFrequency.termly,
    paidFromBucketId: 'bills',
    nextDueDate: next,
  ),
);

BillOccurrence occ({
  required LocalDate due,
  String id = 'o',
  String bill = 'rent',
  BillStatus status = BillStatus.due,
  int? paidK,
  DateTime? paidAt,
  LocalDate? cycle,
}) => ok(
  BillOccurrence.create(
    id: id,
    billId: bill,
    cycleStart: cycle ?? start,
    dueDate: due,
    expectedAmount: const Money.kwacha(2500),
    status: status,
    paidAmount: paidK == null ? null : Money.kwacha(paidK),
    paidAt: paidAt,
  ),
);

void main() {
  group('dueIn (R-BILL-6)', () {
    LocalDate? due(Bill b) =>
        BillOccurrences.dueIn(b, start, end, utcOffset: lusaka);

    test('a monthly bill is due on its day, in either month of the cycle', () {
      expect(due(monthly(1)), LocalDate(2026, 11, 1));
      expect(due(monthly(28)), LocalDate(2026, 10, 28));
    });

    test('the cycle start is in, the cycle end is out', () {
      expect(due(monthly(25)), LocalDate(2026, 10, 25));
      expect(
        BillOccurrences.dueIn(
          monthly(25),
          LocalDate(2026, 10, 26),
          LocalDate(2026, 11, 25),
          utcOffset: lusaka,
        ),
        isNull,
      );
    });

    test('day 31 falls on the last day of a short month', () {
      expect(
        BillOccurrences.dueIn(
          monthly(31),
          LocalDate(2027, 2, 25),
          LocalDate(2027, 3, 25),
          utcOffset: lusaka,
        ),
        LocalDate(2027, 2, 28),
      );
    });

    test('a non-monthly bill is only due in the cycle holding its date', () {
      expect(due(termly(DateTime.utc(2026, 11, 10))), LocalDate(2026, 11, 10));
      expect(due(termly(DateTime.utc(2027, 1, 10))), isNull);
    });
  });

  group('advanceDue', () {
    test('a termly bill moves four months on, clamped to short months', () {
      expect(
        BillOccurrences.advanceDue(termly(DateTime.utc(2026, 11, 10))),
        DateTime.utc(2027, 3, 10),
      );
      expect(
        BillOccurrences.advanceDue(termly(DateTime.utc(2026, 10, 31))),
        DateTime.utc(2027, 2, 28),
      );
    });

    test('a monthly bill follows its due day, so nothing moves', () {
      expect(BillOccurrences.advanceDue(monthly(1)), isNull);
    });
  });

  group('forCycle', () {
    test('adds one unpaid occurrence per bill due, never twice', () {
      final bills = [monthly(1), termly(DateTime.utc(2027, 1, 10))];
      final first = BillOccurrences.forCycle(
        bills: bills,
        existing: const [],
        start: start,
        end: end,
        ids: SequentialIds(),
        utcOffset: lusaka,
      );
      expect(first.map((o) => o.billId), ['rent']);
      expect(first.single.status, BillStatus.due);
      expect(first.single.expectedAmount, const Money.kwacha(2500));
      expect(
        BillOccurrences.forCycle(
          bills: bills,
          existing: first,
          start: start,
          end: end,
          ids: SequentialIds(),
          utcOffset: lusaka,
        ),
        isEmpty,
      );
    });
  });

  group('overdue and late (R-BILL-8)', () {
    test('overdue only after the due date, only while due', () {
      final o = occ(due: LocalDate(2026, 11, 1));
      expect(BillOccurrences.isOverdue(o, LocalDate(2026, 11, 1)), isFalse);
      expect(BillOccurrences.isOverdue(o, LocalDate(2026, 11, 2)), isTrue);
      final paid = occ(
        due: LocalDate(2026, 11, 1),
        status: BillStatus.paid,
        paidK: 2500,
        paidAt: DateTime.utc(2026, 11, 5),
      );
      expect(BillOccurrences.isOverdue(paid, LocalDate(2026, 12, 1)), isFalse);
    });

    test('late uses the local day, not the UTC day', () {
      // 22:30 UTC on 1 Nov is 00:30 on 2 Nov in Lusaka: a day late.
      final o = occ(
        due: LocalDate(2026, 11, 1),
        status: BillStatus.paid,
        paidK: 2500,
        paidAt: DateTime.utc(2026, 11, 1, 22, 30),
      );
      expect(BillOccurrences.isLate(o, utcOffset: lusaka), isTrue);
    });
  });

  group('suggest (R-BILL-9)', () {
    final bills = [monthly(1, payee: 'ZESCO')];
    final open = [occ(due: LocalDate(2026, 11, 1))];
    BillOccurrence? ask(String who, int ngwee) => BillOccurrences.suggest(
      counterparty: who,
      amount: Money(ngwee),
      bills: bills,
      occurrences: open,
    );

    test('matches the payee and an amount within ±25%', () {
      expect(ask('Paid to zesco ltd', 250000), isNotNull);
      expect(ask('ZESCO', 312500), isNotNull); // exactly +25%
      expect(ask('ZESCO', 187500), isNotNull); // exactly −25%
    });

    test('rejects other payees and amounts beyond ±25%', () {
      expect(ask('Shoprite', 250000), isNull);
      expect(ask('ZESCO', 312501), isNull);
      expect(ask('ZESCO', 187499), isNull);
    });

    test('never suggests a bill without a payee hint or a paid one', () {
      expect(
        BillOccurrences.suggest(
          counterparty: 'ZESCO',
          amount: const Money.kwacha(2500),
          bills: [monthly(1)],
          occurrences: open,
        ),
        isNull,
      );
    });
  });

  group('stats (R-BILL-10)', () {
    BillOccurrence paid(int n, int k, {bool late = false}) => occ(
      id: 'p$n',
      due: LocalDate(2026, 1 + n, 1),
      cycle: LocalDate(2026, 1 + n, 1),
      status: BillStatus.paid,
      paidK: k,
      paidAt: DateTime.utc(2026, 1 + n, late ? 5 : 1),
    );

    test('no paid occurrences means no average', () {
      final s = BillOccurrences.stats([
        occ(due: LocalDate(2026, 11, 1)),
      ], utcOffset: lusaka);
      expect(s.averagePaid, isNull);
      expect(s.lastFiveCount, 0);
    });

    test('averages the last 6 and counts on-time of the last 5', () {
      final all = [
        paid(1, 1000), // oldest, outside both windows
        paid(2, 2000),
        paid(3, 2000),
        paid(4, 2000, late: true),
        paid(5, 2000),
        paid(6, 2000),
        paid(7, 2000, late: true),
      ];
      final s = BillOccurrences.stats(all, utcOffset: lusaka);
      expect(s.averagePaid, const Money.kwacha(2000)); // p2..p7
      expect(s.lastFiveCount, 5); // p3..p7
      expect(s.onTimeOfLastFive, 3);
    });
  });
}
