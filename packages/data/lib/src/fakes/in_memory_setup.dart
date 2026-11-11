import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/fakes/memory_store.dart';
import 'package:buckets_domain/buckets_domain.dart';

/// In-memory [AccountRepository].
class InMemoryAccountRepository implements AccountRepository {
  /// The stored items.
  final store = MemoryStore<Account>((a) => a.id);

  @override
  Future<Result<List<Account>>> getAll() =>
      store.run(() => store.items.values.toList());

  @override
  Future<Result<Account>> get(String id) => store.get(id);

  @override
  Future<Result<void>> save(Account account) =>
      store.run(() => store.put(account));

  @override
  Stream<List<Account>> watchAll() =>
      store.watch(() => store.items.values.toList());
}

/// In-memory [BucketRepository].
class InMemoryBucketRepository implements BucketRepository {
  /// The stored items.
  final store = MemoryStore<Bucket>((b) => b.id);

  List<Bucket> _sorted() =>
      store.items.values.toList()
        ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

  @override
  Future<Result<List<Bucket>>> getAll() => store.run(_sorted);

  @override
  Future<Result<Bucket>> get(String id) => store.get(id);

  @override
  Future<Result<void>> saveAll(List<Bucket> buckets) =>
      store.run(() => buckets.forEach(store.put));

  @override
  Stream<List<Bucket>> watchAll() => store.watch(_sorted);
}

/// In-memory [IncomeRepository].
class InMemoryIncomeRepository implements IncomeRepository {
  /// The stored items.
  final store = MemoryStore<IncomeSource>((i) => i.id);

  @override
  Future<Result<List<IncomeSource>>> getAll() =>
      store.run(() => store.items.values.toList());

  @override
  Future<Result<IncomeSource>> get(String id) => store.get(id);

  @override
  Future<Result<void>> save(IncomeSource source) =>
      store.run(() => store.put(source));
}

/// In-memory [SplitProfileRepository].
class InMemorySplitProfileRepository implements SplitProfileRepository {
  /// The stored items.
  final store = MemoryStore<SplitProfile>((p) => p.id);

  @override
  Future<Result<SplitProfile>> get(String id) => store.get(id);

  @override
  Future<Result<void>> save(SplitProfile profile) =>
      store.run(() => store.put(profile));
}

/// In-memory [BillRepository].
class InMemoryBillRepository implements BillRepository {
  /// The stored items.
  final store = MemoryStore<Bill>((b) => b.id);

  @override
  Future<Result<List<Bill>>> getAll() =>
      store.run(() => store.items.values.toList());

  @override
  Future<Result<void>> save(Bill bill) => store.run(() => store.put(bill));

  @override
  Future<Result<void>> delete(String id) => store.run(() => store.remove(id));

  @override
  Stream<List<Bill>> watchAll() =>
      store.watch(() => store.items.values.toList());
}

/// In-memory append-only [LedgerRepository].
class InMemoryLedgerRepository implements LedgerRepository {
  /// The stored items.
  final store = MemoryStore<LedgerEntry>((e) => e.id);

  List<LedgerEntry> _query(String? bucketId, DateWindow? window) =>
      store.items.values
          .where((e) => bucketId == null || e.bucketId == bucketId)
          .where((e) => window == null || window.contains(e.occurredAt))
          .toList()
        ..sort((a, b) => a.occurredAt.compareTo(b.occurredAt));

  @override
  Future<Result<void>> append(List<LedgerEntry> entries) =>
      store.run(() => entries.forEach(store.put));

  @override
  Future<Result<List<LedgerEntry>>> getEntries({
    String? bucketId,
    DateWindow? window,
  }) => store.run(() => _query(bucketId, window));

  @override
  Stream<List<LedgerEntry>> watchEntries({
    String? bucketId,
    DateWindow? window,
  }) => store.watch(() => _query(bucketId, window));
}

/// In-memory [SettingsRepository], starting from the defaults.
class InMemorySettingsRepository implements SettingsRepository {
  /// The stored items.
  final store = MemoryStore<Settings>((_) => 'settings')
    ..items['settings'] = Settings.defaults;

  @override
  Future<Result<Settings>> get() => store.get('settings');

  @override
  Future<Result<void>> save(Settings settings) =>
      store.run(() => store.put(settings));

  @override
  Stream<Settings> watch() => store.watch(() => store.items['settings']!);
}

/// In-memory [ProfileRepository].
class InMemoryProfileRepository implements ProfileRepository {
  /// The stored profile, if any.
  final store = MemoryStore<Profile>((_) => 'profile');

  @override
  Future<Result<Profile?>> get() async => Ok(store.items['profile']);

  @override
  Future<Result<void>> save(Profile profile) =>
      store.run(() => store.put(profile));

  @override
  Stream<Profile?> watch() => store.watch(() => store.items['profile']);
}

/// In-memory [CategoryRepository] seeded with the default categories.
class InMemoryCategoryRepository implements CategoryRepository {
  /// Creates the repository; seeds the defaults like first-run unless
  /// [seedDefaults] is false (contract tests start empty, as drift does).
  InMemoryCategoryRepository({bool seedDefaults = true}) {
    if (seedDefaults) {
      for (final c in Category.defaults) {
        store.items[c.name] = c;
      }
    }
  }

  /// The stored categories, keyed by name.
  final store = MemoryStore<Category>((c) => c.name);

  List<Category> _sorted(Iterable<Category> cats) =>
      cats.toList()
        ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

  @override
  Future<Result<List<Category>>> getAll() =>
      store.run(() => _sorted(store.items.values));

  @override
  Future<Result<List<Category>>> getActive() =>
      store.run(() => _sorted(store.items.values.where((c) => !c.archived)));

  @override
  Stream<List<Category>> watchAll() =>
      store.watch(() => _sorted(store.items.values));

  @override
  Future<Result<void>> add(Category category) =>
      store.run(() => store.put(category));

  @override
  Future<Result<void>> rename({required String from, required Category to}) =>
      store.run(
        () => store
          ..remove(from)
          ..put(to),
      );

  @override
  Future<Result<void>> setArchived(String name, {required bool archived}) =>
      store.run(() {
        final c = store.items[name];
        if (c != null) store.put(archived ? c.archive() : c.unarchive());
      });
}
