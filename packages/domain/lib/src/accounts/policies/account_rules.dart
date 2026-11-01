import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/entities/account.dart';
import 'package:buckets_domain/src/shared/validation.dart';

/// Rules that hold across all of a user's accounts.
abstract final class AccountRules {
  /// Checks R-ACC-1 (exactly one spending account) and R-ACC-2 (a cash
  /// account exists).
  static Result<List<Account>> validate(List<Account> accounts) {
    final spending = accounts.where((a) => a.isSpending).length;
    return validated([
      if (spending == 0)
        const ValidationFailure(
          'accounts.noSpending',
          'Choose the account you spend from.',
        ),
      if (spending > 1)
        const ValidationFailure(
          'accounts.manySpending',
          'Only one account can be the spending account.',
        ),
      if (!accounts.any((a) => a.kind == AccountKind.cash))
        const ValidationFailure(
          'accounts.noCash',
          'The Cash in hand account is missing.',
        ),
    ], () => accounts);
  }
}
