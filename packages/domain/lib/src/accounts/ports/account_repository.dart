import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/entities/account.dart';

/// Stores accounts. Fails with `StorageFailure` on storage errors.
abstract interface class AccountRepository {
  /// Every account.
  Future<Result<List<Account>>> getAll();

  /// The account with [id], or `NotFoundFailure`.
  Future<Result<Account>> get(String id);

  /// Inserts or replaces [account].
  Future<Result<void>> save(Account account);

  /// Every account, emitting again on change.
  Stream<List<Account>> watchAll();
}
