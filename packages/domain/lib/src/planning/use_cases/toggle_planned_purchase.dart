import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/planning/entities/planned_purchase.dart';
import 'package:buckets_domain/src/planning/ports/planning_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Ticks or unticks a planned buy (screen 11, R-PLAN-3).
final class TogglePlannedPurchase {
  /// Creates the use case.
  const new(this._planning);

  final PlanningRepository _planning;

  /// The planned buy flipped; ticking links [transactionId] if given.
  Future<Result<PlannedPurchase>> call(
    String plannedId, {
    String? transactionId,
  }) => attempt(() async {
    final current = (await _planning.watchPlanned().first)
        .where((p) => p.id == plannedId)
        .firstOrNull;
    if (current == null) {
      unwrap<void>(
        const Err(
          NotFoundFailure('planned.notFound', 'Planned buy not found.'),
        ),
      );
    }
    final toggled = unwrap(
      current!.withDone(done: !current.done, transactionId: transactionId),
    );
    unwrap(await _planning.savePlanned(toggled));
    return toggled;
  });
}
