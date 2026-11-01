import 'package:equatable/equatable.dart';

/// What caused a ledger entry.
final class LedgerRefs with Equatable {
  /// Creates refs; every field is optional.
  const LedgerRefs({
    this.paydayId,
    this.transferId,
    this.alertId,
    this.transactionId,
    this.receiptId,
  });

  /// No refs.
  static const none = LedgerRefs();

  /// The payday that allocated the money.
  final String? paydayId;

  /// The payday transfer.
  final String? transferId;

  /// The payment alert.
  final String? alertId;

  /// The spending transaction.
  final String? transactionId;

  /// The scanned receipt.
  final String? receiptId;

  @override
  List<Object?> get props => [
    paydayId,
    transferId,
    alertId,
    transactionId,
    receiptId,
  ];
}
