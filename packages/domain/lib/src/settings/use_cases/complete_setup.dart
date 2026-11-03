import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/policies/account_rules.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/buckets/policies/bucket_rules.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/settings/entities/settings.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Finishes first-run setup (screen 06): checks the account and bucket
/// rules and that there is an income, then records the time.
final class CompleteSetup {
  /// Creates the use case.
  const new(
    this._accounts,
    this._buckets,
    this._incomes,
    this._settings,
    this._clock,
  );

  final AccountRepository _accounts;
  final BucketRepository _buckets;
  final IncomeRepository _incomes;
  final SettingsRepository _settings;
  final Clock _clock;

  /// The settings with `setupCompletedAt` set.
  Future<Result<Settings>> call() => attempt(() async {
    unwrap(AccountRules.validate(unwrap(await _accounts.getAll())));
    unwrap(BucketRules.validate(unwrap(await _buckets.getAll())));
    if (unwrap(await _incomes.getAll()).isEmpty) {
      unwrap<void>(
        const Err(
          ValidationFailure('setup.noIncome', 'Add the money you get first.'),
        ),
      );
    }
    final settings = unwrap(
      unwrap(await _settings.get()).copyWith(setupCompletedAt: _clock.now()),
    );
    unwrap(await _settings.save(settings));
    return settings;
  });
}
