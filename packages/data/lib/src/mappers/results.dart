import 'package:buckets_core/buckets_core.dart';

/// All values of [results] in order, or the first failure.
Result<List<T>> collectAll<T>(Iterable<Result<T>> results) {
  final values = <T>[];
  for (final result in results) {
    switch (result) {
      case Ok(:final value):
        values.add(value);
      case Err(:final failure):
        return Err(failure);
    }
  }
  return Ok(values);
}
