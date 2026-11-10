import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// Stores the user's categories (SCREENS 28, R-CAT-1/2). Default categories
/// are seeded on first run; the user adds, renames and archives their own.
abstract interface class CategoryRepository {
  /// Every category, archived ones included, for the management screen.
  Future<Result<List<Category>>> getAll();

  /// Only the active (non-archived) categories, for pickers.
  Future<Result<List<Category>>> getActive();

  /// The categories, emitting again on change.
  Stream<List<Category>> watchAll();

  /// Adds a new custom category. Uniqueness (R-CAT-2) is checked by the use
  /// case before this is called.
  Future<Result<void>> add(Category category);

  /// Renames the category named [from] to [to], keeping transactions that
  /// use it pointed at the new name (R-CAT-1).
  Future<Result<void>> rename({required String from, required Category to});

  /// Archives or restores the category named [name] (R-CAT-1).
  Future<Result<void>> setArchived(String name, {required bool archived});
}
