import 'package:buckets_core/buckets_core.dart';

final class _Failed implements Exception {
  const _Failed(this.failure);

  final Failure failure;
}

/// The value of [result]; inside [attempt], a failure ends the attempt.
T unwrap<T>(Result<T> result) => switch (result) {
  Ok(:final value) => value,
  Err(:final failure) => throw _Failed(failure),
};

/// Runs [body], turning the first [unwrap]ped failure into an [Err].
/// Lets use cases read top to bottom without nested switches.
Future<Result<T>> attempt<T>(Future<T> Function() body) async {
  try {
    return Ok(await body());
  } on _Failed catch (e) {
    return Err(e.failure);
  }
}
