import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

void main() {
  group('create', () {
    test('a custom category is not default and not archived', () {
      final c = ok(Category.create('  Snacks '));
      expect(c.name, 'Snacks');
      expect(c.isDefault, isFalse);
      expect(c.archived, isFalse);
    });

    test('a blank name fails', () {
      expect(Category.create('  '), isErr('category.blank'));
    });

    test('a name over 24 characters fails (R-CAT-2)', () {
      expect(Category.create('a' * 25), isErr('category.tooLong'));
      expect(ok(Category.create('a' * 24)).name, 'a' * 24);
    });
  });

  group('defaults', () {
    test('are all marked default (R-CAT-1)', () {
      expect(Category.defaults.every((c) => c.isDefault), isTrue);
      expect(Category.food.isDefault, isTrue);
    });
  });

  group('rename (R-CAT-1)', () {
    test('keeps isDefault and archived', () {
      final renamed = ok(Category.food.rename('Groceries'));
      expect(renamed.name, 'Groceries');
      expect(renamed.isDefault, isTrue);

      final custom = ok(Category.create('Snacks')).archive();
      final renamedCustom = ok(custom.rename('Treats'));
      expect(renamedCustom.name, 'Treats');
      expect(renamedCustom.isDefault, isFalse);
      expect(renamedCustom.archived, isTrue);
    });

    test('validates the new name', () {
      expect(Category.food.rename('  '), isErr('category.blank'));
      expect(Category.food.rename('a' * 25), isErr('category.tooLong'));
    });
  });

  group('archive / unarchive', () {
    test('archive marks archived, keeping the rest', () {
      final c = ok(Category.create('Snacks')).archive();
      expect(c.archived, isTrue);
      expect(c.name, 'Snacks');
      expect(c.isDefault, isFalse);
    });

    test('unarchive clears it', () {
      final c = ok(Category.create('Snacks')).archive().unarchive();
      expect(c.archived, isFalse);
    });
  });

  test('equality includes isDefault and archived', () {
    expect(ok(Category.create('Snacks')), ok(Category.create('Snacks')));
    expect(
      ok(Category.create('Snacks')),
      isNot(ok(Category.create('Snacks')).archive()),
    );
  });
}
