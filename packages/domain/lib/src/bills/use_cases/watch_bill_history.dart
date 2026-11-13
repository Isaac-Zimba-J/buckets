import 'package:buckets_domain/src/bills/entities/bill_occurrence.dart';
import 'package:buckets_domain/src/bills/ports/bill_occurrence_repository.dart';

/// Every occurrence of one bill, newest first (SCREENS 35, R-BILL-10).
final class WatchBillHistory {
  /// Creates the use case.
  const new(this._occurrences);

  final BillOccurrenceRepository _occurrences;

  /// Emits the history of [billId] and again on change.
  Stream<List<BillOccurrence>> call(String billId) =>
      _occurrences.watchAll().map(
        (all) =>
            all.where((o) => o.billId == billId).toList()
              ..sort((a, b) => b.dueDate.compareTo(a.dueDate)),
      );
}
