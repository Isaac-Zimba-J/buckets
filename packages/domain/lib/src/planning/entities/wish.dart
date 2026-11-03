import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// Where a wish is in its cooling-off (DOMAIN §14).
enum WishStatus {
  /// Waiting for the cooling-off to end.
  coolingOff,

  /// Still wanted after cooling off.
  approved,

  /// No longer wanted.
  dropped,

  /// Bought.
  bought,
}

/// An unplanned purchase put on hold to cool off (DOMAIN §14).
final class Wish with Equatable {
  const new _({
    required this.id,
    required this.name,
    required this.amount,
    required this.bucketId,
    required this.createdAt,
    required this.endsAt,
    required this.status,
  });

  /// Validates and creates a wish; [endsAt] is after [createdAt].
  static Result<Wish> create({
    required String id,
    required String name,
    required Money amount,
    required String bucketId,
    required DateTime createdAt,
    required DateTime endsAt,
    WishStatus status = WishStatus.coolingOff,
  }) => validated(
    [
      requireText(name),
      requirePositive(amount),
      requireUtc(createdAt, 'createdAt'),
      requireUtc(endsAt, 'endsAt'),
      if (!endsAt.isAfter(createdAt))
        const ValidationFailure(
          'endsAt.notAfterCreated',
          'Cooling-off must end after it starts.',
        ),
    ],
    () => Wish._(
      id: id,
      name: name.trim(),
      amount: amount,
      bucketId: bucketId,
      createdAt: createdAt,
      endsAt: endsAt,
      status: status,
    ),
  );

  /// This wish with [status].
  Result<Wish> withStatus(WishStatus status) => create(
    id: id,
    name: name,
    amount: amount,
    bucketId: bucketId,
    createdAt: createdAt,
    endsAt: endsAt,
    status: status,
  );

  /// Unique ID.
  final String id;

  /// What it is.
  final String name;

  /// The price.
  final Money amount;

  /// The bucket that would pay.
  final String bucketId;

  /// When it was added, in UTC.
  final DateTime createdAt;

  /// When cooling-off ends, in UTC.
  final DateTime endsAt;

  /// Where it stands.
  final WishStatus status;

  @override
  List<Object?> get props => [
    id,
    name,
    amount,
    bucketId,
    createdAt,
    endsAt,
    status,
  ];
}
