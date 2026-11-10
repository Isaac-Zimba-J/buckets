import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payday_done_controller.freezed.dart';
part 'payday_done_controller.g.dart';

/// Screen 16 Payday complete.
@freezed
abstract class PaydayDoneState with _$PaydayDoneState {
  /// The summary; the goal fields are null without a goal. [allProven] is
  /// false when a transfer was self-reported; [goalProgress] is in basis
  /// points (10000 = there).
  const factory PaydayDoneState({
    required Money moved,
    required Money livingLeft,
    required Money guiltFreeLeft,
    required Money? perDay,
    required int streak,
    required String? goalBucketId,
    required Money? goalBalance,
    required Money? goalTarget,
    DateTime? startedAt,
    @Default(0) int transfers,
    @Default(true) bool allProven,
    String? goalName,
    int? goalProgress,
  }) = _PaydayDoneState;
}

/// Screen 16 for [paydayId].
@riverpod
class PaydayDoneController extends _$PaydayDoneController {
  @override
  Future<PaydayDoneState> build(String paydayId) async {
    final s = (await ref.watch(getPaydaySummaryProvider)(paydayId)).orThrow();
    final payday = (await ref.watch(paydayRepositoryProvider).get(paydayId))
        .orThrow();
    final goal = s.topGoal;
    final goalName = goal == null
        ? null
        : (await ref.watch(bucketRepositoryProvider).get(goal.bucketId))
              .orThrow()
              .name;
    return PaydayDoneState(
      startedAt: payday.startedAt,
      transfers: payday.transfers.length,
      allProven: payday.transfers.every(
        (t) => t.status == TransferStatus.proven,
      ),
      goalName: goalName,
      goalProgress: goal == null || !goal.target.isPositive
          ? null
          : (goal.balance.ngwee * 10000 ~/ goal.target.ngwee).clamp(0, 10000),
      moved: s.moved,
      livingLeft: s.livingLeft,
      guiltFreeLeft: s.guiltFreeLeft,
      perDay: s.perDay,
      streak: s.streak,
      goalBucketId: s.topGoal?.bucketId,
      goalBalance: s.topGoal?.balance,
      goalTarget: s.topGoal?.target,
    );
  }
}
