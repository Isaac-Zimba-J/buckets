import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/home/presentation/controllers/home_view_models.dart';
import 'package:buckets/features/shared/presentation/combine_latest.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'plan_controller.freezed.dart';
part 'plan_controller.g.dart';

/// Screen 11 Plan: planned buys and wishes. An empty list is that tab's
/// empty state.
@freezed
abstract class PlanState with _$PlanState {
  /// Both tabs; a wish with zero `timeLeft` has ended.
  const factory PlanState({
    required List<PlannedVm> planned,
    required List<WishVm> wishes,
    @Default(<String, String>{}) Map<String, String> bucketNames,
    String? errorCode,
  }) = _PlanState;
}

/// Screen 11 Plan, live.
@riverpod
class PlanController extends _$PlanController {
  @override
  Stream<PlanState> build() {
    final clock = ref.watch(clockProvider);
    return combineLatest3(
      ref.watch(watchPlannedPurchasesProvider)(),
      ref.watch(watchWishesProvider)(),
      ref.watch(bucketRepositoryProvider).watchAll(),
      (planned, wishes, buckets) => PlanState(
        bucketNames: {for (final b in buckets) b.id: b.name},
        planned: planned.map(PlannedVm.of).toList(),
        wishes: [
          for (final w in wishes)
            if (w.status == WishStatus.coolingOff ||
                w.status == WishStatus.approved)
              WishVm.at(w, clock.now()),
        ],
      ),
    );
  }

  Future<bool> _done(Result<Object?> result) async {
    if (result case Err(:final failure)) {
      final current = state.value;
      if (current != null) {
        state = AsyncData(current.copyWith(errorCode: failure.code));
      }
      return false;
    }
    // The streams refresh the state; no rebuild needed.
    return true;
  }

  /// Adds a planned buy.
  Future<bool> addPlanned({
    required String name,
    required Money amount,
    required String bucketId,
  }) async => await _done(
    await ref.read(addPlannedPurchaseProvider)(
      name: name,
      amount: amount,
      bucketId: bucketId,
    ),
  );

  /// Ticks or unticks a planned buy.
  Future<bool> toggle(String id) async =>
      await _done(await ref.read(togglePlannedPurchaseProvider)(id));

  /// Adds a wish that cools off.
  Future<bool> addWish({
    required String name,
    required Money amount,
    required String bucketId,
  }) async => await _done(
    await ref.read(addWishProvider)(
      name: name,
      amount: amount,
      bucketId: bucketId,
    ),
  );

  /// "Still want it" (only after the timer).
  Future<bool> approve(String wishId) async =>
      await _done(await ref.read(approveWishProvider)(wishId));

  /// "Drop it".
  Future<bool> drop(String wishId) async =>
      await _done(await ref.read(dropWishProvider)(wishId));
}
