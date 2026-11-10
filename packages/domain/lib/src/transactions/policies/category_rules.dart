import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// Rules that hold across a user's categories (R-CAT-1, R-CAT-2). Uniqueness
/// and usage need the whole set, so they live here rather than on [Category].
abstract final class CategoryRules {
  /// R-CAT-1: a built-in category may be renamed but not archived.
  static Result<void> ensureArchivable(Category category) => validated([
    if (category.isDefault)
      const ValidationFailure(
        'category.default',
        'A built-in category can be renamed but not archived.',
      ),
  ], () {});

  /// R-CAT-1: a category still used by a payment may not be removed; archive
  /// it instead. [inUse] is whether any transaction references it.
  static Result<void> ensureDeletable(
    Category category, {
    required bool inUse,
  }) => validated([
    if (inUse)
      const ValidationFailure(
        'category.inUse',
        'This category is used by payments. Archive it instead.',
      ),
  ], () {});

  /// R-CAT-2: a name must not match any of [others], ignoring case and
  /// surrounding spaces.
  static Result<void> ensureUnique(String name, Iterable<String> others) {
    final candidate = name.trim().toLowerCase();
    return validated([
      if (others.any((o) => o.trim().toLowerCase() == candidate))
        const ValidationFailure(
          'category.duplicate',
          'You already have a category with that name.',
        ),
    ], () {});
  }
}
