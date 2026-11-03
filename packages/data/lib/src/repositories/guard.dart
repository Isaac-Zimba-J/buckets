import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/mappers/results.dart';

/// Thrown into `watch*()` streams when stored rows can't be read back.
final class StorageReadError implements Exception {
  /// Wraps [failure].
  const new(this.failure);

  /// What went wrong; safe to show.
  final Failure failure;

  @override
  String toString() => 'StorageReadError($failure)';
}

const _failed = StorageFailure(
  'storage',
  "We couldn't read or save your data. Try again.",
);

/// Runs [body], turning any database exception into a `StorageFailure`.
/// Messages never include row data (AGENTS.md §4).
Future<Result<T>> guard<T>(Future<Result<T>> Function() body) async {
  try {
    return await body();
  } on Exception {
    return const Err(_failed);
  }
}

/// [rows] mapped with [map], or the first failure.
Result<List<T>> mapAll<R, T>(Iterable<R> rows, Result<T> Function(R) map) =>
    collectAll(rows.map(map));

/// Like [mapAll] for streams: a failure becomes a [StorageReadError].
List<T> mapAllOrThrow<R, T>(Iterable<R> rows, Result<T> Function(R) map) =>
    switch (mapAll(rows, map)) {
      Ok(:final value) => value,
      Err(:final failure) => throw StorageReadError(failure),
    };

/// A `NotFoundFailure` for a missing [what].
Err<T> notFound<T>(String what) =>
    Err(NotFoundFailure('notFound', 'That $what no longer exists.'));
