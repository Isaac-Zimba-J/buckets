import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';

/// A payday, live (screen 13).
final class WatchPayday {
  /// Creates the use case.
  const WatchPayday(this._paydays);

  final PaydayRepository _paydays;

  /// The payday with [paydayId], emitting on every change.
  Stream<Payday> call(String paydayId) => _paydays.watch(paydayId);
}
