import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_view_models.freezed.dart';

/// A bucket tile (screens 07–08).
@freezed
abstract class BucketTileVm with _$BucketTileVm {
  /// Creates the tile.
  const factory BucketTileVm({
    required String id,
    required String name,
    required BucketKind kind,
    required BucketColor color,
    required Money balance,
  }) = _BucketTileVm;
}

/// A recent payment row (screen 08).
@freezed
abstract class TransactionRowVm with _$TransactionRowVm {
  /// Creates the row.
  const factory TransactionRowVm({
    required String id,
    required Money amount,
    required String category,
    required String bucketId,
    required DateTime occurredAt,
  }) = _TransactionRowVm;

  /// The row for [t].
  factory TransactionRowVm.of(Transaction t) => TransactionRowVm(
    id: t.id,
    amount: t.amount,
    category: t.category.name,
    bucketId: t.bucketId,
    occurredAt: t.occurredAt,
  );
}

/// The payday alarm banner on Home (screen 08).
@freezed
abstract class PaydayBannerVm with _$PaydayBannerVm {
  /// Creates the banner.
  const factory PaydayBannerVm({
    required String paydayId,
    required int pending,
    required Money pendingAmount,
  }) = _PaydayBannerVm;
}

/// A ledger line on bucket detail (screen 09).
@freezed
abstract class EntryRowVm with _$EntryRowVm {
  /// Creates the row.
  const factory EntryRowVm({
    required String id,
    required LedgerEntryKind kind,
    required Money amount,
    required DateTime occurredAt,
    required String? note,
  }) = _EntryRowVm;

  /// The row for [e].
  factory EntryRowVm.of(LedgerEntry e) => EntryRowVm(
    id: e.id,
    kind: e.kind,
    amount: e.amount,
    occurredAt: e.occurredAt,
    note: e.note,
  );
}

/// A way to cover an overspend (screen 09).
@freezed
abstract class CoverOptionVm with _$CoverOptionVm {
  /// Creates the option; [nextCycle] means "from next cycle's bucket".
  const factory CoverOptionVm({
    required String fromBucketId,
    required String fromName,
    required bool nextCycle,
  }) = _CoverOptionVm;
}

/// A goal card (screen 10).
@freezed
abstract class GoalCardVm with _$GoalCardVm {
  /// Creates the card. [etaMonths] is null when reached or in no split.
  const factory GoalCardVm({
    required String bucketId,
    required String name,
    required Money balance,
    required Money target,
    required Money monthlyContribution,
    required GoalEtaKind eta,
    required int? etaMonths,
    required LocalDate? etaDate,
    required bool celebrate,
  }) = _GoalCardVm;

  /// The card for [g].
  factory GoalCardVm.of(GoalView g) => GoalCardVm(
    bucketId: g.goal.bucketId,
    name: g.name,
    balance: g.balance,
    target: g.goal.target,
    monthlyContribution: g.monthlyContribution,
    eta: g.eta.kind,
    etaMonths: g.eta.kind == GoalEtaKind.inMonths ? g.eta.months : null,
    etaDate: g.eta.date,
    celebrate: g.celebrate,
  );
}

/// A planned buy row (screen 11).
@freezed
abstract class PlannedVm with _$PlannedVm {
  /// Creates the row.
  const factory PlannedVm({
    required String id,
    required String name,
    required Money amount,
    required String bucketId,
    required bool done,
  }) = _PlannedVm;

  /// The row for [p].
  factory PlannedVm.of(PlannedPurchase p) => PlannedVm(
    id: p.id,
    name: p.name,
    amount: p.amount,
    bucketId: p.bucketId,
    done: p.done,
  );
}

/// A wish row with its timer (screen 11).
@freezed
abstract class WishVm with _$WishVm {
  /// Creates the row; [timeLeft] is zero once cooling-off has ended.
  const factory WishVm({
    required String id,
    required String name,
    required Money amount,
    required String bucketId,
    required WishStatus status,
    required Duration timeLeft,
    required double progress,
  }) = _WishVm;

  /// The row for [w] at [now].
  factory WishVm.at(Wish w, DateTime now) {
    final total = w.endsAt.difference(w.createdAt);
    final left = w.endsAt.isAfter(now)
        ? w.endsAt.difference(now)
        : Duration.zero;
    return WishVm(
      id: w.id,
      name: w.name,
      amount: w.amount,
      bucketId: w.bucketId,
      status: w.status,
      timeLeft: left,
      progress: 1 - left.inSeconds / total.inSeconds,
    );
  }
}
