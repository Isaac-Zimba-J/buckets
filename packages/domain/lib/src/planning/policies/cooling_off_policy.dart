import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/planning/entities/planned_purchase.dart';
import 'package:buckets_domain/src/planning/entities/wish.dart';

/// Planned purchases and wishes (DOMAIN §14).
abstract final class CoolingOffPolicy {
  /// Whether to suggest adding an unplanned payment as a wish instead: it is
  /// above [threshold]. Only a suggestion; logging is never blocked
  /// (R-PLAN-1).
  static bool suggestWish({
    required Money amount,
    required Money threshold,
    required bool isPlanned,
  }) => !isPlanned && amount > threshold;

  /// A new wish that cools off for [coolingOffHours] from [now] (R-PLAN-2).
  static Result<Wish> newWish({
    required String id,
    required String name,
    required Money amount,
    required String bucketId,
    required DateTime now,
    required int coolingOffHours,
  }) => Wish.create(
    id: id,
    name: name,
    amount: amount,
    bucketId: bucketId,
    createdAt: now,
    endsAt: now.add(Duration(hours: coolingOffHours)),
  );

  /// Whether [wish]'s cooling-off has ended at [now].
  static bool isOver(Wish wish, DateTime now) => !now.isBefore(wish.endsAt);

  /// Still wanted after cooling off. Only once it is over.
  static Result<Wish> approve(Wish wish, {required DateTime now}) {
    if (_resolved(wish)) return _resolvedErr;
    if (!isOver(wish, now)) {
      return const Err(
        ValidationFailure(
          'wish.stillCoolingOff',
          'Give it until the timer ends.',
        ),
      );
    }
    return wish.withStatus(WishStatus.approved);
  }

  /// No longer wanted. Any time before it is resolved.
  static Result<Wish> drop(Wish wish) =>
      _resolved(wish) ? _resolvedErr : wish.withStatus(WishStatus.dropped);

  /// Bought, while cooling off or after approval.
  static Result<Wish> markBought(Wish wish) =>
      _resolved(wish) ? _resolvedErr : wish.withStatus(WishStatus.bought);

  static bool _resolved(Wish wish) =>
      wish.status == WishStatus.dropped || wish.status == WishStatus.bought;

  static const _resolvedErr = Err<Wish>(
    ConflictFailure('wish.resolved', 'This wish is already closed.'),
  );

  /// [planned] marked done and linked to [transactionId] (R-PLAN-3).
  static Result<PlannedPurchase> markPlannedDone(
    PlannedPurchase planned,
    String transactionId,
  ) => planned.withDone(done: true, transactionId: transactionId);

  /// Actual minus planned: positive when it cost more (R-PLAN-3).
  static Money difference(PlannedPurchase planned, {required Money actual}) =>
      actual - planned.amount;
}
