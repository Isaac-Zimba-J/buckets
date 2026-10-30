import 'package:buckets_core/buckets_core.dart';
import 'package:test/test.dart';

void main() {
  group('Money', () {
    test('kwacha constructor converts to ngwee', () {
      expect(const Money.kwacha(1540).ngwee, 154000);
      expect(Money.zero.ngwee, 0);
    });

    test('adds, subtracts and negates', () {
      const a = Money(41250);
      const b = Money(100);
      expect(a + b, const Money(41350));
      expect(b - a, const Money(-41150));
      expect(-a, const Money(-41250));
      expect(const Money(-5).abs(), const Money(5));
    });

    test('compares', () {
      const small = Money(1);
      const big = Money(2);
      expect(small < big, isTrue);
      expect(small <= small, isTrue);
      expect(big > small, isTrue);
      expect(big >= big, isTrue);
      expect(small.compareTo(big), -1);
      expect([big, small]..sort(), [small, big]);
    });

    test('sign helpers', () {
      expect(Money.zero.isZero, isTrue);
      expect(const Money(-1).isNegative, isTrue);
      expect(const Money(1).isPositive, isTrue);
      expect(Money.zero.isPositive, isFalse);
    });

    test('value equality', () {
      expect(const Money(7), const Money(7));
      expect(const Money(7).hashCode, const Money(7).hashCode);
      expect(const Money(7) == const Money(8), isFalse);
      expect(const Money(7).toString(), 'Money(7 ngwee)');
    });
  });
}
