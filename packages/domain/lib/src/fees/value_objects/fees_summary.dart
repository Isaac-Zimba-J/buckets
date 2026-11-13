import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:equatable/equatable.dart';

/// The Fees page for one pay cycle (R-FEE-7, SCREENS 36).
final class FeesSummary with Equatable {
  /// Creates the summary.
  const new({
    required this.total,
    required this.byProvider,
    required this.byType,
    required this.missingCount,
    required this.percentOfMovedBp,
    required this.previousTotal,
  });

  /// All fees this cycle.
  final Money total;

  /// Fees by provider; fees with no known provider are left out.
  final Map<AlertSource, Money> byProvider;

  /// Fees by what they were for.
  final Map<FeeType, Money> byType;

  /// Fees whose amount is unknown and need review (R-FEE-2).
  final int missingCount;

  /// Fees as basis points of the money moved (10000 = 100%); 0 when nothing
  /// moved.
  final int percentOfMovedBp;

  /// The previous cycle's total; K 0 when there was no previous cycle.
  final Money previousTotal;

  @override
  List<Object?> get props => [
    total,
    byProvider,
    byType,
    missingCount,
    percentOfMovedBp,
    previousTotal,
  ];
}

/// A payday transfer's fee: estimated, or the actual one once proven
/// (R-FEE-5). [amount] is null when no rate covers the transfer.
final class TransferFee with Equatable {
  /// Creates the fee.
  const new(this.amount, {this.isActual = false});

  /// The fee, or null when unknown.
  final Money? amount;

  /// Whether it came from the proof message rather than the rates.
  final bool isActual;

  @override
  List<Object?> get props => [amount, isActual];
}

/// Fees on a payday (SCREENS 13).
final class PaydayFees with Equatable {
  /// Creates the fees.
  const new(this.perTransfer);

  /// The fee for each transfer, by transfer ID.
  final Map<String, TransferFee> perTransfer;

  /// The sum of every known fee.
  Money get total => perTransfer.values.fold(
    Money.zero,
    (sum, f) => sum + (f.amount ?? Money.zero),
  );

  @override
  List<Object?> get props => [perTransfer];
}
