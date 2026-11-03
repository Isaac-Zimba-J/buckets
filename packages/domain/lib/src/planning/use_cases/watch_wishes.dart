import 'package:buckets_domain/src/planning/entities/wish.dart';
import 'package:buckets_domain/src/planning/ports/planning_repository.dart';

/// Wishes, live (screen 11).
final class WatchWishes {
  /// Creates the use case.
  const WatchWishes(this._planning);

  final PlanningRepository _planning;

  /// The wishes, emitting on change.
  Stream<List<Wish>> call() => _planning.watchWishes();
}
