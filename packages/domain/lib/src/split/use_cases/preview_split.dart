import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/split/entities/split_profile.dart';
import 'package:buckets_domain/src/split/policies/split_calculator.dart';
import 'package:buckets_domain/src/split/value_objects/allocation.dart';
import 'package:buckets_domain/src/split/value_objects/bucket_share.dart';
import 'package:equatable/equatable.dart';

/// What the split screen shows while editing (screen 04).
final class SplitPreview with Equatable {
  /// Creates a preview.
  const SplitPreview({
    required this.totalBasisPoints,
    required this.amountToSplit,
    required this.shares,
    required this.failure,
  });

  /// The allocations' total, e.g. 11000 for "110% · too much".
  final int totalBasisPoints;

  /// What is left after bills, when it isn't negative.
  final Money? amountToSplit;

  /// Each bucket's share; empty while the split is invalid.
  final List<BucketShare> shares;

  /// Why Continue is disabled (`split.tooMuch`, `billsExceedIncome`, …).
  final Failure? failure;

  @override
  List<Object?> get props => [totalBasisPoints, amountToSplit, shares, failure];
}

/// Previews a split as the user edits it (R-SPLIT-1…3).
final class PreviewSplit {
  /// Creates the use case.
  const PreviewSplit();

  /// The preview of [allocations] for [income] after [billReservations].
  SplitPreview call({
    required Money income,
    required bool deductBillsFirst,
    required Money billReservations,
    required List<Allocation> allocations,
    String? livingBucketId,
  }) {
    final total = SplitProfile.totalOf(allocations);
    final toSplit = SplitCalculator.amountToSplit(
      income: income,
      deductBillsFirst: deductBillsFirst,
      billReservations: billReservations,
    );
    final profile = SplitProfile.create(
      id: 'preview',
      allocations: allocations,
    );
    return switch ((toSplit, profile)) {
      (Err(:final failure), _) || (_, Err(:final failure)) => SplitPreview(
        totalBasisPoints: total,
        amountToSplit: toSplit is Ok<Money> ? toSplit.value : null,
        shares: const [],
        failure: failure,
      ),
      (Ok(value: final amount), Ok(value: final p)) => SplitPreview(
        totalBasisPoints: total,
        amountToSplit: amount,
        shares: SplitCalculator.split(
          amount,
          p,
          livingBucketId: livingBucketId,
        ),
        failure: null,
      ),
    };
  }
}
