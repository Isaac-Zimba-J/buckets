import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/policies/ledger_policy.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Records money the user already had in a bucket before Buckets
/// (R-LEDGER-6). One `adjustment`, excluded from payday and cycle stats.
final class SetStartingBalance {
  /// Creates the use case.
  const new(this._ledger, this._ids, this._clock);

  final LedgerRepository _ledger;
  final IdGenerator _ids;
  final Clock _clock;

  /// Marks a ledger `adjustment` as a starting balance, so a later
  /// correction can find and reverse it. Internal, not shown to the user.
  static const noteMarker = 'starting-balance';

  /// Sets [bucketId]'s starting balance to [amount] (K 0 or more). Any live
  /// starting-balance adjustment for the bucket is reversed first, so there
  /// is at most one. Returns the entries appended.
  Future<Result<List<LedgerEntry>>> call({
    required String bucketId,
    required Money amount,
  }) => attempt(() async {
    if (amount.isNegative) {
      unwrap<void>(
        const Err(
          ValidationFailure('amount.negative', "This can't be below K 0."),
        ),
      );
    }
    final all = unwrap(await _ledger.getEntries());
    final reversed = {for (final e in all) e.reversesEntryId};
    final live = all
        .where(
          (e) =>
              e.bucketId == bucketId &&
              e.kind == LedgerEntryKind.adjustment &&
              e.note == noteMarker &&
              e.reversesEntryId == null &&
              !reversed.contains(e.id),
        )
        .toList();
    final now = _clock.now();
    final toAppend = <LedgerEntry>[
      ...unwrap(LedgerPolicy.reverse(live, existing: all, ids: _ids, at: now)),
      if (amount.isPositive)
        unwrap(
          LedgerEntry.create(
            id: _ids.newId(),
            occurredAt: now,
            kind: LedgerEntryKind.adjustment,
            bucketId: bucketId,
            amount: amount,
            note: noteMarker,
          ),
        ),
    ];
    if (toAppend.isNotEmpty) unwrap(await _ledger.append(toAppend));
    return toAppend;
  });
}
