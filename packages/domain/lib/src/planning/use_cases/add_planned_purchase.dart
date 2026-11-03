import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/planning/entities/planned_purchase.dart';
import 'package:buckets_domain/src/planning/ports/planning_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Adds a planned buy (screen 11).
final class AddPlannedPurchase {
  /// Creates the use case.
  const AddPlannedPurchase(this._planning, this._ids);

  final PlanningRepository _planning;
  final IdGenerator _ids;

  /// The saved planned buy.
  Future<Result<PlannedPurchase>> call({
    required String name,
    required Money amount,
    required String bucketId,
    DateTime? due,
    Duration? repeatEvery,
  }) => attempt(() async {
    final p = unwrap(
      PlannedPurchase.create(
        id: _ids.newId(),
        name: name,
        amount: amount,
        bucketId: bucketId,
        due: due,
        repeatEvery: repeatEvery,
      ),
    );
    unwrap(await _planning.savePlanned(p));
    return p;
  });
}
