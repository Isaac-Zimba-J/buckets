import 'package:buckets_domain/src/transactions/ports/category_repository.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// Streams every category for the auto-filing rules screen (SCREENS 28).
final class WatchCategories {
  /// Creates the use case.
  const new(this._categories);

  final CategoryRepository _categories;

  /// Emits the categories and again on change.
  Stream<List<Category>> call() => _categories.watchAll();
}
