import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/home/presentation/controllers/home_view_models.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'goals_controller.freezed.dart';
part 'goals_controller.g.dart';

/// Screen 10 Goals.
@freezed
sealed class GoalsState with _$GoalsState {
  /// "Pick something to save for".
  const factory GoalsState.empty({required Money totalSaved}) = GoalsEmpty;

  /// Goal cards and stats; a card with `celebrate` shows the toast once.
  const factory GoalsState.ready({
    required List<GoalCardVm> goals,
    required Money totalSaved,
    required Money savedThisCycle,
  }) = GoalsReady;
}

/// Screen 10 Goals, live.
@riverpod
class GoalsController extends _$GoalsController {
  @override
  Stream<GoalsState> build() =>
      ref.watch(watchGoalsProvider)().asyncMap((result) async {
        final goals = result.orThrow();
        final stats = (await ref.read(getSavingsStatsProvider)()).orThrow();
        return goals.isEmpty
            ? GoalsState.empty(totalSaved: stats.totalSaved)
            : GoalsState.ready(
                goals: goals.map(GoalCardVm.of).toList(),
                totalSaved: stats.totalSaved,
                savedThisCycle: stats.savedThisCycle,
              );
      });

  /// Creates a goal bucket in [accountId].
  Future<bool> create({
    required String name,
    required Money target,
    required String accountId,
    DateTime? targetDate,
  }) async => await ref.read(createGoalProvider)(
    name: name,
    target: target,
    accountId: accountId,
    targetDate: targetDate,
  ) is Ok;

  /// Records that [bucketId]'s celebration was shown (R-GOAL-4).
  Future<void> celebrated(String bucketId) async {
    final goals = ref.read(goalRepositoryProvider);
    final goal = (await goals.get(bucketId)).orThrow();
    if (goal == null) return;
    final done = goal.celebrated(ref.read(clockProvider).now()).orThrow();
    await goals.save(done);
  }
}
