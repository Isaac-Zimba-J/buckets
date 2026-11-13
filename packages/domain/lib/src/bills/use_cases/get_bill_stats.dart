import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/policies/bill_occurrences.dart';
import 'package:buckets_domain/src/bills/ports/bill_occurrence_repository.dart';
import 'package:buckets_domain/src/bills/value_objects/bill_stats.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';

/// Average paid and on-time record for one bill (SCREENS 35, R-BILL-10).
final class GetBillStats {
  /// Creates the use case.
  const new(this._occurrences, this._clock, this._zone);

  final BillOccurrenceRepository _occurrences;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// The stats for [billId].
  Future<Result<BillStats>> call(String billId) => attempt(
    () async => BillOccurrences.stats(
      unwrap(await _occurrences.getForBill(billId)),
      utcOffset: _zone.offsetAt(_clock.now()),
    ),
  );
}
