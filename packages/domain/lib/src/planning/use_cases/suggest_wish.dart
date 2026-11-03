import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/planning/policies/cooling_off_policy.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Whether to show "add it as a wish instead?" while logging (R-PLAN-1).
final class SuggestWish {
  /// Creates the use case.
  const SuggestWish(this._settings);

  final SettingsRepository _settings;

  /// True for an unplanned [amount] above the cooling-off threshold.
  Future<Result<bool>> call({required Money amount, bool isPlanned = false}) =>
      attempt(
        () async => CoolingOffPolicy.suggestWish(
          amount: amount,
          threshold: unwrap(await _settings.get()).coolingOffThreshold,
          isPlanned: isPlanned,
        ),
      );
}
