import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.freezed.dart';
part 'settings_controller.g.dart';

/// Screen 25 Settings. Appearance (dark theme) is "Coming in 1.1".
@freezed
abstract class SettingsState with _$SettingsState {
  /// The current settings; [errorCode] is the last change that failed.
  const factory SettingsState({required Settings settings, String? errorCode}) =
      _SettingsState;
}

/// Screen 25 Settings, live.
@riverpod
class SettingsController extends _$SettingsController {
  @override
  Stream<SettingsState> build() =>
      ref.watch(watchSettingsProvider)().map((s) => SettingsState(settings: s));

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

  /// Snoozes per payday, 0–3 (R-PAY-4).
  Future<bool> setSnoozeLimit(int limit) async => await _done(
    await ref.read(saveNotificationPreferencesProvider)(snoozeLimit: limit),
  );

  /// Quiet hours (R-NOTIF-1); start and end must differ.
  Future<bool> setQuietHours(QuietHours hours) async => await _done(
    await ref.read(saveNotificationPreferencesProvider)(quietHours: hours),
  );

  /// The Sunday check-in time.
  Future<bool> setCheckIn({int? day, LocalTime? time}) async => await _done(
    await ref.read(saveNotificationPreferencesProvider)(
      checkInDay: day,
      checkInTime: time,
    ),
  );

  /// Whether bill reminders are scheduled.
  Future<bool> setBillReminders({required bool enabled}) async =>
      await _done(await ref.read(setBillRemindersProvider)(enabled: enabled));

  /// When an unplanned buy suggests a wish (R-PLAN-1).
  Future<bool> setCoolingOffThreshold(Money amount) async => await _done(
    await ref.read(savePlanningPreferencesProvider)(
      coolingOffThreshold: amount,
    ),
  );

  /// Wish cooling-off length: 24, 48 or 72 hours (R-PLAN-2).
  Future<bool> setCoolingOffHours(int hours) async => await _done(
    await ref.read(savePlanningPreferencesProvider)(coolingOffHours: hours),
  );

  /// File alerts matching a merchant rule without asking (R-SPEND-3).
  Future<bool> setAutoFile({required bool enabled}) async => await _done(
    await ref.read(savePlanningPreferencesProvider)(autoFile: enabled),
  );
}
