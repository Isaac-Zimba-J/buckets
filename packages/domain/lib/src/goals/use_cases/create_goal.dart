import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/policies/bucket_rules.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/goals/entities/goal.dart';
import 'package:buckets_domain/src/goals/ports/goal_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Creates a savings goal: a goal bucket with a target (screen 10).
final class CreateGoal {
  /// Creates the use case.
  const CreateGoal(this._buckets, this._goals, this._ids);

  final BucketRepository _buckets;
  final GoalRepository _goals;
  final IdGenerator _ids;

  /// The goal; its bucket lives in [accountId] and goes last in order. It
  /// is in no split until the user adds it ("not in any split yet").
  Future<Result<Goal>> call({
    required String name,
    required Money target,
    required String accountId,
    DateTime? targetDate,
  }) => attempt(() async {
    final existing = unwrap(await _buckets.getAll());
    final bucket = unwrap(
      Bucket.create(
        id: _ids.newId(),
        name: name,
        kind: BucketKind.goal,
        color: BucketColor.goal,
        accountId: accountId,
        sortOrder: existing.fold(
          0,
          (m, b) => b.sortOrder >= m ? b.sortOrder + 1 : m,
        ),
      ),
    );
    unwrap(BucketRules.validate([...existing, bucket]));
    final goal = unwrap(
      Goal.create(bucketId: bucket.id, target: target, targetDate: targetDate),
    );
    unwrap(await _buckets.saveAll([bucket]));
    unwrap(await _goals.save(goal));
    return goal;
  });
}
