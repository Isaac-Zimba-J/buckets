import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  Result<CheckIn> checkIn(Money counted, {DateTime? at}) => CheckIn.create(
    id: 'c',
    countedAt: at ?? utc,
    expectedCash: const Money.kwacha(400),
    countedCash: counted,
  );

  test('R-CASH-2 gap = expected − counted', () {
    expect(ok(checkIn(const Money.kwacha(250))).gap, const Money.kwacha(150));
    expect(ok(checkIn(const Money.kwacha(450))).gap, const Money.kwacha(-50));
  });

  test('counted cash cannot be negative; time is UTC', () {
    expect(checkIn(const Money(-1)), isErr('countedCash.negative'));
    expect(checkIn(Money.zero, at: DateTime(2026)), isErr('countedAt.notUtc'));
  });
}
