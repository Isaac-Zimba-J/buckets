import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';

/// Stores fee rates (R-FEE-3). It starts empty: the app ships none.
abstract interface class FeeTariffRepository {
  /// Every tariff.
  Future<Result<List<FeeTariff>>> getAll();

  /// The tariff for [provider] and [feeType], if any.
  Future<Result<FeeTariff?>> find(AlertSource provider, FeeType feeType);

  /// Inserts or replaces the tariff for its provider and fee type.
  Future<Result<void>> save(FeeTariff tariff);

  /// Every tariff, emitting again on change.
  Stream<List<FeeTariff>> watchAll();
}
