import 'package:buckets_core/src/result/failure.dart';

/// The outcome of an operation that can fail in an expected way.
///
/// Match it with a `switch` on [Ok] and [Err]; use cases return this instead
/// of throwing.
sealed class Result<T> {
  const Result();
}

/// A successful [Result] holding [value].
final class Ok<T> extends Result<T> {
  /// Creates a success.
  const Ok(this.value);

  /// The result value.
  final T value;
}

/// A failed [Result] holding [failure].
final class Err<T> extends Result<T> {
  /// Creates a failure result.
  const Err(this.failure);

  /// What went wrong.
  final Failure failure;
}
