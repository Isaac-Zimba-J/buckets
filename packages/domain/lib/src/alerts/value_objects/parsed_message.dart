import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/confidence.dart';
import 'package:equatable/equatable.dart';

/// Which way money went in a message (DOMAIN §8 `out` / `in`).
enum MessageDirection {
  /// Money left the account.
  outgoing,

  /// Money arrived.
  incoming,
}

/// What a parser read from a message. Every field may be missing
/// (R-PARSE-2).
final class ParsedMessage with Equatable {
  /// Creates a parse result. Throws a [RangeError] unless [confidence] is
  /// from 0 to 1.
  new({
    required this.confidence,
    this.direction,
    this.amount,
    this.fee,
    this.counterparty,
    this.reference,
    this.occurredAt,
    this.balanceAfter,
    this.isWithdrawal = false,
  }) {
    checkConfidence(confidence);
  }

  const new _unparsed()
    : confidence = 0,
      direction = null,
      amount = null,
      fee = null,
      counterparty = null,
      reference = null,
      occurredAt = null,
      balanceAfter = null,
      isWithdrawal = false;

  /// Text nothing could be read from (R-PARSE-2).
  static const unparsed = ParsedMessage._unparsed();

  /// Out or in.
  final MessageDirection? direction;

  /// The amount moved.
  final Money? amount;

  /// The provider's fee.
  final Money? fee;

  /// The other party: merchant, person or account.
  final String? counterparty;

  /// The provider's transaction reference.
  final String? reference;

  /// When the message says it happened, in UTC.
  final DateTime? occurredAt;

  /// The balance the message reports afterwards.
  final Money? balanceAfter;

  /// How sure the parser is, from 0 to 1.
  final double confidence;

  /// Whether this is a cash withdrawal at an agent or ATM (R-SPEND-4).
  final bool isWithdrawal;

  @override
  List<Object?> get props => [
    direction,
    amount,
    fee,
    counterparty,
    reference,
    occurredAt,
    balanceAfter,
    confidence,
    isWithdrawal,
  ];
}
