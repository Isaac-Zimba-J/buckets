import 'package:equatable/equatable.dart';

/// The result of one proof check (R-PROOF-2).
sealed class CheckOutcome with Equatable {
  const CheckOutcome();
}

/// The check passed.
final class CheckPassed extends CheckOutcome {
  /// Creates a pass.
  const CheckPassed();

  @override
  List<Object?> get props => const [];
}

/// The check failed for [reason], a machine code such as `amountTooLow`.
final class CheckFailed extends CheckOutcome {
  /// Creates a failure.
  const CheckFailed(this.reason);

  /// Why it failed.
  final String reason;

  @override
  List<Object?> get props => [reason];
}

/// The field needed for the check was not parsed. Counts as failed.
final class CheckUnknown extends CheckOutcome {
  /// Creates an unknown outcome.
  const CheckUnknown();

  @override
  List<Object?> get props => const [];
}
