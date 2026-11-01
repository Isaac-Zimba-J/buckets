import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';

/// Stores buckets, including archived ones. Balances are not stored here
/// (R-BUCKET-4).
abstract interface class BucketRepository {
  /// Every bucket.
  Future<Result<List<Bucket>>> getAll();

  /// The bucket with [id], or `NotFoundFailure`.
  Future<Result<Bucket>> get(String id);

  /// Inserts or replaces [buckets] in one transaction.
  Future<Result<void>> saveAll(List<Bucket> buckets);

  /// Every bucket in sort order, emitting again on change.
  Stream<List<Bucket>> watchAll();
}
