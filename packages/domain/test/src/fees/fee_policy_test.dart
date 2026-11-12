import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

FeeBand band(
  int min,
  int max,
  int fee, {
  FeeBandSource src = FeeBandSource.user,
  int n = 0,
}) => ok(
  FeeBand.create(
    minAmount: Money.kwacha(min),
    maxAmount: Money.kwacha(max),
    fee: Money.kwacha(fee),
    source: src,
    observations: n,
  ),
);

FeeTariff tariff([List<FeeBand> bands = const []]) => ok(
  FeeTariff.create(
    provider: AlertSource.mtnMomo,
    feeType: FeeType.send,
    bands: bands,
  ),
);

void main() {
  final t = tariff([band(1, 100, 1), band(101, 500, 5)]);

  group('estimate (R-FEE-5)', () {
    test('band ends are inclusive', () {
      expect(
        FeePolicy.estimate(t, const Money.kwacha(1)),
        const Money.kwacha(1),
      );
      expect(
        FeePolicy.estimate(t, const Money.kwacha(100)),
        const Money.kwacha(1),
      );
      expect(
        FeePolicy.estimate(t, const Money.kwacha(101)),
        const Money.kwacha(5),
      );
      expect(
        FeePolicy.estimate(t, const Money.kwacha(500)),
        const Money.kwacha(5),
      );
    });

    test('an uncovered amount, or no tariff, is unknown, not K 0', () {
      expect(FeePolicy.estimate(t, const Money.kwacha(501)), isNull);
      expect(FeePolicy.estimate(null, const Money.kwacha(50)), isNull);
    });

    test('a K 0 band is a real "no fee"', () {
      expect(
        FeePolicy.estimate(tariff([band(1, 10, 0)]), const Money.kwacha(5)),
        Money.zero,
      );
    });
  });

  group('resolve (R-FEE-2)', () {
    test('message beats estimate beats missing', () {
      expect(
        FeePolicy.resolve(
          fromMessage: const Money.kwacha(2),
          estimated: const Money.kwacha(1),
        ),
        (const Money.kwacha(2), FeeSource.message),
      );
      expect(FeePolicy.resolve(estimated: const Money.kwacha(1)), (
        const Money.kwacha(1),
        FeeSource.estimated,
      ));
      expect(FeePolicy.resolve(), (Money.zero, FeeSource.missing));
    });

    test('a K 0 fee in the message is still from the message', () {
      expect(FeePolicy.resolve(fromMessage: Money.zero), (
        Money.zero,
        FeeSource.message,
      ));
    });
  });

  group('learn (R-FEE-4)', () {
    test('an empty gap is filled with a learned one-amount band', () {
      final out = FeePolicy.learn(
        t,
        const Money.kwacha(900),
        const Money.kwacha(9),
      );
      expect(out.change, isNull);
      final added = FeePolicy.bandFor(out.tariff, const Money.kwacha(900))!;
      expect(added.source, FeeBandSource.learned);
      expect(added.fee, const Money.kwacha(9));
      expect(added.observations, 1);
      expect(out.tariff!.bands, hasLength(3));
    });

    test('a matching message counts as another observation', () {
      final out = FeePolicy.learn(
        t,
        const Money.kwacha(50),
        const Money.kwacha(1),
      );
      expect(
        FeePolicy.bandFor(out.tariff, const Money.kwacha(50))!.observations,
        1,
      );
      expect(out.tariff!.bands, hasLength(2));
    });

    test('a different fee asks the user and changes nothing', () {
      final out = FeePolicy.learn(
        t,
        const Money.kwacha(50),
        const Money.kwacha(3),
      );
      expect(out.tariff, isNull);
      expect(out.change!.newFee, const Money.kwacha(3));
      expect(out.change!.band, band(1, 100, 1));
    });

    test('a user-entered band is never overwritten silently', () {
      final out = FeePolicy.learn(
        tariff([band(1, 100, 1)]),
        const Money.kwacha(10),
        const Money.kwacha(2),
      );
      expect(out.tariff, isNull);
      expect(out.change, isNotNull);
    });

    test('accepting the change updates the fee, keeping range and source', () {
      final out = FeePolicy.learn(
        t,
        const Money.kwacha(50),
        const Money.kwacha(3),
      );
      final updated = FeePolicy.accept(t, out.change!);
      final b = FeePolicy.bandFor(updated, const Money.kwacha(50))!;
      expect(b.fee, const Money.kwacha(3));
      expect(b.minAmount, const Money.kwacha(1));
      expect(b.maxAmount, const Money.kwacha(100));
      expect(b.source, FeeBandSource.user);
      expect(updated.bands, hasLength(2));
    });
  });
}
