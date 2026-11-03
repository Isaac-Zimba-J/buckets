import 'package:buckets_core/buckets_core.dart';
import 'package:equatable/equatable.dart';

/// One bucket's share of a split.
final class Allocation with Equatable {
  /// Gives [bucketId] the share [bp].
  const new(this.bucketId, this.bp);

  /// The bucket receiving the share.
  final String bucketId;

  /// The share in basis points.
  final BasisPoints bp;

  @override
  List<Object?> get props => [bucketId, bp];
}
