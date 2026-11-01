import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/planning/entities/planned_purchase.dart';
import 'package:buckets_domain/src/planning/entities/wish.dart';

/// Stores planned purchases and wishes.
abstract interface class PlanningRepository {
  /// Inserts or replaces [purchase].
  Future<Result<void>> savePlanned(PlannedPurchase purchase);

  /// The wish with [id], or `NotFoundFailure`.
  Future<Result<Wish>> getWish(String id);

  /// Inserts or replaces [wish].
  Future<Result<void>> saveWish(Wish wish);

  /// Every planned purchase, emitting again on change.
  Stream<List<PlannedPurchase>> watchPlanned();

  /// Every wish, emitting again on change.
  Stream<List<Wish>> watchWishes();
}
