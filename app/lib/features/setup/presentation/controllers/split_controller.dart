import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/setup/presentation/controllers/setup_view_models.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'split_controller.freezed.dart';
part 'split_controller.g.dart';

/// Whether Continue is enabled on screen 04.
enum SplitStatus {
  /// Adds up to 100% (R-SPLIT-1).
  valid,

  /// Not 100%: Continue disabled, "110% · too much" caption.
  invalid,

  /// Bills are more than the income: error banner (R-SPLIT-2).
  billsExceedIncome,
}

/// Screen 04 Split what's left.
@freezed
abstract class SplitState with _$SplitState {
  /// The rows, their total and what the income splits into.
  const factory SplitState({
    required String profileId,
    required List<AllocationVm> rows,
    required int totalBasisPoints,
    required Money? amountToSplit,
    required SplitStatus status,
    @Default(false) bool saving,
    @Default(false) bool saved,
  }) = _SplitState;
}

/// Screen 04 for the income [incomeId].
@riverpod
class SplitController extends _$SplitController {
  late IncomeSource _income;
  late Money _bills;
  late Map<String, Bucket> _buckets;

  @override
  Future<SplitState> build(String incomeId) async {
    _income = (await ref.watch(incomeRepositoryProvider).get(incomeId))
        .orThrow();
    final profile =
        (await ref
                .watch(splitProfileRepositoryProvider)
                .get(_income.splitProfileId))
            .orThrow();
    _buckets = {
      for (final b
          in (await ref.watch(bucketRepositoryProvider).getAll()).orThrow())
        b.id: b,
    };
    _bills = (await ref.watch(getBillReservationsProvider)()).orThrow().$2;
    return _preview(profile.id, [
      for (final a in profile.allocations) (a.bucketId, a.bp.value),
    ]);
  }

  SplitState _preview(String profileId, List<(String, int)> shares) {
    final preview = ref.read(previewSplitProvider)(
      income: _income.expectedAmount ?? Money.zero,
      deductBillsFirst: _income.deductBillsFirst,
      billReservations: _bills,
      // Out-of-range input is clamped here; the total shows what's wrong.
      allocations: [
        for (final (id, bp) in shares)
          Allocation(id, BasisPoints(bp.clamp(0, BasisPoints.max))),
      ],
      livingBucketId: _buckets.values
          .where((b) => b.kind == BucketKind.living)
          .firstOrNull
          ?.id,
    );
    final byBucket = {for (final s in preview.shares) s.bucketId: s.amount};
    return SplitState(
      profileId: profileId,
      rows: [
        for (final (id, bp) in shares)
          AllocationVm(
            bucketId: id,
            name: _buckets[id]?.name ?? '',
            color: _buckets[id]?.color ?? BucketColor.goal,
            basisPoints: bp,
            share: byBucket[id],
          ),
      ],
      totalBasisPoints: preview.totalBasisPoints,
      amountToSplit: preview.amountToSplit,
      status: switch (preview.failure?.code) {
        null => SplitStatus.valid,
        'billsExceedIncome' => SplitStatus.billsExceedIncome,
        _ => SplitStatus.invalid,
      },
    );
  }

  /// Sets [bucketId]'s share to [basisPoints] and re-previews.
  void setShare(String bucketId, int basisPoints) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      _preview(current.profileId, [
        for (final r in current.rows)
          (r.bucketId, r.bucketId == bucketId ? basisPoints : r.basisPoints),
      ]),
    );
  }

  /// Saves the split; only possible while it is valid.
  Future<bool> save() async {
    final current = state.value;
    if (current == null || current.status != SplitStatus.valid) return false;
    state = AsyncData(current.copyWith(saving: true));
    final result = await ref.read(saveSplitProfileProvider)(
      id: current.profileId,
      allocations: [
        for (final r in current.rows)
          Allocation(r.bucketId, BasisPoints(r.basisPoints)),
      ],
    );
    state = AsyncData(current.copyWith(saved: result is Ok));
    return result is Ok;
  }
}
