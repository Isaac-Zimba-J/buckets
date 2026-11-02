import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/entities/account.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/accounts/value_objects/match_key.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/validation.dart';

/// Adds or edits an account with its match keys (screen 05). Making it
/// the spending account clears that flag elsewhere (R-ACC-1).
final class SaveAccount {
  /// Creates the use case.
  const SaveAccount(this._accounts, this._ids);

  final AccountRepository _accounts;
  final IdGenerator _ids;

  /// The saved account; fails on a match key under 3 characters (R-ACC-3).
  Future<Result<Account>> call({
    required String name,
    required AccountKind kind,
    String? id,
    List<String> matchKeys = const [],
    bool isSpending = false,
  }) => attempt(() async {
    final keys = unwrap(collect(matchKeys.map(MatchKey.create)));
    final account = unwrap(
      Account.create(
        id: id ?? _ids.newId(),
        name: name,
        kind: kind,
        matchKeys: keys,
        isSpending: isSpending,
      ),
    );
    if (isSpending) {
      for (final other in unwrap(await _accounts.getAll())) {
        if (other.id == account.id || !other.isSpending) continue;
        unwrap(
          await _accounts.save(
            unwrap(
              Account.create(
                id: other.id,
                name: other.name,
                kind: other.kind,
                matchKeys: other.matchKeys,
              ),
            ),
          ),
        );
      }
    }
    unwrap(await _accounts.save(account));
    return account;
  });
}
