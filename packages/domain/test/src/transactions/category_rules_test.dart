import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('ensureArchivable (R-CAT-1)', () {
    test('a built-in category may not be archived', () {
      expect(
        CategoryRules.ensureArchivable(Category.food),
        isErr('category.default'),
      );
    });

    test('a custom category may be archived', () {
      final custom = ok(Category.create('Snacks'));
      expect(CategoryRules.ensureArchivable(custom), isA<Ok<void>>());
    });

    test('a renamed default is still a default', () {
      final renamed = ok(Category.food.rename('Groceries'));
      expect(
        CategoryRules.ensureArchivable(renamed),
        isErr('category.default'),
      );
    });
  });

  group('ensureDeletable (R-CAT-1)', () {
    test('a category in use may not be deleted', () {
      final custom = ok(Category.create('Snacks'));
      expect(
        CategoryRules.ensureDeletable(custom, inUse: true),
        isErr('category.inUse'),
      );
    });

    test('an unused category may be deleted', () {
      final custom = ok(Category.create('Snacks'));
      expect(
        CategoryRules.ensureDeletable(custom, inUse: false),
        isA<Ok<void>>(),
      );
    });
  });

  group('ensureUnique (R-CAT-2)', () {
    test('rejects a case-insensitive duplicate', () {
      expect(
        CategoryRules.ensureUnique('food', ['Transport', 'Food']),
        isErr('category.duplicate'),
      );
      expect(
        CategoryRules.ensureUnique('  SNACKS ', ['snacks']),
        isErr('category.duplicate'),
      );
    });

    test('allows a new name', () {
      expect(
        CategoryRules.ensureUnique('Snacks', ['Food', 'Transport']),
        isA<Ok<void>>(),
      );
    });

    test('allows an empty existing set', () {
      expect(
        CategoryRules.ensureUnique('Food', const <String>[]),
        isA<Ok<void>>(),
      );
    });
  });
}
