import 'package:equatable/equatable.dart';

/// What caused a ledger entry.
final class LedgerRefs with Equatable {
  /// Creates refs; every field is optional.
  const new({
    this.paydayId,
    this.transferId,
    this.alertId,
    this.transactionId,
    this.receiptId,
    this.billId,
    this.carryOverId,
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

  /// The bill this money is reserved for or pays (R-BILL-2).
  final String? billId;

  /// The overspend carry-over this entry starts or settles (R-OVER-2).
  final String? carryOverId;

  @override
  List<Object?> get props => [
    paydayId,
    transferId,
    alertId,
    transactionId,
    receiptId,
    billId,
    carryOverId,
  ];
}
