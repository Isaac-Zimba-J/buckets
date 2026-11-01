import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

const lusaka = Duration(hours: 2);

void main() {
  test('R-TIME-1 the local date comes from UTC plus the offset', () {
    // 30 Oct 21:59 UTC is 23:59 in Lusaka; 22:00 UTC is already 31 Oct.
    expect(
      LocalDate.ofInstant(DateTime.utc(2026, 10, 30, 21, 59), lusaka),
      LocalDate(2026, 10, 30),
    );
    expect(
      LocalDate.ofInstant(DateTime.utc(2026, 10, 30, 22), lusaka),
      LocalDate(2026, 10, 31),
    );
  });

  test('local midnight converts back to UTC', () {
    expect(
      LocalDate(2026, 11, 25).startUtc(lusaka),
      DateTime.utc(2026, 11, 24, 22),
    );
  });

  test('day arithmetic crosses months and years', () {
    expect(LocalDate(2026, 10, 30).daysUntil(LocalDate(2026, 11, 25)), 26);
    expect(LocalDate(2026, 12, 31).addDays(1), LocalDate(2027, 1, 1));
    expect(LocalDate.daysInMonth(2028, 2), 29);
    expect(LocalDate.daysInMonth(2026, 2), 28);
    expect(LocalDate(2026, 1, 2).compareTo(LocalDate(2026, 1, 1)), 1);
  });

  test('rejects impossible dates', () {
    expect(() => LocalDate(2026, 2, 29), throwsRangeError);
    expect(() => LocalDate(2026, 13, 1), throwsRangeError);
  });
}
