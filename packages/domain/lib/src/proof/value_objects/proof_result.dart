import 'package:buckets_domain/src/proof/value_objects/check_outcome.dart';
import 'package:equatable/equatable.dart';

/// The four checks of a transfer proof (R-PROOF-1).
final class ProofResult with Equatable {
  /// Creates a result from the four checks.
  const ProofResult({
    required this.amount,
    required this.account,
    required this.date,
    required this.reference,
  });

  /// Parsed amount is within K 1 of the transfer.
  final CheckOutcome amount;

  /// Counterparty matches the destination account.
  final CheckOutcome account;

  /// Message is from today or yesterday.
  final CheckOutcome date;

  /// Reference is present and unused.
  final CheckOutcome reference;

  /// The checks in display order.
  List<CheckOutcome> get checks => [amount, account, date, reference];

  /// Whether every check passed; unknown counts as failed (R-PROOF-2).
  bool get passed => checks.every((c) => c is CheckPassed);

  @override
  List<Object?> get props => checks;
}
