import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/policies/overspend_policy.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Covers an overspent bucket with the chosen option (R-OVER-3).
final class CoverOverspend {
  /// Creates the use case.
  const CoverOverspend(this._ledger, this._ids, this._clock);

  final LedgerRepository _ledger;
  final IdGenerator _ids;
  final Clock _clock;

  /// The entries written for exactly the overspent amount.
  Future<Result<List<LedgerEntry>>> call(
    String bucketId,
    CoverOption option,
  ) => attempt(() async {
    final balance = BalanceCalculator.balance(
      unwrap(await _ledger.getEntries(bucketId: bucketId)),
      bucketId,
    );
    final amount = OverspendPolicy.overspentBy(balance);
    if (amount == null) {
      unwrap<void>(
        const Err(ConflictFailure('bucket.notOverspent', 'Nothing to cover.')),
      );
    }
    final entries = unwrap(
      OverspendPolicy.cover(
        option,
        overspentBucketId: bucketId,
        amount: amount!,
        ids: _ids,
        at: _clock.now(),
      ),
    );
    unwrap(await _ledger.append(entries));
    return entries;
  });
}
