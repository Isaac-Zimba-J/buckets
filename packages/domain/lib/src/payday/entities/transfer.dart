import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// Where a payday transfer stands (DOMAIN §7).
enum TransferStatus {
  /// Not moved yet.
  pending,

  /// Moved, with a passing proof.
  proven,

  /// Marked as saved without proof (R-PROOF-4).
  selfReported,

  /// Partly moved, with an amount still owed (R-PROOF-3).
  partial,
}

/// Money that must move from the landing account to a bucket's account on
/// payday (R-PAY-2).
final class Transfer with Equatable {
  const Transfer._({
    required this.id,
    required this.bucketId,
    required this.toAccountId,
    required this.amount,
    required this.status,
    required this.provenAmount,
    required this.owedAmount,
    required this.proofRef,
    required this.provenAt,
  });

  /// Validates and creates a transfer.
  static Result<Transfer> create({
    required String id,
    required String bucketId,
    required String toAccountId,
    required Money amount,
    TransferStatus status = TransferStatus.pending,
    Money? provenAmount,
    Money? owedAmount,
    String? proofRef,
    DateTime? provenAt,
  }) => validated(
    [requirePositive(amount), requireUtc(provenAt, 'provenAt')],
    () => Transfer._(
      id: id,
      bucketId: bucketId,
      toAccountId: toAccountId,
      amount: amount,
      status: status,
      provenAmount: provenAmount,
      owedAmount: owedAmount,
      proofRef: proofRef,
      provenAt: provenAt,
    ),
  );

  /// Unique ID.
  final String id;

  /// The bucket the money is for.
  final String bucketId;

  /// The account the money must reach.
  final String toAccountId;

  /// The amount to move.
  final Money amount;

  /// Where it stands.
  final TransferStatus status;

  /// The amount a proof showed moved.
  final Money? provenAmount;

  /// The amount still owed after a partial proof.
  final Money? owedAmount;

  /// The reference of the proof message.
  final String? proofRef;

  /// When it was proven, in UTC.
  final DateTime? provenAt;

  @override
  List<Object?> get props => [
    id,
    bucketId,
    toAccountId,
    amount,
    status,
    provenAmount,
    owedAmount,
    proofRef,
    provenAt,
  ];
}
