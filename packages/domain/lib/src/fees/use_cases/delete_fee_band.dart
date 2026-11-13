import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/ports/fee_tariff_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Removes a fee band (SCREENS 37).
final class DeleteFeeBand {
  /// Creates the use case.
  const new(this._tariffs);

  final FeeTariffRepository _tariffs;

  /// Removes the band starting at [min]; nothing happens if there is none.
  Future<Result<void>> call({
    required AlertSource provider,
    required FeeType feeType,
    required Money min,
  }) => attempt(() async {
    final current = unwrap(await _tariffs.find(provider, feeType));
    if (current == null) return;
    unwrap(
      await _tariffs.save(
        unwrap(
          FeeTariff.create(
            provider: provider,
            feeType: feeType,
            bands: [
              for (final b in current.bands)
                if (b.minAmount != min) b,
            ],
          ),
        ),
      ),
    );
  });
}
