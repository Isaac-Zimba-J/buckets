import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/value_objects/ledger_refs.dart';

/// Builds ledger entries for moves and corrections (DOMAIN §6).
abstract final class LedgerPolicy {
  /// The two entries of a move: `moveOut` −[amount] from [fromBucketId] and
  /// `moveIn` +[amount] to [toBucketId], to append together (R-LEDGER-3).
  static Result<List<LedgerEntry>> move({
    required IdGenerator ids,
    required String fromBucketId,
    required String toBucketId,
    required Money amount,
    required DateTime at,
    LedgerRefs refs = LedgerRefs.none,
    String? note,
  }) {
    if (!amount.isPositive) {
      return const Err(
        ValidationFailure(
          'amount.notPositive',
          'The amount must be above K 0.',
        ),
      );
    }
    if (fromBucketId == toBucketId) {
      return const Err(
        ValidationFailure('move.sameBucket', 'Choose a different bucket.'),
      );
    }
    return _all([
      LedgerEntry.create(
        id: ids.newId(),
        occurredAt: at,
        kind: LedgerEntryKind.moveOut,
        bucketId: fromBucketId,
        amount: -amount,
        counterBucketId: toBucketId,
        refs: refs,
        note: note,
      ),
      LedgerEntry.create(
        id: ids.newId(),
        occurredAt: at,
        kind: LedgerEntryKind.moveIn,
        bucketId: toBucketId,
        amount: amount,
        counterBucketId: fromBucketId,
        refs: refs,
        note: note,
      ),
    ]);
  }

  /// Reversal entries that cancel [targets] (R-LEDGER-1). Pass both halves
  /// of a move together. Fails with `ledger.alreadyReversed` if any target
  /// is already reversed in [existing].
  static Result<List<LedgerEntry>> reverse(
    List<LedgerEntry> targets, {
    required List<LedgerEntry> existing,
    required IdGenerator ids,
    required DateTime at,
  }) {
    final reversed = {for (final e in existing) e.reversesEntryId};
    if (targets.any((t) => reversed.contains(t.id))) {
      return const Err(
        ConflictFailure('ledger.alreadyReversed', 'This was already undone.'),
      );
    }
    return _all([
      for (final t in targets)
        LedgerEntry.create(
          id: ids.newId(),
          occurredAt: at,
          kind: LedgerEntryKind.reversal,
          bucketId: t.bucketId,
          amount: -t.amount,
          counterBucketId: t.counterBucketId,
          refs: t.refs,
          reversesEntryId: t.id,
        ),
    ]);
  }

  static Result<List<LedgerEntry>> _all(List<Result<LedgerEntry>> results) {
    final entries = <LedgerEntry>[];
    for (final result in results) {
      switch (result) {
        case Ok(:final value):
          entries.add(value);
        case Err(:final failure):
          return Err(failure);
      }
    }
    return Ok(entries);
  }
}
