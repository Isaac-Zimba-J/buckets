import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/entities/bill_occurrence.dart';
import 'package:buckets_domain/src/shared/local_date.dart';

/// Stores bill occurrences, one per bill per pay cycle (R-BILL-6). History is
/// kept: nothing is deleted when a cycle ends (R-BILL-10).
abstract interface class BillOccurrenceRepository {
  /// Every occurrence, oldest cycle first.
  Future<Result<List<BillOccurrence>>> getAll();

  /// The occurrences of the cycle that starts on [cycleStart].
  Future<Result<List<BillOccurrence>>> getForCycle(LocalDate cycleStart);

  /// Every occurrence of [billId], oldest cycle first (SCREENS 35).
  Future<Result<List<BillOccurrence>>> getForBill(String billId);

  /// Inserts or replaces [occurrence]; one per bill per cycle.
  Future<Result<void>> save(BillOccurrence occurrence);

  /// Every occurrence, emitting again on change.
  Stream<List<BillOccurrence>> watchAll();
}
