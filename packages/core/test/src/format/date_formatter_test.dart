import 'package:buckets_core/buckets_core.dart';
import 'package:test/test.dart';

void main() {
  final today = DateTime(2026, 10, 30, 9);

  test('date omits the year only when it is this year', () {
    expect(DateFormatter.date(DateTime(2026, 11, 25), today: today), '25 Nov');
    expect(
      DateFormatter.date(DateTime(2027, 8, 3), today: today),
      '3 Aug 2027',
    );
  });

  test('month omits the year only when it is this year', () {
    expect(DateFormatter.month(DateTime(2026, 1, 9), today: today), 'Jan');
    expect(DateFormatter.month(DateTime(2027, 8), today: today), 'Aug 2027');
  });

  test('time is 24-hour', () {
    expect(DateFormatter.time(DateTime(2026, 1, 1, 14, 32)), '14:32');
    expect(DateFormatter.time(DateTime(2026, 1, 1, 7, 5)), '07:05');
  });

  group('relativeDay', () {
    String rel(DateTime d) => DateFormatter.relativeDay(d, today: today);

    test('today and yesterday by calendar day (R-TIME-2)', () {
      expect(rel(DateTime(2026, 10, 30, 23, 59)), 'Today');
      expect(rel(DateTime(2026, 10, 29)), 'Yesterday');
      expect(rel(DateTime(2026, 10, 31)), 'Tomorrow');
    });

    test('future days count up, across month ends', () {
      expect(rel(DateTime(2026, 11, 11)), 'in 12 days');
    });

    test('older days fall back to the date', () {
      expect(rel(DateTime(2026, 10, 28)), '28 Oct');
      expect(rel(DateTime(2025, 12, 31)), '31 Dec 2025');
    });
  });
}
