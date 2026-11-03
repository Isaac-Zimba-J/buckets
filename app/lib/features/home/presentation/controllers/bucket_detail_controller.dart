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

/// Screen 09 Bucket detail.
@freezed
sealed class BucketDetailState with _$BucketDetailState {
  /// Not overspent: the transactions list.
  const factory BucketDetailState.normal({
    required BucketTileVm bucket,
    required Money leftToSpend,
    required List<EntryRowVm> entries,
  }) = BucketNormal;

  /// "K x over" with the cover options in order (R-OVER-2) and the "split
  /// may be too tight" tip (R-OVER-4).
  const factory BucketDetailState.overspent({
    required BucketTileVm bucket,
    required Money overspentBy,
    required List<CoverOptionVm> options,
    required bool splitTooTight,
    required List<EntryRowVm> entries,
    @Default(false) bool covering,
  }) = BucketOverspent;
}

/// Screen 09 for [bucketId], live.
@riverpod
class BucketDetailController extends _$BucketDetailController {
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
    if (d.overspentBy == null) {
      return BucketDetailState.normal(
        bucket: bucket,
        leftToSpend: d.leftToSpend,
        entries: entries,
      );
    }
    final (options, amount, tight) = (await ref.read(getCoverOptionsProvider)(
      bucketId,
    )).orThrow()!;
    final names = {
      for (final b
          in (await ref.read(bucketRepositoryProvider).getAll()).orThrow())
        b.id: b.name,
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
          ),
      ],
      splitTooTight: tight,
      entries: entries,
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
}
