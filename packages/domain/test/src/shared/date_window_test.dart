import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  final end = utc.add(const Duration(days: 30));

  test('R-TIME-3 start is inside, end is outside', () {
    final w = ok(DateWindow.create(utc, end));
    expect(w.contains(utc), isTrue);
    expect(w.contains(end.subtract(const Duration(microseconds: 1))), isTrue);
    expect(w.contains(end), isFalse);
    expect(w.contains(utc.subtract(const Duration(seconds: 1))), isFalse);
  });

  test('end must be after start, both UTC', () {
    expect(DateWindow.create(utc, utc), isErr('window.empty'));
    expect(DateWindow.create(DateTime(2026), end), isErr('start.notUtc'));
  });
}
