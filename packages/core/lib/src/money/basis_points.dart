import 'package:buckets_core/src/money/money.dart';
import 'package:meta/meta.dart';

/// A percentage in basis points: 10000 = 100%, 1000 = 10% (R-MONEY-2).
@immutable
final class BasisPoints implements Comparable<BasisPoints> {
  /// Creates a percentage of [value] basis points, from 0 to [max].
  ///
  /// Throws a [RangeError] outside that range. Validate user input in the
  /// domain before constructing.
  BasisPoints(this.value) {
    RangeError.checkValueInInterval(value, 0, max, 'value');
  }

  /// The largest allowed value, 100%.
  static const max = 10000;

  /// 100%.
  static final full = BasisPoints(max);

  /// The percentage in basis points.
  final int value;

  /// This percentage of [amount], floored to the ngwee (R-MONEY-3).
  Money applyTo(Money amount) {
    final product = amount.ngwee * value;
    final quotient = product ~/ max;
    // `~/` truncates toward zero; floor means one lower for negative remainders.
    return Money(product < 0 && product % max != 0 ? quotient - 1 : quotient);
  }

  @override
  int compareTo(BasisPoints other) => value.compareTo(other.value);

  @override
  bool operator ==(Object other) =>
      other is BasisPoints && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'BasisPoints($value)';
}
