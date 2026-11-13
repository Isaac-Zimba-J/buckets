import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/policies/fee_policy.dart';
import 'package:buckets_domain/src/fees/ports/fee_tariff_repository.dart';
import 'package:buckets_domain/src/fees/ports/pending_fee_changes.dart';
import 'package:buckets_domain/src/fees/value_objects/fee_learning.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Applies or declines a learned fee change (SCREENS 37, R-FEE-4).
final class ResolveFeeChange {
  /// Creates the use case.
  const new(this._tariffs, [this._pending]);

  final FeeTariffRepository _tariffs;
  final PendingFeeChanges? _pending;

  /// Declining changes nothing; accepting updates the band's fee.
  Future<Result<void>> call({
    required AlertSource provider,
    required FeeType feeType,
    required FeeChange change,
    required bool accept,
  }) => attempt(() async {
    // Accepted or declined, the question has been answered.
    await _pending?.remove(
      provider: provider,
      feeType: feeType,
      min: change.band.minAmount,
    );
    if (!accept) return;
    final tariff = unwrap(await _tariffs.find(provider, feeType));
    if (tariff == null) {
      unwrap<void>(
        const Err(NotFoundFailure('fee.notFound', 'Those fee rates are gone.')),
      );
    }
    unwrap(await _tariffs.save(FeePolicy.accept(tariff!, change)));
  });
}
