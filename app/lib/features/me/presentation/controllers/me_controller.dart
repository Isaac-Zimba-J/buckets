import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/setup/presentation/controllers/setup_view_models.dart';
import 'package:buckets/features/shared/presentation/combine_latest.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'me_controller.freezed.dart';
part 'me_controller.g.dart';

/// The Me tab: incomes (for their splits) and the settings it changes.
@freezed
abstract class MeState with _$MeState {
  /// Creates the state; [errorCode] is the last change that failed.
  const factory MeState({
    required List<IncomeVm> incomes,
    required bool appLock,
    required int snoozeLimit,
    required int coolingOffHours,
    required Money coolingOffThreshold,
    required bool autoFile,
    String? errorCode,
  }) = _MeState;
}

/// The Me tab, live.
@riverpod
class MeController extends _$MeController {
  @override
  Stream<MeState> build() => combineLatest2(
    ref.watch(settingsRepositoryProvider).watch(),
    Stream.fromFuture(ref.watch(incomeRepositoryProvider).getAll()),
    (s, incomes) => MeState(
      incomes: incomes.orThrow().map(IncomeVm.of).toList(),
      appLock: s.appLock,
      snoozeLimit: s.snoozeLimit,
      coolingOffHours: s.coolingOffHours,
      coolingOffThreshold: s.coolingOffThreshold,
      autoFile: s.autoFile,
    ),
  );

  Future<bool> _done(Result<Object?> result) async {
    final current = state.value;
    if (current != null) {
      state = AsyncData(
        current.copyWith(
          errorCode: switch (result) {
            Err(:final failure) => failure.code,
            Ok() => null,
          },
        ),
      );
    }
    return result is Ok;
  }

  /// Turns the app lock on or off; the user unlocks first.
  Future<bool> setAppLock({required bool enabled}) async =>
      await _done(await ref.read(setAppLockProvider)(enabled: enabled));

  /// Snoozes per payday, 0–3 (R-PAY-4).
  Future<bool> setSnoozeLimit(int limit) async => await _done(
    await ref.read(saveNotificationPreferencesProvider)(snoozeLimit: limit),
  );

  /// Wish cooling-off: 24, 48 or 72 hours (R-PLAN-2).
  Future<bool> setCoolingOffHours(int hours) async => await _done(
    await ref.read(savePlanningPreferencesProvider)(coolingOffHours: hours),
  );

  /// When a payment suggests a wish (R-PLAN-1).
  Future<bool> setCoolingOffThreshold(Money amount) async => await _done(
    await ref.read(savePlanningPreferencesProvider)(
      coolingOffThreshold: amount,
    ),
  );

  /// File alerts that match a merchant rule without asking (R-SPEND-3).
  Future<bool> setAutoFile({required bool enabled}) async => await _done(
    await ref.read(savePlanningPreferencesProvider)(autoFile: enabled),
  );
}
