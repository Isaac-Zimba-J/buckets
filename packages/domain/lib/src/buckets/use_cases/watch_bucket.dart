import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/policies/overspend_policy.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/streams.dart';
import 'package:equatable/equatable.dart';

/// One bucket's detail (screen 09).
final class BucketDetail with Equatable {
  /// Creates the detail.
  const BucketDetail({
    required this.bucket,
    required this.balance,
    required this.leftToSpend,
    required this.overspentBy,
    required this.entries,
  });

  /// The bucket.
  final Bucket bucket;

  /// Its balance (R-LEDGER-2).
  final Money balance;

  /// Balance minus unpaid bill money (R-LEDGER-5).
  final Money leftToSpend;

  /// "K x over", or null (R-OVER-1).
  final Money? overspentBy;

  /// Its ledger entries, newest first.
  final List<LedgerEntry> entries;

  @override
  List<Object?> get props => [
    bucket,
    balance,
    leftToSpend,
    overspentBy,
    entries,
  ];
}

/// A bucket, live (screen 09).
final class WatchBucket {
  /// Creates the use case.
  const WatchBucket(this._buckets, this._ledger);

  final BucketRepository _buckets;
  final LedgerRepository _ledger;

  /// The detail for [bucketId], recomputed on every ledger change.
  Stream<Result<BucketDetail>> call(String bucketId) => recomputeOn(
    [_ledger.watchEntries(bucketId: bucketId)],
    () => attempt(() async {
      final entries = unwrap(await _ledger.getEntries(bucketId: bucketId));
      final balance = BalanceCalculator.balance(entries, bucketId);
      return BucketDetail(
        bucket: unwrap(await _buckets.get(bucketId)),
        balance: balance,
        leftToSpend: BalanceCalculator.leftToSpend(entries, bucketId),
        overspentBy: OverspendPolicy.overspentBy(balance),
        entries: entries.reversed.toList(),
      );
    }),
  );
}
