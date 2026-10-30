import 'package:buckets_core/buckets_core.dart';
import 'package:test/test.dart';

void main() {
  group('BasisPoints', () {
    test('accepts 0 to 10000', () {
      expect(BasisPoints(0).value, 0);
      expect(BasisPoints.full.value, 10000);
    });

    test('rejects values out of range', () {
      expect(() => BasisPoints(-1), throwsRangeError);
      expect(() => BasisPoints(10001), throwsRangeError);
    });

    test('applyTo floors to the ngwee (R-MONEY-3)', () {
      // 20% of K 12,000 − K 4,300 = K 7,700 → K 1,540
      expect(
        BasisPoints(2000).applyTo(const Money.kwacha(7700)),
        const Money.kwacha(1540),
      );
      // 33.33% of 100 ngwee = 33.33 → 33
      expect(BasisPoints(3333).applyTo(const Money(100)), const Money(33));
      expect(BasisPoints(1).applyTo(const Money(9999)), Money.zero);
    });

    test('applyTo floors negative amounts toward minus infinity', () {
      expect(BasisPoints(3333).applyTo(const Money(-100)), const Money(-34));
      expect(BasisPoints(5000).applyTo(const Money(-100)), const Money(-50));
    });

    test('compares and has value equality', () {
      expect(BasisPoints(10), BasisPoints(10));
      expect(BasisPoints(10).hashCode, BasisPoints(10).hashCode);
      expect(BasisPoints(10).compareTo(BasisPoints(20)), -1);
      expect(BasisPoints(1000).toString(), 'BasisPoints(1000)');
    });
  });
}
