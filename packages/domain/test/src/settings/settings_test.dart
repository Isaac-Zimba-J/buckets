import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  test('defaults match DOMAIN §16 and the rules', () {
    final s = Settings.defaults;
    expect(s.timeZone, 'Africa/Lusaka');
    expect(s.quietHours, QuietHours(LocalTime(21, 0), LocalTime(7, 0)));
    expect(s.snoozeLimit, 1);
    expect(s.coolingOffThreshold, const Money.kwacha(500));
    expect(s.coolingOffHours, 48);
    expect(s.checkInDay, DateTime.sunday);
    expect(s.checkInTime, LocalTime(18, 0));
    expect(s.appLock, isFalse);
    expect(s.autoFile, isFalse);
    expect(ok(Settings.create()), s);
  });

  test('validates each setting', () {
    expect(Settings.create(snoozeLimit: 4), isErr('snoozeLimit.outOfRange'));
    expect(Settings.create(snoozeLimit: -1), isErr('snoozeLimit.outOfRange'));
    expect(
      Settings.create(coolingOffHours: 36),
      isErr('coolingOffHours.notAllowed'),
    );
    expect(ok(Settings.create(coolingOffHours: 72)).coolingOffHours, 72);
    expect(
      Settings.create(coolingOffThreshold: Money.zero),
      isErr('coolingOffThreshold.notPositive'),
    );
    expect(Settings.create(checkInDay: 8), isErr('checkInDay.outOfRange'));
    expect(Settings.create(timeZone: ' '), isErr('timeZone.blank'));
  });

  test('LocalTime rejects impossible times', () {
    expect(LocalTime(7, 30).minutesOfDay, 450);
    expect(() => LocalTime(24, 0), throwsRangeError);
    expect(() => LocalTime(0, 60), throwsRangeError);
  });
}
