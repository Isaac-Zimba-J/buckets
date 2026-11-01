import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/split/entities/split_profile.dart';

/// Stores split profiles. Saving a new version never touches past ledger
/// entries (R-SPLIT-6).
abstract interface class SplitProfileRepository {
  /// The profile with [id], or `NotFoundFailure`.
  Future<Result<SplitProfile>> get(String id);

  /// Inserts or replaces [profile].
  Future<Result<void>> save(SplitProfile profile);
}
