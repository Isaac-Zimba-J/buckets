import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/entities/bill_occurrence.dart';
import 'package:buckets_domain/src/bills/ports/bill_occurrence_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';

/// What a bill's payments cost in fees this calendar year (SCREENS 35,
/// "Fees paid on this bill").
final class GetBillFees {
  /// Creates the use case.
  const new(this._occurrences, this._transactions, this._clock, this._zone);

  final BillOccurrenceRepository _occurrences;
  final TransactionRepository _transactions;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// The fees linked to [billId]'s occurrences paid this year; K 0 if none.
  Future<Result<Money>> call(String billId) => attempt(() async {
    final now = _clock.now();
    final year = now.toUtc().add(_zone.offsetAt(now)).year;
    var total = Money.zero;
    for (final o in unwrap(await _occurrences.getForBill(billId))) {
      final paidAt = o.paidAt;
      final feeId = o.feeTransactionId;
      if (o.status != BillStatus.paid || paidAt == null || feeId == null) {
        continue;
      }
      if (paidAt.toUtc().add(_zone.offsetAt(paidAt)).year != year) continue;
      total += unwrap(await _transactions.get(feeId)).amount;
    }
    return total;
  });
}
