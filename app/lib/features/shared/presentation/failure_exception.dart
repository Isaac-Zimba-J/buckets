import 'package:buckets_core/buckets_core.dart';

/// A domain [Failure] carried through Riverpod's `AsyncValue.error`, so
/// screens can show its safe message (ARCHITECTURE §8).
final class FailureException implements Exception {
  /// Wraps [failure].
  const new(this.failure);

  /// What went wrong; its message is safe to show.
  final Failure failure;

  @override
  String toString() => 'FailureException($failure)';
}

/// Unwraps results inside controller `build()` methods.
extension ResultOrThrow<T> on Result<T> {
  /// The value, or a [FailureException] that becomes the error state.
  T orThrow() => switch (this) {
    Ok(:final value) => value,
    Err(:final failure) => throw FailureException(failure),
  };
}

/// Riverpod's retry policy for the app: a [FailureException] is an
/// expected outcome (validation, not found, storage) that the screen shows
/// with its own "try again", so it is never retried automatically.
Duration? retryUnlessFailure(int retryCount, Object error) =>
    error is FailureException || retryCount >= 3
    ? null
    : Duration(milliseconds: 200 * (1 << retryCount));
