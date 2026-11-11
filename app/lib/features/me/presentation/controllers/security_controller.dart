import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/shared/presentation/combine_latest.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'security_controller.freezed.dart';
part 'security_controller.g.dart';

/// Screen 26 Security. App lock uses the phone's own screen lock (R-SEC-1);
/// when the phone has none, the toggle is disabled.
@freezed
abstract class SecurityState with _$SecurityState {
  /// The current security settings.
  const factory SecurityState({
    required bool appLock,
    required LockTimeout lockTimeout,
    required bool hideAmounts,
    required bool lockAvailable,
    String? errorCode,
  }) = _SecurityState;
}

/// Screen 26 Security, live.
@riverpod
class SecurityController extends _$SecurityController {
  @override
  Stream<SecurityState> build() => combineLatest2(
    ref.watch(watchSettingsProvider)(),
    Stream.fromFuture(ref.watch(appLockProvider).isAvailable()),
    (s, available) => SecurityState(
      appLock: s.appLock,
      lockTimeout: s.lockTimeout,
      hideAmounts: s.hideAmounts,
      lockAvailable: switch (available) {
        Ok(:final value) => value,
        Err() => false,
      },
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

  /// Turns the app lock on or off; the user unlocks first (R-SEC-1).
  Future<bool> setAppLock({required bool enabled}) async =>
      await _done(await ref.read(setAppLockProvider)(enabled: enabled));

  /// How long away before the app locks (R-SEC-2).
  Future<bool> setLockTimeout(LockTimeout timeout) async =>
      await _done(await ref.read(setLockTimeoutProvider)(timeout));

  /// Hide amounts on Home until tapped (R-SEC-4).
  Future<bool> setHideAmounts({required bool hidden}) async =>
      await _done(await ref.read(setHideAmountsProvider)(hidden: hidden));
}
