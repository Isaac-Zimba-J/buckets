import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// What a fee was charged for (R-FEE-1).
enum FeeType {
  /// Sending money.
  send,

  /// Cashing out.
  cashOut,

  /// Paying a bill.
  billPay,

  /// Paying a merchant.
  merchantPay,

  /// Anything else.
  other,
}

/// Where a fee amount came from (R-FEE-2).
enum FeeSource {
  /// Read from the confirmation message.
  message,

  /// Worked out from the fee rates.
  estimated,

  /// Not known; listed for review (R-FEE-7).
  missing,
}

/// Where a [FeeBand] came from (R-FEE-3).
enum FeeBandSource {
  /// Read from a payment message (R-FEE-4).
  learned,

  /// Typed in by the user; never overwritten without asking.
  user,
}

/// The fee for amounts from [minAmount] to [maxAmount], both inclusive
/// (R-FEE-3).
final class FeeBand with Equatable {
  const new _(
    this.minAmount,
    this.maxAmount,
    this.fee,
    this.source,
    this.observations,
  );

  /// Validates and creates a band. A [fee] of K 0 means "no fee".
  static Result<FeeBand> create({
    required Money minAmount,
    required Money maxAmount,
    required Money fee,
    required FeeBandSource source,
    int observations = 0,
  }) => validated([
    if (minAmount.isNegative || maxAmount < minAmount)
      const ValidationFailure(
        'feeBand.range',
        'The top of the range must not be below the bottom.',
      ),
    if (fee.isNegative)
      const ValidationFailure('fee.negative', 'A fee cannot be negative.'),
    requireRange(observations, 0, 1 << 30, 'observations'),
  ], () => FeeBand._(minAmount, maxAmount, fee, source, observations));

  /// Lowest amount the band covers.
  final Money minAmount;

  /// Highest amount the band covers.
  final Money maxAmount;

  /// The fee charged.
  final Money fee;

  /// Learned from a message, or entered by the user.
  final FeeBandSource source;

  /// How many messages confirmed this band.
  final int observations;

  /// Whether [amount] falls in the band, ends included.
  bool contains(Money amount) => minAmount <= amount && amount <= maxAmount;

  @override
  List<Object?> get props => [minAmount, maxAmount, fee, source, observations];
}

/// The fee rates for one provider and fee type (R-FEE-3). The app ships with
/// none; they are learned or entered.
final class FeeTariff with Equatable {
  const new _(this.provider, this.feeType, this.bands);

  /// Validates and creates a tariff; bands are kept ordered and must not
  /// overlap.
  static Result<FeeTariff> create({
    required AlertSource provider,
    required FeeType feeType,
    List<FeeBand> bands = const [],
  }) {
    final sorted = [...bands]
      ..sort((a, b) => a.minAmount.ngwee.compareTo(b.minAmount.ngwee));
    final overlap = [
      for (var i = 1; i < sorted.length; i++)
        if (sorted[i].minAmount <= sorted[i - 1].maxAmount) i,
    ].isNotEmpty;
    return validated([
      if (overlap)
        const ValidationFailure(
          'feeTariff.overlap',
          'Fee ranges must not overlap.',
        ),
    ], () => FeeTariff._(provider, feeType, List.unmodifiable(sorted)));
  }

  /// The mobile-money provider the rates belong to.
  final AlertSource provider;

  /// What the rates are for.
  final FeeType feeType;

  /// The bands, lowest first.
  final List<FeeBand> bands;

  @override
  List<Object?> get props => [provider, feeType, bands];
}
