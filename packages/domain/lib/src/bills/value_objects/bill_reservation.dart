import 'package:buckets_core/buckets_core.dart';
import 'package:equatable/equatable.dart';

/// This cycle's reservation for one bill, from `BillReservations.monthly`.
final class BillReservation with Equatable {
  /// Reserves [amount] for [billId] in [bucketId], the bill's paying bucket.
  const new({
    required this.billId,
    required this.bucketId,
    required this.amount,
  });

  /// The bill.
  final String billId;

  /// The bucket that pays it.
  final String bucketId;

  /// The amount reserved this cycle.
  final Money amount;

  @override
  List<Object?> get props => [billId, bucketId, amount];
}
