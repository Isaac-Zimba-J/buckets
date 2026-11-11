import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/policies/category_rules.dart';
import 'package:buckets_domain/src/transactions/ports/category_repository.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// Adds a custom category (SCREENS 28, R-CAT-2).
final class AddCategory {
  /// Creates the use case.
  const new(this._categories);

  final CategoryRepository _categories;

  /// Validates the name, checks it is unique, and saves it.
  Future<Result<Category>> call(String name) => attempt(() async {
    final existing = unwrap(await _categories.getAll());
    unwrap(CategoryRules.ensureUnique(name, existing.map((c) => c.name)));
    final category = unwrap(Category.create(name));
    unwrap(await _categories.add(category));
    return category;
  });
}
