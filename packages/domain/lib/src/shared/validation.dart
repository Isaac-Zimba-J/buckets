import 'package:buckets_core/buckets_core.dart';

/// Builds a value with [build] when every check in [checks] passed (is
/// `null`), otherwise returns the first failure.
Result<T> validated<T>(
  Iterable<ValidationFailure?> checks,
  T Function() build,
) {
  final failure = checks.nonNulls.firstOrNull;
  return failure == null ? Ok(build()) : Err(failure);
}

/// Fails with `<field>.blank` when [value] is empty after trimming.
ValidationFailure? requireText(String value, [String field = 'name']) =>
    value.trim().isEmpty
    ? ValidationFailure('$field.blank', 'Fill in the $field.')
    : null;

/// Fails with `<field>.tooLong` when [value] is longer than [max]
/// characters after trimming.
ValidationFailure? requireMaxLength(
  String value,
  int max, [
  String field = 'name',
]) => value.trim().length <= max
    ? null
    : ValidationFailure(
        '$field.tooLong',
        'Keep the $field to $max characters or fewer.',
      );

/// Fails with `<field>.notPositive` unless [amount] is above K 0.
ValidationFailure? requirePositive(Money? amount, [String field = 'amount']) =>
    amount == null || amount.isPositive
    ? null
    : ValidationFailure('$field.notPositive', 'The $field must be above K 0.');

/// Fails with `<field>.notUtc` unless [time] is stored in UTC (R-TIME-1).
ValidationFailure? requireUtc(DateTime? time, String field) =>
    time == null || time.isUtc
    ? null
    : ValidationFailure('$field.notUtc', 'The $field must be in UTC.');

/// Fails with `<field>.outOfRange` unless [min] ≤ [value] ≤ [max].
ValidationFailure? requireRange(int? value, int min, int max, String field) =>
    value == null || (value >= min && value <= max)
    ? null
    : ValidationFailure(
        '$field.outOfRange',
        'The $field must be from $min to $max.',
      );

/// All values of [results] in order, or the first failure.
Result<List<T>> collect<T>(Iterable<Result<T>> results) {
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
