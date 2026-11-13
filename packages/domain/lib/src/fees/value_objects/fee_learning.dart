import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:equatable/equatable.dart';

/// A message showed a fee that differs from a saved band; the user decides
/// (R-FEE-4).
final class FeeChange with Equatable {
  /// Creates the pending change.
  const new(this.band, this.newFee);

  /// The saved band the message disagrees with.
  final FeeBand band;

  /// What the message says the fee was.
  final Money newFee;

  @override
  List<Object?> get props => [band, newFee];
}

/// What learning from one message did (R-FEE-4).
final class FeeLearning with Equatable {
  /// Creates the outcome.
  const new({this.tariff, this.change});

  /// The tariff to save, when the message filled a gap or confirmed a band.
  final FeeTariff? tariff;

  /// A disagreement to put to the user; nothing is overwritten until they
  /// accept it.
  final FeeChange? change;

  @override
  List<Object?> get props => [tariff, change];
}
