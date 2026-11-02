import 'dart:async';

import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

/// A map of items by ID that announces every change.
class _Store<T> {
  _Store(this.idOf);

  final String Function(T) idOf;
  final items = <String, T>{};
  final _changes = StreamController<void>.broadcast();

  /// Set to make every call fail with a `StorageFailure`.
  bool failing = false;

  Future<Result<R>> run<R>(R Function() action) async => failing
      ? const Err(StorageFailure('storage', 'Storage failed.'))
      : Ok(action());

  Future<Result<T>> get(String id) async {
    if (failing) return const Err(StorageFailure('storage', 'Storage failed.'));
    final item = items[id];
    return item == null
        ? Err(NotFoundFailure('notFound', 'No item $id.'))
        : Ok(item);
  }

  void put(T item) {
    items[idOf(item)] = item;
    _changes.add(null);
  }

  void remove(String id) {
    items.remove(id);
    _changes.add(null);
  }

  Stream<R> watch<R>(R Function() read) async* {
    yield read();
    await for (final _ in _changes.stream) {
      yield read();
    }
  }
}

/// In-memory [AccountRepository].
class InMemoryAccountRepository implements AccountRepository {
  final store = _Store<Account>((a) => a.id);

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
  final store = _Store<Bucket>((b) => b.id);

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
  final store = _Store<IncomeSource>((i) => i.id);

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
  final store = _Store<SplitProfile>((p) => p.id);

  @override
  Future<Result<SplitProfile>> get(String id) => store.get(id);

  @override
  Future<Result<void>> save(SplitProfile profile) =>
      store.run(() => store.put(profile));
}

/// In-memory [BillRepository].
class InMemoryBillRepository implements BillRepository {
  final store = _Store<Bill>((b) => b.id);

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
  final store = _Store<LedgerEntry>((e) => e.id);

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
  final store = _Store<Settings>((_) => 'settings')
    ..items['settings'] = Settings.defaults;

  @override
  Future<Result<Settings>> get() => store.get('settings');

  @override
  Future<Result<void>> save(Settings settings) =>
      store.run(() => store.put(settings));

  @override
  Stream<Settings> watch() => store.watch(() => store.items['settings']!);
}

/// A [PermissionGateway] whose answers tests set.
class FakePermissionGateway implements PermissionGateway {
  final states = <AppPermission, PermissionState>{};
  final opened = <AppPermission>[];

  /// What [request] changes a permission to.
  PermissionState grantOnRequest = PermissionState.granted;

  @override
  Future<Result<PermissionState>> status(AppPermission permission) async =>
      Ok(states[permission] ?? PermissionState.denied);

  @override
  Future<Result<PermissionState>> request(AppPermission permission) async =>
      Ok(states[permission] = grantOnRequest);

  @override
  Future<Result<void>> openSettings(AppPermission permission) async {
    opened.add(permission);
    return const Ok(null);
  }
}

/// A [Clock] fixed at [now] until a test moves it.
class FakeClock implements Clock {
  FakeClock(this.now_);

  DateTime now_;

  @override
  DateTime now() => now_;
}

/// Africa/Lusaka: UTC+2 all year.
class LusakaTimeZone implements LocalTimeZone {
  @override
  Duration offsetAt(DateTime utc) => const Duration(hours: 2);
}
