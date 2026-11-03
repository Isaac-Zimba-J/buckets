import 'package:buckets_data/src/system/system_clock.dart';
import 'package:buckets_data/src/system/uuid_generator.dart';
import 'package:buckets_data/src/system/zone_time_zone.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SystemClock returns UTC', () {
    final before = DateTime.now().toUtc();
    final now = const SystemClock().now();
    expect(now.isUtc, isTrue);
    expect(now.isBefore(before), isFalse);
  });

  test('UuidGenerator gives unique v4 IDs', () {
    final ids = {for (var i = 0; i < 1000; i++) const UuidGenerator().newId()};
    expect(ids, hasLength(1000));
    expect(
      ids.first,
      matches(
        RegExp(
          '^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}'
          r'-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        ),
      ),
    );
  });

  group('ZoneTimeZone', () {
    test('Africa/Lusaka is UTC+2 all year (R-TIME-1)', () {
      final zone = ZoneTimeZone.named('Africa/Lusaka');
      expect(
        zone.offsetAt(DateTime.utc(2026, 1, 15)),
        const Duration(hours: 2),
      );
      expect(
        zone.offsetAt(DateTime.utc(2026, 7, 15)),
        const Duration(hours: 2),
      );
    });

    test('zones with daylight saving change offset', () {
      final london = ZoneTimeZone.named('Europe/London');
      expect(london.offsetAt(DateTime.utc(2026, 1, 15)), Duration.zero);
      expect(
        london.offsetAt(DateTime.utc(2026, 7, 15)),
        const Duration(hours: 1),
      );
    });

    test('an unknown name falls back to Africa/Lusaka', () {
      expect(ZoneTimeZone.named('Mars/Olympus').name, 'Africa/Lusaka');
    });
  });
}
