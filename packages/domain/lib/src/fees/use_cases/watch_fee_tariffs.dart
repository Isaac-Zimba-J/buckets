import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/ports/fee_tariff_repository.dart';

/// Streams the fee rates for the Fee rates screen (SCREENS 37).
final class WatchFeeTariffs {
  /// Creates the use case.
  const new(this._tariffs);

  final FeeTariffRepository _tariffs;

  /// Emits the tariffs and again on change.
  Stream<List<FeeTariff>> call() => _tariffs.watchAll();
}
