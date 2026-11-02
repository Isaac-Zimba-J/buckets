import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// Side-hustle money held until month end (R-PAY-6).
final class HeldIncome with Equatable {
  const HeldIncome._({
    required this.id,
    required this.incomeSourceId,
    required this.amount,
    required this.receivedAt,
    required this.alertId,
  });

  /// Validates and creates a held amount.
  static Result<HeldIncome> create({
    required String id,
    required String incomeSourceId,
    required Money amount,
    required DateTime receivedAt,
    String? alertId,
  }) => validated(
    [requirePositive(amount), requireUtc(receivedAt, 'receivedAt')],
    () => HeldIncome._(
      id: id,
      incomeSourceId: incomeSourceId,
      amount: amount,
      receivedAt: receivedAt,
      alertId: alertId,
    ),
  );

  /// Unique ID.
  final String id;

  /// The side hustle it came from.
  final String incomeSourceId;

  /// The amount held.
  final Money amount;

  /// When it arrived, in UTC.
  final DateTime receivedAt;

  /// The alert it came from, if any.
  final String? alertId;

  @override
  List<Object?> get props => [id, incomeSourceId, amount, receivedAt, alertId];
}
