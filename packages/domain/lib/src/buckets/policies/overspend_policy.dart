import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/policies/ledger_policy.dart';
import 'package:buckets_domain/src/ledger/value_objects/ledger_refs.dart';
import 'package:buckets_domain/src/shared/date_window.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// A way to cover an overspent bucket (R-OVER-2).
sealed class CoverOption with Equatable {
  const CoverOption(this.bucketId);

  /// The bucket the money comes from.
  final String bucketId;

  @override
  List<Object?> get props => [bucketId];
}

/// Move money now from another bucket.
final class CoverFromBucket extends CoverOption {
  /// Covers from [bucketId].
  const CoverFromBucket(super.bucketId);
}

/// Take it from the same bucket's next allocation (a carry-over).
final class CoverFromNextCycle extends CoverOption {
  /// Covers from [bucketId]'s next cycle.
  const CoverFromNextCycle(super.bucketId);
}

/// A carry-over not yet settled by a payday.
typedef PendingCarryOver = ({String bucketId, Money amount});

/// What to do when a bucket goes below K 0 (DOMAIN §11).
abstract final class OverspendPolicy {
  /// How much [balance] is overspent, or null if it isn't (R-OVER-1).
  static Money? overspentBy(Money balance) =>
      balance.isNegative ? -balance : null;

  /// Cover options in order: Guilt-free (unless [overspent] is Guilt-free),
  /// Short-term, then next cycle's same bucket; only buckets with at least
  /// [amount] in [balances], and never a protected bucket (R-OVER-2,
  /// R-BUCKET-2). Guilt-free is only covered by its next cycle (R-OVER-5).
  static List<CoverOption> coverOptions({
    required Bucket overspent,
    required Money amount,
    required List<Bucket> buckets,
    required Map<String, Money> balances,
  }) {
    final next = CoverFromNextCycle(overspent.id);
    if (overspent.kind == BucketKind.guiltFree) return [next];
    CoverOption? from(BucketKind kind) {
      final source = buckets
          .where((b) => b.kind == kind && !b.archived && !b.isProtected)
          .where((b) => b.id != overspent.id)
          .firstOrNull;
      if (source == null) return null;
      return (balances[source.id] ?? Money.zero) >= amount
          ? CoverFromBucket(source.id)
          : null;
    }

    return [
      ?from(BucketKind.guiltFree),
      ?from(BucketKind.shortTerm),
      next,
    ];
  }

  /// Ledger entries that cover [amount] in [overspentBucketId] (R-OVER-3):
  /// a move from another bucket, or a carry-over adjustment that the next
  /// payday settles.
  static Result<List<LedgerEntry>> cover(
    CoverOption option, {
    required String overspentBucketId,
    required Money amount,
    required IdGenerator ids,
    required DateTime at,
  }) {
    switch (option) {
      case CoverFromBucket(:final bucketId):
        return LedgerPolicy.move(
          ids: ids,
          fromBucketId: bucketId,
          toBucketId: overspentBucketId,
          amount: amount,
          at: at,
        );
      case CoverFromNextCycle():
        if (!amount.isPositive) {
          return const Err(
            ValidationFailure(
              'amount.notPositive',
              'The amount must be above K 0.',
            ),
          );
        }
        final id = ids.newId();
        return collect([
          LedgerEntry.create(
            id: id,
            occurredAt: at,
            kind: LedgerEntryKind.adjustment,
            bucketId: overspentBucketId,
            amount: amount,
            refs: LedgerRefs(carryOverId: id),
          ),
        ]);
    }
  }

  /// Carry-overs whose entries don't yet net to zero, keyed by carry-over.
  static Map<String, PendingCarryOver> pendingCarryOvers(
    Iterable<LedgerEntry> entries,
  ) {
    final sums = <String, PendingCarryOver>{};
    for (final e in entries) {
      final id = e.refs.carryOverId;
      if (id == null) continue;
      final before = sums[id]?.amount ?? Money.zero;
      sums[id] = (bucketId: e.bucketId, amount: before + e.amount);
    }
    return {
      for (final MapEntry(:key, :value) in sums.entries)
        if (!value.amount.isZero) key: value,
    };
  }

  /// Adjustments for the next payday that take back every pending
  /// carry-over in [entries], reducing those buckets' allocations.
  static Result<List<LedgerEntry>> settleCarryOvers(
    Iterable<LedgerEntry> entries, {
    required String paydayId,
    required IdGenerator ids,
    required DateTime at,
  }) => collect([
    for (final MapEntry(key: carryOverId, value: pending) in pendingCarryOvers(
      entries,
    ).entries)
      LedgerEntry.create(
        id: ids.newId(),
        occurredAt: at,
        kind: LedgerEntryKind.adjustment,
        bucketId: pending.bucketId,
        amount: -pending.amount,
        refs: LedgerRefs(paydayId: paydayId, carryOverId: carryOverId),
      ),
  ]);

  /// Whether [bucketId]'s running balance was below K 0 at any point in
  /// [cycle], counting what it carried in.
  static bool wasOverspentIn(
    Iterable<LedgerEntry> entries,
    String bucketId,
    DateWindow cycle,
  ) {
    final own = entries.where((e) => e.bucketId == bucketId).toList()
      ..sort((a, b) => a.occurredAt.compareTo(b.occurredAt));
    var balance = Money.zero;
    for (final e in own.where((e) => e.occurredAt.isBefore(cycle.start))) {
      balance += e.amount;
    }
    if (balance.isNegative) return true;
    for (final e in own.where((e) => cycle.contains(e.occurredAt))) {
      balance += e.amount;
      if (balance.isNegative) return true;
    }
    return false;
  }

  /// Whether to show "your split may be too tight": overspent in 2 of the
  /// last 3 cycles of [overspentByCycle], oldest first (R-OVER-4).
  static bool suggestSplitReview(List<bool> overspentByCycle) {
    final lastThree = overspentByCycle.length <= 3
        ? overspentByCycle
        : overspentByCycle.sublist(overspentByCycle.length - 3);
    return lastThree.where((o) => o).length >= 2;
  }
}
