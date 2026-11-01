import 'package:buckets_core/buckets_core.dart';
import 'package:equatable/equatable.dart';

/// The money one bucket gets from a split.
final class BucketShare with Equatable {
  /// Gives [amount] to [bucketId].
  const BucketShare(this.bucketId, this.amount);

  /// The bucket receiving the money.
  final String bucketId;

  /// Its share.
  final Money amount;

  @override
  List<Object?> get props => [bucketId, amount];
}
