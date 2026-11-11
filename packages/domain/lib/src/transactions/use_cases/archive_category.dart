import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/policies/category_rules.dart';
import 'package:buckets_domain/src/transactions/ports/category_repository.dart';

/// Archives or restores a category (SCREENS 28, R-CAT-1). A built-in
/// category cannot be archived.
final class ArchiveCategory {
  /// Creates the use case.
  const new(this._categories);

  final CategoryRepository _categories;

  /// Sets the archived state for the category named [name].
  Future<Result<void>> call(String name, {required bool archived}) => attempt(
    () async {
      final all = unwrap(await _categories.getAll());
      final category = all.where((c) => c.name == name).firstOrNull;
      if (category == null) {
        unwrap<void>(
          const Err(NotFoundFailure('category.notFound', 'No such category.')),
        );
      }
      if (archived) {
        unwrap(CategoryRules.ensureArchivable(category!));
      }
      unwrap(await _categories.setArchived(name, archived: archived));
    },
  );
}
