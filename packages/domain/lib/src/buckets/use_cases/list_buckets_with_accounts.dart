import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/entities/account.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:equatable/equatable.dart';

/// An active bucket with the account its money lives in.
final class BucketWithAccount with Equatable {
  /// Creates a row.
  const new(this.bucket, this.account, {required this.warning});

  /// The bucket.
  final Bucket bucket;

  /// Its account, or null when it still needs choosing ("Choose" badge).
  final Account? account;

  /// A saving bucket sitting in the spending account (R-BUCKET-3): warn but
  /// allow.
  final bool warning;

  @override
  List<Object?> get props => [bucket, account, warning];
}

/// Buckets and where they live (screen 05).
final class ListBucketsWithAccounts {
  /// Creates the use case.
  const new(this._buckets, this._accounts);

  final BucketRepository _buckets;
  final AccountRepository _accounts;

  static const Set<BucketKind> _spendingKinds = {
    BucketKind.living,
    BucketKind.guiltFree,
  };

  /// Active buckets in order, with their accounts.
  Future<Result<List<BucketWithAccount>>> call() => attempt(() async {
    final accounts = {
      for (final a in unwrap(await _accounts.getAll())) a.id: a,
    };
    return [
      for (final b in unwrap(await _buckets.getAll()))
        // The Bills bucket follows the spending account; nothing to choose.
        if (!b.archived && b.kind != BucketKind.bills)
          BucketWithAccount(
            b,
            accounts[b.accountId],
            warning:
                !_spendingKinds.contains(b.kind) &&
                (accounts[b.accountId]?.isSpending ?? false),
          ),
    ];
  });
}
