import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/ports/fee_tariff_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Adds or edits a fee band by hand (SCREENS 37, R-FEE-3). The band is
/// marked `user`, so a message never overwrites it silently (R-FEE-4).
final class SaveFeeBand {
  /// Creates the use case.
  const new(this._tariffs);

  final FeeTariffRepository _tariffs;

  /// Saves the band starting at [min]; an existing band with the same start
  /// is replaced. Fails if it would overlap another band.
  Future<Result<FeeTariff>> call({
    required AlertSource provider,
    required FeeType feeType,
    required Money min,
    required Money max,
    required Money fee,
  }) => attempt(() async {
    final band = unwrap(
      FeeBand.create(
        minAmount: min,
        maxAmount: max,
        fee: fee,
        source: FeeBandSource.user,
      ),
    );
    final current = unwrap(await _tariffs.find(provider, feeType));
    final tariff = unwrap(
      FeeTariff.create(
        provider: provider,
        feeType: feeType,
        bands: [
          for (final b in current?.bands ?? const <FeeBand>[])
            if (b.minAmount != min) b,
          band,
        ],
      ),
    );
    unwrap(await _tariffs.save(tariff));
    return tariff;
  });
}
