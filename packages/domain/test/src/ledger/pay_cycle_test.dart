import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

const lusaka = Duration(hours: 2);

void main() {
  group('next payday', () {
    test('monthly: the next payday day after a date', () {
      expect(
        PayCycle.nextPaydayAfter(
          const MonthlyPay(25),
          LocalDate(2026, 10, 30),
          utcOffset: lusaka,
        ),
        LocalDate(2026, 11, 25),
      );
      expect(
        PayCycle.nextPaydayAfter(
          const MonthlyPay(25),
          LocalDate(2026, 10, 24),
          utcOffset: lusaka,
        ),
        LocalDate(2026, 10, 25),
      );
      // Strictly after: on payday itself, the next one is a month later.
      expect(
        PayCycle.nextPaydayAfter(
          const MonthlyPay(25),
          LocalDate(2026, 10, 25),
          utcOffset: lusaka,
        ),
        LocalDate(2026, 11, 25),
      );
      expect(
        PayCycle.nextPaydayAfter(
          const MonthlyPay(25),
          LocalDate(2026, 12, 26),
          utcOffset: lusaka,
        ),
        LocalDate(2027, 1, 25),
      );
    });

    test('monthly: a missing day is the last day of the month (owner)', () {
      expect(
        PayCycle.nextPaydayAfter(
          const MonthlyPay(31),
          LocalDate(2026, 10, 31),
          utcOffset: lusaka,
        ),
        LocalDate(2026, 11, 30),
      );
      expect(
        PayCycle.nextPaydayAfter(
          const MonthlyPay(30),
          LocalDate(2027, 1, 30),
          utcOffset: lusaka,
        ),
        LocalDate(2027, 2, 28),
      );
      expect(
        PayCycle.nextPaydayAfter(
          const MonthlyPay(31),
          LocalDate(2028, 2, 1),
          utcOffset: lusaka,
        ),
        LocalDate(2028, 2, 29),
      );
    });

    test('fortnightly: every 14 days from the anchor', () {
      final schedule = FortnightlyPay(DateTime.utc(2026, 10, 1, 10));
      expect(
        PayCycle.nextPaydayAfter(
          schedule,
          LocalDate(2026, 10, 1),
          utcOffset: lusaka,
        ),
        LocalDate(2026, 10, 15),
      );
      expect(
        PayCycle.nextPaydayAfter(
          schedule,
          LocalDate(2026, 10, 20),
          utcOffset: lusaka,
        ),
        LocalDate(2026, 10, 29),
      );
      expect(
        PayCycle.nextPaydayAfter(
          schedule,
          LocalDate(2026, 9, 1),
          utcOffset: lusaka,
        ),
        LocalDate(2026, 9, 3),
      );
    });

    test('fortnightly: the anchor date is read in local time', () {
      // Local midnight 1 Oct in Lusaka is 22:00 UTC on 30 Sep.
      final schedule = FortnightlyPay(DateTime.utc(2026, 9, 30, 22));
      expect(
        PayCycle.nextPaydayAfter(
          schedule,
          LocalDate(2026, 10, 1),
          utcOffset: lusaka,
        ),
        LocalDate(2026, 10, 15),
      );
    });

    test('irregular: no next payday', () {
      expect(
        PayCycle.nextPaydayAfter(
          const IrregularPay(),
          LocalDate(2026, 1, 1),
          utcOffset: lusaka,
        ),
        isNull,
      );
    });
  });

  group('R-TIME-3 current cycle', () {
    final started = DateTime.utc(2026, 10, 25, 6); // 08:00 in Lusaka

    test('runs from the last salary payday to local midnight of the next', () {
      final cycle = PayCycle.current(
        lastSalaryStartedAt: started,
        setupAt: DateTime.utc(2026, 9),
        salary: const MonthlyPay(25),
        now: DateTime.utc(2026, 10, 30, 7),
        utcOffset: lusaka,
      )!;
      expect(cycle.start, started);
      expect(cycle.end, DateTime.utc(2026, 11, 24, 22));
      expect(cycle.contains(started), isTrue);
      expect(cycle.contains(DateTime.utc(2026, 11, 24, 21, 59)), isTrue);
      expect(cycle.contains(DateTime.utc(2026, 11, 24, 22)), isFalse);
    });

    test('before the first payday it runs from setup', () {
      final setup = DateTime.utc(2026, 10, 10, 12);
      final cycle = PayCycle.current(
        lastSalaryStartedAt: null,
        setupAt: setup,
        salary: const MonthlyPay(25),
        now: DateTime.utc(2026, 10, 12),
        utcOffset: lusaka,
      )!;
      expect(cycle.start, setup);
      expect(cycle.end, DateTime.utc(2026, 10, 24, 22));
    });

    test('a late salary keeps the cycle open to the end of today', () {
      final cycle = PayCycle.current(
        lastSalaryStartedAt: started,
        setupAt: DateTime.utc(2026, 9),
        salary: const MonthlyPay(25),
        now: DateTime.utc(2026, 11, 26, 9),
        utcOffset: lusaka,
      )!;
      expect(cycle.end, DateTime.utc(2026, 11, 26, 22));
      expect(cycle.contains(DateTime.utc(2026, 11, 26, 9)), isTrue);
    });

    test('irregular salary has no cycle end', () {
      expect(
        PayCycle.current(
          lastSalaryStartedAt: started,
          setupAt: DateTime.utc(2026, 9),
          salary: const IrregularPay(),
          now: DateTime.utc(2026, 10, 30),
          utcOffset: lusaka,
        ),
        isNull,
      );
    });
  });

  test('days left counts calendar days from today, minimum 1', () {
    final cycle = PayCycle.current(
      lastSalaryStartedAt: DateTime.utc(2026, 10, 25, 6),
      setupAt: DateTime.utc(2026, 9),
      salary: const MonthlyPay(25),
      now: DateTime.utc(2026, 10, 30, 7),
      utcOffset: lusaka,
    )!;
    int left(DateTime now) =>
        PayCycle.daysLeft(cycle, now: now, utcOffset: lusaka);
    expect(left(DateTime.utc(2026, 10, 30, 7)), 26);
    expect(left(DateTime.utc(2026, 11, 24, 21)), 1);
    expect(left(DateTime.utc(2026, 11, 30)), 1);
  });

  test('R-BILL-1 cycles before a due date count the current payday', () {
    int count(LocalDate from, LocalDate until, [PaySchedule? s]) =>
        PayCycle.paydaysBetween(
          s ?? const MonthlyPay(25),
          from,
          until,
          utcOffset: lusaka,
        );
    // 25 Oct, 25 Nov, 25 Dec before 10 Jan.
    expect(count(LocalDate(2026, 10, 25), LocalDate(2027, 1, 10)), 3);
    expect(count(LocalDate(2026, 10, 26), LocalDate(2027, 1, 10)), 2);
    expect(count(LocalDate(2026, 10, 26), LocalDate(2026, 11, 25)), 0);
    expect(
      count(
        LocalDate(2026, 10, 1),
        LocalDate(2027, 1, 1),
        const IrregularPay(),
      ),
      0,
    );
  });
}
