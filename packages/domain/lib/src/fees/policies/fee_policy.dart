import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/value_objects/fee_learning.dart';

/// Fee rules (DOMAIN R-FEE-2…5). The app ships no rates, so everything here
/// works from what the user or a message has supplied.
abstract final class FeePolicy {
  /// The band covering [amount], ends included, or null.
  static FeeBand? bandFor(FeeTariff? tariff, Money amount) =>
      tariff?.bands.where((b) => b.contains(amount)).firstOrNull;

  /// The estimated fee for [amount], or null when no band covers it (R-FEE-2,
  /// R-FEE-5). A covered amount with a K 0 band is a real "no fee".
  static Money? estimate(FeeTariff? tariff, Money amount) =>
      bandFor(tariff, amount)?.fee;

  /// The fee to record and where it came from (R-FEE-2): the message, else
  /// the estimate, else K 0 marked missing.
  static (Money, FeeSource) resolve({Money? fromMessage, Money? estimated}) =>
      switch ((fromMessage, estimated)) {
        (final Money m, _) => (m, FeeSource.message),
        (_, final Money e) => (e, FeeSource.estimated),
        _ => (Money.zero, FeeSource.missing),
      };

  /// Learns from a message that showed [fee] for [amount] (R-FEE-4):
  /// - no band covers [amount]: a one-amount `learned` band is added;
  /// - the band agrees: its observation count goes up;
  /// - the band disagrees: nothing changes, the user is asked.
  static FeeLearning learn(FeeTariff tariff, Money amount, Money fee) {
    final band = bandFor(tariff, amount);
    final next = band == null
        ? _band(amount, amount, fee, FeeBandSource.learned, 1)
        : band.fee == fee
        ? _band(
            band.minAmount,
            band.maxAmount,
            fee,
            band.source,
            band.observations + 1,
          )
        : null;
    if (next == null) {
      return FeeLearning(change: FeeChange(band!, fee));
    }
    return FeeLearning(tariff: _replace(tariff, band, next));
  }

  /// The tariff with the user's accepted [change] applied; the band keeps its
  /// source and starts counting afresh.
  static FeeTariff accept(FeeTariff tariff, FeeChange change) => _replace(
    tariff,
    change.band,
    _band(
      change.band.minAmount,
      change.band.maxAmount,
      change.newFee,
      change.band.source,
      1,
    ),
  );

  static FeeBand _band(
    Money min,
    Money max,
    Money fee,
    FeeBandSource source,
    int n,
  ) => switch (FeeBand.create(
    minAmount: min,
    maxAmount: max,
    fee: fee,
    source: source,
    observations: n,
  )) {
    Ok(:final value) => value,
    Err(:final failure) => throw StateError('Fee band: $failure'),
  };

  static FeeTariff _replace(FeeTariff t, FeeBand? old, FeeBand next) =>
      switch (FeeTariff.create(
        provider: t.provider,
        feeType: t.feeType,
        bands: [
          for (final b in t.bands)
            if (b != old) b,
          next,
        ],
      )) {
        Ok(:final value) => value,
        Err(:final failure) => throw StateError('Fee tariff: $failure'),
      };
}
