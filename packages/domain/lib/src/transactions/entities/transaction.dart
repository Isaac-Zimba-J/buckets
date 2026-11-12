import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';
import 'package:buckets_domain/src/transactions/value_objects/transaction_line.dart';
import 'package:equatable/equatable.dart';

/// How a transaction was logged.
enum TransactionSource {
  /// From a payment alert.
  alert,

  /// Logged by hand as cash.
  cash,

  /// From a scanned receipt.
  receipt,

  /// From pasted message text.
  pasted,
}

/// Money spent (DOMAIN §10).
final class Transaction with Equatable {
  const new _({
    required this.id,
    required this.amount,
    required this.bucketId,
    required this.category,
    required this.accountId,
    required this.occurredAt,
    required this.source,
    required this.note,
    required this.alertId,
    required this.receiptId,
    required this.lines,
    required this.billId,
    required this.feeType,
    required this.provider,
    required this.feeSource,
    required this.parentTransactionId,
  });

  /// Validates and creates a transaction. If [lines] split it across
  /// buckets, they must add up to [amount].
  static Result<Transaction> create({
    required String id,
    required Money amount,
    required String bucketId,
    required Category category,
    required String accountId,
    required DateTime occurredAt,
    required TransactionSource source,
    String? note,
    String? alertId,
    String? receiptId,
    List<TransactionLine> lines = const [],
    String? billId,
    FeeType? feeType,
    AlertSource? provider,
    FeeSource? feeSource,
    String? parentTransactionId,
  }) {
    final isFee = feeType != null || feeSource != null;
    final linesTotal = lines.fold(Money.zero, (sum, l) => sum + l.amount);
    return validated(
      [
        // A fee whose amount is unknown is recorded as K 0 (R-FEE-2).
        if (feeSource == FeeSource.missing)
          if (amount.isNegative)
            const ValidationFailure(
              'amount.negative',
              'The amount cannot be negative.',
            )
          else
            null
        else
          requirePositive(amount),
        if (isFee && category != Category.fees)
          const ValidationFailure(
            'fee.category',
            'Only a Fees transaction can carry fee details.',
          ),
        if (feeSource != null && feeType == null)
          const ValidationFailure('fee.type', 'Say what the fee was for.'),
        requireUtc(occurredAt, 'occurredAt'),
        for (final line in lines) requirePositive(line.amount, 'line'),
        if (lines.isNotEmpty && linesTotal != amount)
          const ValidationFailure(
            'lines.sumMismatch',
            'The split parts must add up to the total.',
          ),
      ],
      () => Transaction._(
        id: id,
        amount: amount,
        bucketId: bucketId,
        category: category,
        accountId: accountId,
        occurredAt: occurredAt,
        source: source,
        note: note,
        alertId: alertId,
        receiptId: receiptId,
        lines: List.unmodifiable(lines),
        billId: billId,
        feeType: feeType,
        provider: provider,
        feeSource: feeSource,
        parentTransactionId: parentTransactionId,
      ),
    );
  }

  /// Unique ID.
  final String id;

  /// The amount spent, positive.
  final Money amount;

  /// The bucket it came from.
  final String bucketId;

  /// What it was spent on.
  final Category category;

  /// The account it was paid from.
  final String accountId;

  /// When it was spent, in UTC.
  final DateTime occurredAt;

  /// How it was logged.
  final TransactionSource source;

  /// Optional note.
  final String? note;

  /// The alert it came from.
  final String? alertId;

  /// The receipt it came from.
  final String? receiptId;

  /// The split across buckets, if any.
  final List<TransactionLine> lines;

  /// The bill this pays, if any; it draws on the money put aside for it
  /// (R-BILL-2a).
  final String? billId;

  /// What the fee was for (R-FEE-1); null unless this is a fee.
  final FeeType? feeType;

  /// The mobile-money provider that charged the fee.
  final AlertSource? provider;

  /// Where the fee amount came from (R-FEE-2).
  final FeeSource? feeSource;

  /// The transfer, bill payment or withdrawal this fee belongs to.
  final String? parentTransactionId;

  @override
  List<Object?> get props => [
    id,
    amount,
    bucketId,
    category,
    accountId,
    occurredAt,
    source,
    note,
    alertId,
    receiptId,
    lines,
    billId,
    feeType,
    provider,
    feeSource,
    parentTransactionId,
  ];
}
