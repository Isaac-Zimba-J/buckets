import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/policies/category_rules.dart';
import 'package:buckets_domain/src/transactions/ports/category_repository.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// Renames a category (SCREENS 28, R-CAT-1). Defaults may be renamed.
final class RenameCategory {
  /// Creates the use case.
  const new(this._categories);

  final CategoryRepository _categories;

  /// Checks the new name is unique among the others, then renames.
  Future<Result<Category>> call({required String from, required String to}) =>
      attempt(() async {
        final all = unwrap(await _categories.getAll());
        final current = all.where((c) => c.name == from).firstOrNull;
        if (current == null) {
          unwrap<void>(
            const Err(
              NotFoundFailure('category.notFound', 'No such category.'),
            ),
          );
        }
        final others = all.where((c) => c.name != from).map((c) => c.name);
        unwrap(CategoryRules.ensureUnique(to, others));
        final renamed = unwrap(current!.rename(to));
        unwrap(await _categories.rename(from: from, to: renamed));
        return renamed;
      });
}
