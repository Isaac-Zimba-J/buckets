import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/checkin/policies/cash_reconciler.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// "Did you receive cash?": adds extra cash to Living or keeps it as Cash
/// in hand (R-CASH-3).
final class RecordReceivedCash {
  /// Creates the use case.
  const new(this._buckets, this._ledger, this._ids, this._clock);

  final BucketRepository _buckets;
  final LedgerRepository _ledger;
  final IdGenerator _ids;
  final Clock _clock;

  /// Records [extra] (counted − expected, above K 0).
  Future<Result<void>> call(Money extra, {required bool intoLiving}) =>
      attempt(() async {
        final living = intoLiving
            ? unwrap(await _buckets.getAll())
                  .firstWhere((b) => b.kind == BucketKind.living)
                  .id
            : null;
        final entry = unwrap(
          CashReconciler.recordReceived(
            extra: extra,
            intoLivingBucketId: living,
            ids: _ids,
            at: _clock.now(),
          ),
        );
        if (entry != null) unwrap(await _ledger.append([entry]));
      });
}
