import 'package:buckets_core/buckets_core.dart';
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
  const Transaction._({
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
  }) {
    final linesTotal = lines.fold(Money.zero, (sum, l) => sum + l.amount);
    return validated(
      [
        requirePositive(amount),
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
  ];
}
