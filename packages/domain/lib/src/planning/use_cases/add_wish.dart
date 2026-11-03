import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/planning/entities/wish.dart';
import 'package:buckets_domain/src/planning/policies/cooling_off_policy.dart';
import 'package:buckets_domain/src/planning/ports/planning_repository.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Adds a wish that cools off (R-PLAN-2, screens 11 and 19).
final class AddWish {
  /// Creates the use case.
  const AddWish(this._planning, this._settings, this._ids, this._clock);

  final PlanningRepository _planning;
  final SettingsRepository _settings;
  final IdGenerator _ids;
  final Clock _clock;

  /// The wish, cooling off for the hours in settings.
  Future<Result<Wish>> call({
    required String name,
    required Money amount,
    required String bucketId,
  }) => attempt(() async {
    final wish = unwrap(
      CoolingOffPolicy.newWish(
        id: _ids.newId(),
        name: name,
        amount: amount,
        bucketId: bucketId,
        now: _clock.now(),
        coolingOffHours: unwrap(await _settings.get()).coolingOffHours,
      ),
    );
    unwrap(await _planning.saveWish(wish));
    return wish;
  });
}
