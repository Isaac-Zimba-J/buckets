import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/home/presentation/controllers/home_view_models.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bucket_detail_controller.freezed.dart';
part 'bucket_detail_controller.g.dart';

/// A bucket the user can move money into (screen 09 move sheet).
@freezed
abstract class DestinationVm with _$DestinationVm {
  /// Creates the view model.
  const factory DestinationVm({
    required String id,
    required String name,
    required BucketColor color,
  }) = _DestinationVm;
}

/// What the bucket's overflow menu can do (R-BUCKET-6, R-MOVE-1).
@freezed
abstract class BucketActionsVm with _$BucketActionsVm {
  /// Creates the view model.
  const factory BucketActionsVm({
    required bool isRemovable,
    required Money available,
    required List<DestinationVm> destinations,
  }) = _BucketActionsVm;
}

/// Screen 09 Bucket detail.
@freezed
sealed class BucketDetailState with _$BucketDetailState {
  /// Not overspent: the transactions list.
  const factory BucketDetailState.normal({
    required BucketTileVm bucket,
    required Money leftToSpend,
    required List<EntryRowVm> entries,
    required BucketActionsVm actions,
  }) = BucketNormal;

  /// "K x over" with the cover options in order (R-OVER-2) and the "split
  /// may be too tight" tip (R-OVER-4).
  const factory BucketDetailState.overspent({
    required BucketTileVm bucket,
    required Money overspentBy,
    required List<CoverOptionVm> options,
    required bool splitTooTight,
    required List<EntryRowVm> entries,
    required BucketActionsVm actions,
    @Default(false) bool covering,
  }) = BucketOverspent;
}

/// The result of asking to move money from screen 09.
sealed class MoveAttempt {
  const MoveAttempt();
}

/// The move happened.
final class MoveMade extends MoveAttempt {
  /// Creates the result.
  const MoveMade();
}

/// The move needs the user to confirm [warning] first.
final class MoveConfirmNeeded extends MoveAttempt {
  /// Creates the result.
  const MoveConfirmNeeded(this.warning);

  /// Why to confirm (R-MOVE-2).
  final MoveWarning warning;
}

/// The move failed; [code] is the validation code to show.
final class MoveFailed extends MoveAttempt {
  /// Creates the result.
  const MoveFailed(this.code);

  /// The failure code.
  final String code;
}

/// Screen 09 for [bucketId], live.
@riverpod
class BucketDetailController extends _$BucketDetailController {
  static const Set<BucketKind> _spending = {
    BucketKind.living,
    BucketKind.guiltFree,
  };

  @override
  Stream<BucketDetailState> build(String bucketId) =>
      ref.watch(watchBucketProvider)(bucketId).asyncMap(_state);

  Future<BucketDetailState> _state(Result<BucketDetail> result) async {
    final d = result.orThrow();
    final bucket = BucketTileVm(
      id: d.bucket.id,
      name: d.bucket.name,
      kind: d.bucket.kind,
      color: d.bucket.color,
      balance: d.balance,
    );
    final entries = d.entries.map(EntryRowVm.of).toList();
    final all = (await ref.read(bucketRepositoryProvider).getAll()).orThrow();
    final rawAvailable = _spending.contains(d.bucket.kind)
        ? d.leftToSpend
        : d.balance;
    final actions = BucketActionsVm(
      isRemovable: d.bucket.isRemovable,
      available: rawAvailable.isNegative ? Money.zero : rawAvailable,
      destinations: [
        for (final b in all)
          if (!b.archived && b.id != bucketId)
            DestinationVm(id: b.id, name: b.name, color: b.color),
      ],
    );
    if (d.overspentBy == null) {
      return BucketDetailState.normal(
        bucket: bucket,
        leftToSpend: d.leftToSpend,
        entries: entries,
        actions: actions,
      );
    }
    final (options, amount, tight) = (await ref.read(getCoverOptionsProvider)(
      bucketId,
    )).orThrow()!;
    final names = {for (final b in all) b.id: b.name};
    final balances = <String, Money>{
      for (final o in options.whereType<CoverFromBucket>())
        o.bucketId: (await ref.read(watchBucketProvider)(o.bucketId).first)
            .orThrow()
            .balance,
    };
    return BucketDetailState.overspent(
      bucket: bucket,
      overspentBy: amount,
      options: [
        for (final o in options)
          CoverOptionVm(
            fromBucketId: o.bucketId,
            fromName: names[o.bucketId] ?? '',
            nextCycle: o is CoverFromNextCycle,
            fromBalance: o is CoverFromNextCycle ? null : balances[o.bucketId],
          ),
      ],
      splitTooTight: tight,
      entries: entries,
      actions: actions,
    );
  }

  /// Covers the overspend with [option] (R-OVER-3).
  Future<bool> cover(CoverOptionVm option) async {
    final current = state.value;
    if (current is! BucketOverspent) return false;
    state = AsyncData(current.copyWith(covering: true));
    final result = await ref.read(coverOverspendProvider)(
      bucketId,
      option.nextCycle
          ? CoverFromNextCycle(option.fromBucketId)
          : CoverFromBucket(option.fromBucketId),
    );
    if (result is Err) state = AsyncData(current);
    return result is Ok;
  }

  /// Moves [amount] from this bucket to [toBucketId] (R-MOVE-1/2). Pass
  /// [confirmed] true after the user accepts a [MoveConfirmNeeded].
  Future<MoveAttempt> move({
    required String toBucketId,
    required Money amount,
    bool confirmed = false,
  }) async {
    final result = await ref.read(moveBetweenBucketsProvider)(
      fromBucketId: bucketId,
      toBucketId: toBucketId,
      amount: amount,
      confirmed: confirmed,
    );
    return switch (result) {
      Ok(value: MoveCompleted()) => const MoveMade(),
      Ok(value: MoveNeedsConfirm(:final warning)) => MoveConfirmNeeded(warning),
      Err(:final failure) => MoveFailed(failure.code),
    };
  }

  /// Records money the user already had in this bucket (R-LEDGER-6).
  Future<bool> setStartingBalance(Money amount) async => await ref.read(
    setStartingBalanceProvider,
  )(bucketId: bucketId, amount: amount) is Ok;

  /// Removes this bucket (R-BUCKET-6). [moveTo] receives any money left.
  /// Returns the failure code, or null on success.
  Future<String?> remove({String? moveTo}) async {
    final result = await ref.read(archiveBucketProvider)(
      bucketId: bucketId,
      moveTo: moveTo,
    );
    return switch (result) {
      Ok() => null,
      Err(:final failure) => failure.code,
    };
  }
}
