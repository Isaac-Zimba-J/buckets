import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fakes/fakes_support.dart';
import '../../helpers.dart';

void main() {
  late InMemoryCategoryRepository categories;
  setUp(() => categories = InMemoryCategoryRepository());

  group('AddCategory', () {
    test('adds a new custom category', () async {
      final added = ok(await AddCategory(categories)('Snacks'));
      expect(added.name, 'Snacks');
      expect(added.isDefault, isFalse);
      expect(
        ok(await categories.getAll()).map((c) => c.name),
        contains('Snacks'),
      );
    });

    test('rejects a duplicate, case-insensitively (R-CAT-2)', () async {
      expect(
        await AddCategory(categories)('food'),
        isErr('category.duplicate'),
      );
    });

    test('rejects a name over 24 characters', () async {
      expect(
        await AddCategory(categories)('a' * 25),
        isErr('category.tooLong'),
      );
    });
  });

  group('RenameCategory', () {
    test('renames a default and keeps it default (R-CAT-1)', () async {
      final renamed = ok(
        await RenameCategory(categories)(from: 'Food', to: 'Groceries'),
      );
      expect(renamed.name, 'Groceries');
      expect(renamed.isDefault, isTrue);
      final names = ok(await categories.getAll()).map((c) => c.name);
      expect(names, contains('Groceries'));
      expect(names, isNot(contains('Food')));
    });

    test('rejects renaming to an existing name', () async {
      expect(
        await RenameCategory(categories)(from: 'Food', to: 'Transport'),
        isErr('category.duplicate'),
      );
    });

    test('NotFound for a missing category', () async {
      expect(
        await RenameCategory(categories)(from: 'Nope', to: 'X'),
        isErr('category.notFound'),
      );
    });
  });

  group('ArchiveCategory', () {
    test('archives a custom category', () async {
      await AddCategory(categories)('Snacks');
      ok(await ArchiveCategory(categories)('Snacks', archived: true));
      expect(
        ok(await categories.getActive()).map((c) => c.name),
        isNot(contains('Snacks')),
      );
      expect(
        ok(await categories.getAll()).map((c) => c.name),
        contains('Snacks'),
      );
    });

    test('refuses to archive a built-in category (R-CAT-1)', () async {
      expect(
        await ArchiveCategory(categories)('Food', archived: true),
        isErr('category.default'),
      );
    });

    test('restores an archived category', () async {
      await AddCategory(categories)('Snacks');
      await ArchiveCategory(categories)('Snacks', archived: true);
      ok(await ArchiveCategory(categories)('Snacks', archived: false));
      expect(
        ok(await categories.getActive()).map((c) => c.name),
        contains('Snacks'),
      );
    });
  });

  test('WatchCategories emits the current list', () async {
    final list = await WatchCategories(categories)().first;
    expect(list.map((c) => c.name), containsAll(['Food', 'Transport']));
  });
}
