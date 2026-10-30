import 'package:buckets_core/buckets_core.dart';
import 'package:test/test.dart';

const nbsp = ' ';
const minus = '−';

void main() {
  group('MoneyFormatter.format', () {
    test('whole kwacha with comma thousands and a non-breaking space', () {
      expect(MoneyFormatter.format(const Money.kwacha(1540)), 'K${nbsp}1,540');
      expect(
        MoneyFormatter.format(const Money.kwacha(1234567)),
        'K${nbsp}1,234,567',
      );
      expect(MoneyFormatter.format(const Money.kwacha(999)), 'K${nbsp}999');
      expect(MoneyFormatter.format(Money.zero), 'K${nbsp}0');
    });

    test('whole kwacha rounds half up', () {
      expect(MoneyFormatter.format(const Money(41250)), 'K${nbsp}413');
      expect(MoneyFormatter.format(const Money(41249)), 'K${nbsp}412');
      expect(MoneyFormatter.format(const Money(-41250)), '${minus}K${nbsp}413');
    });

    test('shows ngwee on request', () {
      expect(
        MoneyFormatter.format(const Money(41250), showNgwee: true),
        'K${nbsp}412.50',
      );
      expect(
        MoneyFormatter.format(const Money.kwacha(1540), showNgwee: true),
        'K${nbsp}1,540.00',
      );
      expect(
        MoneyFormatter.format(const Money(5), showNgwee: true),
        'K${nbsp}0.05',
      );
    });

    test('negative amounts use a true minus', () {
      expect(
        MoneyFormatter.format(const Money.kwacha(-320)),
        '${minus}K${nbsp}320',
      );
    });

    test('signed adds a plus to money in only', () {
      expect(
        MoneyFormatter.format(const Money.kwacha(2000), signed: true),
        '+K${nbsp}2,000',
      );
      expect(MoneyFormatter.format(Money.zero, signed: true), 'K${nbsp}0');
      expect(
        MoneyFormatter.format(const Money.kwacha(-5), signed: true),
        '${minus}K${nbsp}5',
      );
    });

    test('drops the sign when the shown amount rounds to zero', () {
      expect(MoneyFormatter.format(const Money(-40)), 'K${nbsp}0');
      expect(MoneyFormatter.format(const Money(40), signed: true), 'K${nbsp}0');
    });
  });
}
