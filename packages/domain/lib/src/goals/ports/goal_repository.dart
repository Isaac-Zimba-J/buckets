import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/goals/entities/goal.dart';

/// Stores goal targets, keyed by bucket.
abstract interface class GoalRepository {
  /// The goal for [bucketId], if any.
  Future<Result<Goal?>> get(String bucketId);

  /// Inserts or replaces [goal].
  Future<Result<void>> save(Goal goal);

  /// Every goal, emitting again on change.
  Stream<List<Goal>> watchAll();
}
