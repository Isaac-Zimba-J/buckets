import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// A target for a bucket's balance (DOMAIN §13). Identified by its bucket.
final class Goal with Equatable {
  const new _({
    required this.bucketId,
    required this.target,
    required this.targetDate,
    required this.celebratedAt,
  });

  /// Validates and creates a goal.
  static Result<Goal> create({
    required String bucketId,
    required Money target,
    DateTime? targetDate,
    DateTime? celebratedAt,
  }) => validated(
    [
      requirePositive(target, 'target'),
      requireUtc(targetDate, 'targetDate'),
      requireUtc(celebratedAt, 'celebratedAt'),
    ],
    () => Goal._(
      bucketId: bucketId,
      target: target,
      targetDate: targetDate,
      celebratedAt: celebratedAt,
    ),
  );

  /// The bucket that holds the savings.
  final String bucketId;

  /// The amount to reach.
  final Money target;

  /// Optional date to reach it by, in UTC.
  final DateTime? targetDate;

  /// When reaching it was celebrated, so it happens once (R-GOAL-4).
  final DateTime? celebratedAt;

  /// This goal marked as celebrated at [at].
  Result<Goal> celebrated(DateTime at) => create(
    bucketId: bucketId,
    target: target,
    targetDate: targetDate,
    celebratedAt: at,
  );

  @override
  List<Object?> get props => [bucketId, target, targetDate, celebratedAt];
}
