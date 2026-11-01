import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:buckets_domain/src/split/value_objects/allocation.dart';
import 'package:equatable/equatable.dart';

/// How an income is divided among buckets (DOMAIN §4).
final class SplitProfile with Equatable {
  const SplitProfile._({
    required this.id,
    required this.allocations,
    required this.holdUntilMonthEnd,
  });

  /// Validates and creates a profile. Allocations must add up to exactly
  /// 100% (R-SPLIT-1) and name each bucket once.
  static Result<SplitProfile> create({
    required String id,
    required List<Allocation> allocations,
    bool holdUntilMonthEnd = false,
  }) {
    final total = totalOf(allocations);
    final buckets = {for (final a in allocations) a.bucketId};
    return validated(
      [
        if (total > BasisPoints.max)
          ValidationFailure(
            'split.tooMuch',
            'The split is ${total - BasisPoints.max} bp over 100%.',
          ),
        if (total < BasisPoints.max)
          ValidationFailure(
            'split.tooLittle',
            'The split is ${BasisPoints.max - total} bp under 100%.',
          ),
        if (buckets.length != allocations.length)
          const ValidationFailure(
            'split.duplicateBucket',
            'A bucket is in the split twice.',
          ),
      ],
      () => SplitProfile._(
        id: id,
        allocations: List.unmodifiable(allocations),
        holdUntilMonthEnd: holdUntilMonthEnd,
      ),
    );
  }

  /// The sum of [allocations] in basis points, e.g. 11000 for 110%.
  static int totalOf(List<Allocation> allocations) =>
      allocations.fold(0, (sum, a) => sum + a.bp.value);

  /// Unique ID.
  final String id;

  /// Shares in display order.
  final List<Allocation> allocations;

  /// Whether to hold side-hustle money until month end (R-PAY-6).
  final bool holdUntilMonthEnd;

  @override
  List<Object?> get props => [id, allocations, holdUntilMonthEnd];
}
