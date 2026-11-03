import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payday_done_controller.freezed.dart';
part 'payday_done_controller.g.dart';

/// Screen 16 Payday complete.
@freezed
abstract class PaydayDoneState with _$PaydayDoneState {
  /// The summary; the goal fields are null without a goal.
  const factory PaydayDoneState({
    required Money moved,
    required Money livingLeft,
    required Money guiltFreeLeft,
    required Money? perDay,
    required int streak,
    required String? goalBucketId,
    required Money? goalBalance,
    required Money? goalTarget,
  }) = _PaydayDoneState;
}

/// Screen 16 for [paydayId].
@riverpod
class PaydayDoneController extends _$PaydayDoneController {
  @override
  Future<PaydayDoneState> build(String paydayId) async {
    final s = (await ref.watch(getPaydaySummaryProvider)(paydayId)).orThrow();
    return PaydayDoneState(
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
