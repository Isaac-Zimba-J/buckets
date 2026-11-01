import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// Cash taken out at an agent or ATM. Moves money into Cash in hand; it is
/// not spending (R-SPEND-4).
final class CashWithdrawal with Equatable {
  const CashWithdrawal._({
    required this.id,
    required this.amount,
    required this.fromAccountId,
    required this.cashAccountId,
    required this.occurredAt,
    required this.alertId,
  });

  /// Validates and creates a withdrawal.
  static Result<CashWithdrawal> create({
    required String id,
    required Money amount,
    required String fromAccountId,
    required String cashAccountId,
    required DateTime occurredAt,
    String? alertId,
  }) => validated(
    [requirePositive(amount), requireUtc(occurredAt, 'occurredAt')],
    () => CashWithdrawal._(
      id: id,
      amount: amount,
      fromAccountId: fromAccountId,
      cashAccountId: cashAccountId,
      occurredAt: occurredAt,
      alertId: alertId,
    ),
  );

  /// Unique ID.
  final String id;

  /// Cash taken out.
  final Money amount;

  /// The account it came from.
  final String fromAccountId;

  /// The Cash in hand account it went to.
  final String cashAccountId;

  /// When it happened, in UTC.
  final DateTime occurredAt;

  /// The alert it came from.
  final String? alertId;

  @override
  List<Object?> get props => [
    id,
    amount,
    fromAccountId,
    cashAccountId,
    occurredAt,
    alertId,
  ];
}
