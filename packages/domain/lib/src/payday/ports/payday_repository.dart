import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';

/// Stores paydays with their transfers.
abstract interface class PaydayRepository {
  /// The payday with [id], or `NotFoundFailure`.
  Future<Result<Payday>> get(String id);

  /// Every payday, newest first (for the streak, R-PROOF-5).
  Future<Result<List<Payday>>> getAll();

  /// Inserts or replaces [payday] and its transfers.
  Future<Result<void>> save(Payday payday);

  /// Whether any transfer's proof already used [reference] (R-PROOF-1.4).
  Future<Result<bool>> isProofReferenceUsed(String reference);

  /// The payday with [id], emitting again on change.
  Stream<Payday> watch(String id);

  /// The open payday, or null when none is open.
  Stream<Payday?> watchOpen();
}
