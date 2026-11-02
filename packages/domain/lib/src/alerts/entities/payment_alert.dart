import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// Who sent a payment alert.
enum AlertSource {
  /// MTN MoMo.
  mtnMomo,

  /// Airtel Money.
  airtelMoney,

  /// A bank.
  bank,

  /// Not recognised.
  unknown,
}

/// Where an alert is in sorting (DOMAIN §8; `new` is a Dart keyword).
enum AlertStatus {
  /// Not sorted yet (DOMAIN `new`).
  newAlert,

  /// Filed as a transaction or proof.
  sorted,

  /// Dismissed by the user.
  ignored,

  /// Same payment as an earlier alert (R-PARSE-4).
  duplicate,
}

/// A payment notification read from the phone (DOMAIN §8).
final class PaymentAlert with Equatable {
  const PaymentAlert._({
    required this.id,
    required this.rawText,
    required this.source,
    required this.receivedAt,
    required this.parsed,
    required this.status,
  });

  /// Validates and creates an alert.
  static Result<PaymentAlert> create({
    required String id,
    required String? rawText,
    required AlertSource source,
    required DateTime receivedAt,
    required ParsedMessage parsed,
    AlertStatus status = AlertStatus.newAlert,
  }) => validated(
    [requireUtc(receivedAt, 'receivedAt')],
    () => PaymentAlert._(
      id: id,
      rawText: rawText,
      source: source,
      receivedAt: receivedAt,
      parsed: parsed,
      status: status,
    ),
  );

  /// This alert with [status].
  Result<PaymentAlert> withStatus(AlertStatus status) => create(
    id: id,
    rawText: rawText,
    source: source,
    receivedAt: receivedAt,
    parsed: parsed,
    status: status,
  );

  /// Unique ID.
  final String id;

  /// The original text; null after 90 days (R-PRIV-2). Never log it.
  final String? rawText;

  /// Who sent it.
  final AlertSource source;

  /// When the phone received it, in UTC.
  final DateTime receivedAt;

  /// What the parser read.
  final ParsedMessage parsed;

  /// Where it is in sorting.
  final AlertStatus status;

  @override
  List<Object?> get props => [id, rawText, source, receivedAt, parsed, status];
}
