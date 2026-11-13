import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/value_objects/fee_learning.dart';

/// Learned fee changes waiting for the user to accept or decline (R-FEE-4).
/// One per band: a newer message for the same band replaces the older one.
abstract interface class PendingFeeChanges {
  /// Adds [change], replacing one for the same band.
  Future<Result<void>> add(PendingFeeChange change);

  /// Drops the change for the band that starts at [min], if any.
  Future<Result<void>> remove({
    required AlertSource provider,
    required FeeType feeType,
    required Money min,
  });

  /// Every pending change, live.
  Stream<List<PendingFeeChange>> watchAll();
}
