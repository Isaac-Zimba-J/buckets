import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/shared/validation.dart';

/// Rules that hold across all of a user's buckets.
abstract final class BucketRules {
  /// Checks R-BUCKET-5 among non-archived buckets: names are unique
  /// (case-insensitive), and there is exactly one Living and one Guilt-free.
  static Result<List<Bucket>> validate(List<Bucket> buckets) {
    final active = buckets.where((b) => !b.archived).toList();
    final names = {for (final b in active) b.name.toLowerCase()};
    int count(BucketKind kind) => active.where((b) => b.kind == kind).length;
    return validated([
      if (names.length != active.length)
        const ValidationFailure(
          'buckets.duplicateName',
          'Two buckets have the same name. Rename one.',
        ),
      if (count(BucketKind.living) != 1)
        const ValidationFailure(
          'buckets.livingCount',
          'There must be exactly one Living bucket.',
        ),
      if (count(BucketKind.guiltFree) != 1)
        const ValidationFailure(
          'buckets.guiltFreeCount',
          'There must be exactly one Guilt-free bucket.',
        ),
    ], () => buckets);
  }
}
