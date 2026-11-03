import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/planning/entities/wish.dart';
import 'package:buckets_domain/src/planning/policies/cooling_off_policy.dart';
import 'package:buckets_domain/src/planning/ports/planning_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// "Still want it" once cooling off is over (screen 11).
final class ApproveWish {
  /// Creates the use case.
  const ApproveWish(this._planning, this._clock);

  final PlanningRepository _planning;
  final Clock _clock;

  /// The approved wish; fails while the timer is running.
  Future<Result<Wish>> call(String wishId) => attempt(() async {
    final wish = unwrap(
      CoolingOffPolicy.approve(
        unwrap(await _planning.getWish(wishId)),
        now: _clock.now(),
      ),
    );
    unwrap(await _planning.saveWish(wish));
    return wish;
  });
}
