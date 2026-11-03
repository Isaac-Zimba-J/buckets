import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/planning/entities/wish.dart';
import 'package:buckets_domain/src/planning/policies/cooling_off_policy.dart';
import 'package:buckets_domain/src/planning/ports/planning_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// "Drop it" (screen 11).
final class DropWish {
  /// Creates the use case.
  const new(this._planning);

  final PlanningRepository _planning;

  /// The dropped wish.
  Future<Result<Wish>> call(String wishId) => attempt(() async {
    final wish = unwrap(
      CoolingOffPolicy.drop(unwrap(await _planning.getWish(wishId))),
    );
    unwrap(await _planning.saveWish(wish));
    return wish;
  });
}
