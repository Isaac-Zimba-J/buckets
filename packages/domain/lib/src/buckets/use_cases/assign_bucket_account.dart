import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Chooses where a bucket's money lives (screen 05).
final class AssignBucketAccount {
  /// Creates the use case.
  const new(this._buckets, this._accounts);

  final BucketRepository _buckets;
  final AccountRepository _accounts;

  /// The bucket now in [accountId]; fails if either doesn't exist.
  Future<Result<Bucket>> call(String bucketId, String accountId) =>
      attempt(() async {
        unwrap(await _accounts.get(accountId));
        final bucket = unwrap(await _buckets.get(bucketId))
            .withAccount(accountId);
        unwrap(await _buckets.saveAll([bucket]));
        return bucket;
      });
}
