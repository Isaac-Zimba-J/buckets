import 'package:buckets_domain/src/planning/entities/planned_purchase.dart';
import 'package:buckets_domain/src/planning/ports/planning_repository.dart';

/// Planned buys, live (screen 11).
final class WatchPlannedPurchases {
  /// Creates the use case.
  const WatchPlannedPurchases(this._planning);

  final PlanningRepository _planning;

  /// The planned buys, emitting on change.
  Stream<List<PlannedPurchase>> call() => _planning.watchPlanned();
}
