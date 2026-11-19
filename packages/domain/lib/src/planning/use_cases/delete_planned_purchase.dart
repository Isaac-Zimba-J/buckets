import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/planning/ports/planning_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Deletes a planned buy.
final class DeletePlannedPurchase {
  /// Creates the use case.
  const new(this._planning);

  final PlanningRepository _planning;

  /// Deletes the planned buy with [plannedId].
  Future<Result<void>> call(String plannedId) => attempt(() async {
    unwrap(await _planning.deletePlanned(plannedId));
  });
}
