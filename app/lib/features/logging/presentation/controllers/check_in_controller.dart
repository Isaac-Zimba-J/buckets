import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'check_in_controller.freezed.dart';
part 'check_in_controller.g.dart';

/// Screen 22 Sunday check-in.
@freezed
abstract class CheckInState with _$CheckInState {
  /// The steps and where the user is. After counting, [gap] and [prompt]
  /// show the warning (missing) or the question (received); [summary] is
  /// set on the last step.
  const factory CheckInState({
    required List<CheckInStep> steps,
    required int stepIndex,
    required int unsorted,
    required Money expected,
    Money? gap,
    GapPrompt? prompt,
    WeekSummary? summary,
    String? errorCode,
  }) = _CheckInState;

  const CheckInState._();

  /// The current step.
  CheckInStep get step => steps[stepIndex];
}

/// Screen 22 Sunday check-in.
@riverpod
class CheckInController extends _$CheckInController {
  @override
  Future<CheckInState> build() async {
    final s = (await ref.watch(getCheckInStateProvider)()).orThrow();
    return CheckInState(
      steps: s.steps,
      stepIndex: 0,
      unsorted: s.unsorted,
      expected: s.expected,
    );
  }

  /// Goes to the next step; the summary step loads the week summary.
  Future<void> nextStep() async {
    final current = await future;
    if (current.stepIndex + 1 >= current.steps.length) return;
    final next = current.copyWith(stepIndex: current.stepIndex + 1);
    state = AsyncData(
      next.step == CheckInStep.summary
          ? next.copyWith(
              summary: (await ref.read(getWeekSummaryProvider)()).orThrow(),
            )
          : next,
    );
  }

  /// Records the counted cash (R-CASH-2).
  Future<void> count(Money counted) async {
    final current = await future;
    final result = await ref.read(countCashProvider)(counted);
    state = AsyncData(switch (result) {
      Ok(value: (final checkIn, final prompt)) => current.copyWith(
        gap: checkIn.gap,
        prompt: prompt,
        errorCode: null,
      ),
      Err(:final failure) => current.copyWith(errorCode: failure.code),
    });
  }

  /// Records missing cash as Untracked from Living (R-CASH-2).
  Future<bool> recordUntracked() async {
    final current = await future;
    final gap = current.gap;
    if (gap == null || !gap.isPositive) return false;
    final ok = await ref.read(recordUntrackedCashProvider)(gap) is Ok;
    if (ok) state = AsyncData(current.copyWith(prompt: GapPrompt.none));
    return ok;
  }

  /// "Did you receive cash?": into Living or kept as cash (R-CASH-3).
  Future<bool> recordReceived({required bool intoLiving}) async {
    final current = await future;
    final gap = current.gap;
    if (gap == null || !gap.isNegative) return false;
    final ok = await ref.read(recordReceivedCashProvider)(
      -gap,
      intoLiving: intoLiving,
    ) is Ok;
    if (ok) state = AsyncData(current.copyWith(prompt: GapPrompt.none));
    return ok;
  }
}
