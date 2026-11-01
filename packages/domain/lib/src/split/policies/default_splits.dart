import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/split/value_objects/allocation.dart';

/// The splits suggested for a new income (R-SPLIT-4, R-SPLIT-5).
///
/// When there is no active goal bucket, the goal's share goes to the bucket
/// of kind `goalShareFallback` (the `Settings.goalShareFallback` setting,
/// Long-term by default). Shares landing on the same bucket add up.
abstract final class DefaultSplits {
  /// Living 40%, Guilt-free 10%, Emergency 10%, Short-term 10%, Long-term
  /// 20%, first goal 10% (R-SPLIT-4).
  static Result<List<Allocation>> salary(
    List<Bucket> buckets, {
    BucketKind goalShareFallback = BucketKind.longTerm,
  }) => _build(buckets, goalShareFallback, const [
    (BucketKind.living, 4000),
    (BucketKind.guiltFree, 1000),
    (BucketKind.emergency, 1000),
    (BucketKind.shortTerm, 1000),
    (BucketKind.longTerm, 2000),
    (BucketKind.goal, 1000),
  ]);

  /// Restock 30%, Long-term 30%, a goal 20%, Guilt-free 20%; Restock is
  /// Short-term when there is no business bucket (R-SPLIT-5).
  static Result<List<Allocation>> sideHustle(
    List<Bucket> buckets, {
    BucketKind goalShareFallback = BucketKind.longTerm,
  }) {
    final hasBusiness = buckets.any(
      (b) => !b.archived && b.kind == BucketKind.business,
    );
    return _build(buckets, goalShareFallback, [
      (hasBusiness ? BucketKind.business : BucketKind.shortTerm, 3000),
      (BucketKind.longTerm, 3000),
      (BucketKind.goal, 2000),
      (BucketKind.guiltFree, 2000),
    ]);
  }

  static Result<List<Allocation>> _build(
    List<Bucket> buckets,
    BucketKind goalShareFallback,
    List<(BucketKind, int)> specs,
  ) {
    final active = buckets.where((b) => !b.archived).toList()
      ..sort((x, y) => x.sortOrder.compareTo(y.sortOrder));
    Bucket? firstOf(BucketKind kind) =>
        active.where((b) => b.kind == kind).firstOrNull;
    final hasGoal = firstOf(BucketKind.goal) != null;
    final shares = <String, int>{};
    for (final (kind, bp) in specs) {
      final target = kind == BucketKind.goal && !hasGoal
          ? goalShareFallback
          : kind;
      final bucket = firstOf(target);
      if (bucket == null) {
        return Err(
          ValidationFailure(
            'split.missingBucket',
            'There is no ${target.name} bucket for the default split.',
          ),
        );
      }
      shares.update(bucket.id, (sum) => sum + bp, ifAbsent: () => bp);
    }
    return Ok([
      for (final MapEntry(:key, :value) in shares.entries)
        Allocation(key, BasisPoints(value)),
    ]);
  }
}
