import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/policies/fee_policy.dart';
import 'package:buckets_domain/src/fees/ports/fee_tariff_repository.dart';
import 'package:buckets_domain/src/fees/value_objects/fee_learning.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Learns a fee rate from a message that showed one (R-FEE-4).
final class LearnFee {
  /// Creates the use case.
  const new(this._tariffs);

  final FeeTariffRepository _tariffs;

  /// Saves what the message taught. Returns the disagreement to put to the
  /// user, or null when the rates were filled in or confirmed.
  Future<Result<FeeChange?>> call({
    required AlertSource provider,
    required FeeType feeType,
    required Money amount,
    required Money fee,
  }) => attempt(() async {
    final saved = unwrap(await _tariffs.find(provider, feeType));
    final tariff = switch (saved) {
      final FeeTariff t => t,
      _ => unwrap(FeeTariff.create(provider: provider, feeType: feeType)),
    };
    final learned = FeePolicy.learn(tariff, amount, fee);
    final updated = learned.tariff;
    if (updated != null) unwrap(await _tariffs.save(updated));
    return learned.change;
  });
}
