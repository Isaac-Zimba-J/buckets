import 'dart:async';

/// Stream helpers for repositories.
extension StartWith<T> on Stream<T> {
  /// Emits the value of [first] before this stream's events, so a watcher
  /// gets the current state immediately.
  Stream<T> startWithFuture(Future<T> Function() first) async* {
    yield await first();
    yield* this;
  }
}
