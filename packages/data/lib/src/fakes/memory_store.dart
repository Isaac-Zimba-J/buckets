import 'dart:async';

import 'package:buckets_core/buckets_core.dart';

/// Items by ID in memory, announcing every change. Backs the `InMemory*`
/// repositories used by tests and demo mode.
class MemoryStore<T> {
  /// Creates a store that keys items with [idOf].
  new(this.idOf);

  /// Reads an item's key.
  final String Function(T) idOf;

  /// The stored items by key.
  final items = <String, T>{};

  final _changes = StreamController<void>.broadcast();

  /// Set to make every call fail with a `StorageFailure` (error states).
  bool failing = false;

  static const _failure = StorageFailure('storage', 'Storage failed.');

  /// Runs [action] unless [failing].
  Future<Result<R>> run<R>(R Function() action) {
    return Future<Result<R>>.value(
      failing ? const Err(_failure) : Ok<R>(action()),
    );
  }

  /// The item with [id], or a `NotFoundFailure`.
  Future<Result<T>> get(String id) {
    final item = items[id];
    return Future<Result<T>>.value(
      failing
          ? const Err(_failure)
          : item == null
          ? const Err(
              NotFoundFailure('notFound', 'That item no longer exists.'),
            )
          : Ok(item),
    );
  }

  /// Inserts or replaces [item].
  void put(T item) {
    items[idOf(item)] = item;
    _changes.add(null);
  }

  /// Removes the item with [id].
  void remove(String id) {
    items.remove(id);
    _changes.add(null);
  }

  /// [read] now and after every change. A plain controller rather than
  /// `async*`, so cancelling never waits on an idle generator.
  Stream<R> watch<R>(R Function() read) {
    StreamSubscription<void>? changes;
    late final StreamController<R> out;
    out = StreamController<R>(
      onListen: () {
        out.add(read());
        changes = _changes.stream.listen((_) => out.add(read()));
      },
      onCancel: () => changes?.cancel(),
    );
    return out.stream;
  }
}
