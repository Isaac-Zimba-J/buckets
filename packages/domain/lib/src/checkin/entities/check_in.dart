import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// A weekly cash count (DOMAIN §15).
final class CheckIn with Equatable {
  const CheckIn._({
    required this.id,
    required this.countedAt,
    required this.expectedCash,
    required this.countedCash,
  });

  /// Validates and creates a check-in.
  static Result<CheckIn> create({
    required String id,
    required DateTime countedAt,
    required Money expectedCash,
    required Money countedCash,
  }) => validated(
    [
      requireUtc(countedAt, 'countedAt'),
      if (countedCash.isNegative)
        const ValidationFailure(
          'countedCash.negative',
          'Counted cash cannot be below K 0.',
        ),
    ],
    () => CheckIn._(
      id: id,
      countedAt: countedAt,
      expectedCash: expectedCash,
      countedCash: countedCash,
    ),
  );

  /// Unique ID.
  final String id;

  /// When the cash was counted, in UTC.
  final DateTime countedAt;

  /// Cash the app expected (R-CASH-1).
  final Money expectedCash;

  /// Cash the user counted.
  final Money countedCash;

  /// Expected minus counted; positive means cash is missing (R-CASH-2).
  Money get gap => expectedCash - countedCash;

  @override
  List<Object?> get props => [id, countedAt, expectedCash, countedCash];
}
