import 'package:meta/meta.dart';

/// An amount of Zambian kwacha stored as whole ngwee (K 1 = 100 ngwee).
///
/// Never backed by a `double` (R-MONEY-1). Amounts may be negative, for
/// spending and overspent balances.
@immutable
final class Money implements Comparable<Money> {
  /// Creates an amount of [ngwee].
  const Money(this.ngwee);

  /// Creates an amount of whole [kwacha].
  const Money.kwacha(int kwacha) : ngwee = kwacha * 100;

  /// K 0.
  static const zero = Money(0);

  /// The amount in ngwee.
  final int ngwee;

  /// Whether this is K 0.
  bool get isZero => ngwee == 0;

  /// Whether this is below K 0.
  bool get isNegative => ngwee < 0;

  /// Whether this is above K 0.
  bool get isPositive => ngwee > 0;

  /// The sum of this and [other].
  Money operator +(Money other) => Money(ngwee + other.ngwee);

  /// This minus [other].
  Money operator -(Money other) => Money(ngwee - other.ngwee);

  /// This amount with the sign flipped.
  Money operator -() => Money(-ngwee);

  /// This amount without its sign.
  Money abs() => Money(ngwee.abs());

  /// Whether this is less than [other].
  bool operator <(Money other) => ngwee < other.ngwee;

  /// Whether this is less than or equal to [other].
  bool operator <=(Money other) => ngwee <= other.ngwee;

  /// Whether this is greater than [other].
  bool operator >(Money other) => ngwee > other.ngwee;

  /// Whether this is greater than or equal to [other].
  bool operator >=(Money other) => ngwee >= other.ngwee;

  @override
  int compareTo(Money other) => ngwee.compareTo(other.ngwee);

  @override
  bool operator ==(Object other) => other is Money && other.ngwee == ngwee;

  @override
  int get hashCode => ngwee.hashCode;

  @override
  String toString() => 'Money($ngwee ngwee)';
}
