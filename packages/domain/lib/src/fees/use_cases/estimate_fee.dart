import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/policies/fee_policy.dart';
import 'package:buckets_domain/src/fees/ports/fee_tariff_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// The estimated fee for an amount (SCREENS 34), or null when no rate covers
/// it ("Add fee").
final class EstimateFee {
  /// Creates the use case.
  const new(this._tariffs);

  final FeeTariffRepository _tariffs;

  /// The fee for [amount], or null when unknown.
  Future<Result<Money?>> call({
    required AlertSource provider,
    required FeeType feeType,
    required Money amount,
  }) => attempt(
    () async => FeePolicy.estimate(
      unwrap(await _tariffs.find(provider, feeType)),
      amount,
    ),
  );
}
