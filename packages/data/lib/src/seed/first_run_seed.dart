import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

/// Creates what every install starts with (DA-05): the default buckets
/// (R-BUCKET-1), the Cash in hand account (R-ACC-2) and default settings.
/// Safe to run on every start: it only adds what is missing.
final class FirstRunSeed {
  /// Creates the seed.
  const new({
    required this._accounts,
    required this._buckets,
    required this._settings,
    required this._ids,
  });

  final AccountRepository _accounts;
  final BucketRepository _buckets;
  final SettingsRepository _settings;
  final IdGenerator _ids;

  /// Bucket account before the user chooses one on screen 05 ("Choose").
  static const unassignedAccount = '';

  /// Adds anything missing; returns whether it added something.
  Future<Result<bool>> call() async {
    var added = false;
    switch (await _accounts.getAll()) {
      case Err(:final failure):
        return Err(failure);
      case Ok(value: final accounts)
          when !accounts.any((a) => a.kind == AccountKind.cash):
        if (await _accounts.save(Account.cashInHand(id: _ids.newId())) case Err(
          :final failure,
        )) {
          return Err(failure);
        }
        added = true;
      case Ok():
    }
    switch (await _buckets.getAll()) {
      case Err(:final failure):
        return Err(failure);
      case Ok(value: final buckets) when buckets.isEmpty:
        final defaults = Bucket.defaults(
          ids: _ids,
          spendingAccountId: unassignedAccount,
          savingsAccountId: unassignedAccount,
        );
        if (await _buckets.saveAll(defaults) case Err(:final failure)) {
          return Err(failure);
        }
        added = true;
      case Ok():
    }
    // Reading settings stores nothing; the repository returns the defaults
    // until the user saves (DA-03), so only a storage failure matters here.
    if (await _settings.get() case Err(:final failure)) return Err(failure);
    return Ok(added);
  }
}
