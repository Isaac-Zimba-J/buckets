import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/split/entities/split_profile.dart';
import 'package:buckets_domain/src/split/value_objects/allocation.dart';
import 'package:buckets_domain/src/split/value_objects/bucket_share.dart';

/// Turns an income into bucket shares (DOMAIN §4).
abstract final class SplitCalculator {
  /// The money left to split after bills (R-SPLIT-2). Fails with
  /// `billsExceedIncome` when [billReservations] are more than [income].
  static Result<Money> amountToSplit({
    required Money income,
    required bool deductBillsFirst,
    required Money billReservations,
  }) {
    if (!deductBillsFirst) return Ok(income);
    final left = income - billReservations;
    return left.isNegative
        ? const Err(
            ValidationFailure(
              'billsExceedIncome',
              'Your bills are more than this income. Review your bills.',
            ),
          )
        : Ok(left);
  }

  /// Splits [amount] by [profile] (R-SPLIT-3): each share is floored to the
  /// ngwee and the leftover goes to [livingBucketId] if it is in the
  /// profile, otherwise to the largest share (first on ties). The shares
  /// always add up to [amount]. Shares are in profile order.
  ///
  /// Throws an [ArgumentError] for a negative [amount]; check it with
  /// [amountToSplit] first.
  static List<BucketShare> split(
    Money amount,
    SplitProfile profile, {
    String? livingBucketId,
  }) {
    if (amount.isNegative) {
      throw ArgumentError.value(amount, 'amount', 'must not be negative');
    }
    final allocations = profile.allocations;
    final floors = [for (final a in allocations) a.bp.applyTo(amount)];
    final leftover = amount - floors.fold(Money.zero, (sum, m) => sum + m);
    final receiver = _leftoverReceiver(allocations, livingBucketId);
    return [
      for (final (i, a) in allocations.indexed)
        BucketShare(
          a.bucketId,
          i == receiver ? floors[i] + leftover : floors[i],
        ),
    ];
  }

  static int _leftoverReceiver(List<Allocation> allocations, String? living) {
    final livingIndex = allocations.indexWhere((a) => a.bucketId == living);
    if (livingIndex >= 0) return livingIndex;
    var largest = 0;
    for (var i = 1; i < allocations.length; i++) {
      if (allocations[i].bp.value > allocations[largest].bp.value) largest = i;
    }
    return largest;
  }
}
