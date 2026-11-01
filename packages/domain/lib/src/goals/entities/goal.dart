import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// A target for a bucket's balance (DOMAIN §13). Identified by its bucket.
final class Goal with Equatable {
  const Goal._({
    required this.bucketId,
    required this.target,
    required this.targetDate,
  });

  /// Validates and creates a goal.
  static Result<Goal> create({
    required String bucketId,
    required Money target,
    DateTime? targetDate,
  }) => validated(
    [requirePositive(target, 'target'), requireUtc(targetDate, 'targetDate')],
    () => Goal._(bucketId: bucketId, target: target, targetDate: targetDate),
  );

  /// The bucket that holds the savings.
  final String bucketId;

  /// The amount to reach.
  final Money target;

  /// Optional date to reach it by, in UTC.
  final DateTime? targetDate;

  @override
  List<Object?> get props => [bucketId, target, targetDate];
}
