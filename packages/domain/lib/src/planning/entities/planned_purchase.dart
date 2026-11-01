import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// Something the user plans to buy (DOMAIN §14).
final class PlannedPurchase with Equatable {
  const PlannedPurchase._({
    required this.id,
    required this.name,
    required this.amount,
    required this.bucketId,
    required this.due,
    required this.repeatEvery,
    required this.done,
    required this.transactionId,
  });

  /// Validates and creates a planned purchase.
  static Result<PlannedPurchase> create({
    required String id,
    required String name,
    required Money amount,
    required String bucketId,
    DateTime? due,
    Duration? repeatEvery,
    bool done = false,
    String? transactionId,
  }) => validated(
    [
      requireText(name),
      requirePositive(amount),
      requireUtc(due, 'due'),
      if (repeatEvery != null && repeatEvery <= Duration.zero)
        const ValidationFailure(
          'repeatEvery.notPositive',
          'Repeat must be longer than zero.',
        ),
    ],
    () => PlannedPurchase._(
      id: id,
      name: name.trim(),
      amount: amount,
      bucketId: bucketId,
      due: due,
      repeatEvery: repeatEvery,
      done: done,
      transactionId: transactionId,
    ),
  );

  /// Unique ID.
  final String id;

  /// What it is.
  final String name;

  /// The planned amount.
  final Money amount;

  /// The bucket that pays.
  final String bucketId;

  /// When it is due, in UTC.
  final DateTime? due;

  /// How often it repeats.
  final Duration? repeatEvery;

  /// Whether it has been bought.
  final bool done;

  /// The transaction that paid for it (R-PLAN-3).
  final String? transactionId;

  @override
  List<Object?> get props => [
    id,
    name,
    amount,
    bucketId,
    due,
    repeatEvery,
    done,
    transactionId,
  ];
}
