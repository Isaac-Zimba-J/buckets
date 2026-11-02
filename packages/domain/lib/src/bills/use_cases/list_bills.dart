import 'package:buckets_domain/src/bills/entities/bill.dart';
import 'package:buckets_domain/src/bills/ports/bill_repository.dart';

/// Every bill, live (screen 03).
final class ListBills {
  /// Creates the use case.
  const ListBills(this._bills);

  final BillRepository _bills;

  /// The bills, emitting again on change.
  Stream<List<Bill>> call() => _bills.watchAll();
}
