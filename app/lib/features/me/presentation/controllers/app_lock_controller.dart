import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_lock_controller.g.dart';

/// Whether the app shows its lock: at launch when the app lock is on, and
/// on resume after a minute away (`AppLockPolicy`).
@Riverpod(keepAlive: true)
class AppLockController extends _$AppLockController {
  DateTime? _backgroundedAt;

  @override
  Future<bool> build() async {
    final settings = (await ref.watch(settingsRepositoryProvider).get())
        .orThrow();
    return AppLockPolicy.shouldLock(
      enabled: settings.appLock,
      backgroundedAt: null,
      now: ref.read(clockProvider).now(),
      timeout: settings.lockTimeout,
    );
  }

  /// The app went to the background.
  void backgrounded() => _backgroundedAt = ref.read(clockProvider).now();

  /// The app came back; locks when it was away long enough.
  Future<void> resumed() async {
    final away = _backgroundedAt;
    _backgroundedAt = null;
    if (away == null || (state.value ?? false)) return;
    final settings = switch (await ref.read(settingsRepositoryProvider).get()) {
      Ok(:final value) => value,
      Err() => null,
    };
    final lock = AppLockPolicy.shouldLock(
      enabled: settings?.appLock ?? false,
      backgroundedAt: away,
      now: ref.read(clockProvider).now(),
      timeout: settings?.lockTimeout ?? LockTimeout.oneMinute,
    );
    if (lock) state = const AsyncData(true);
  }

  /// Asks to unlock; true when the app is open again.
  Future<bool> unlock() async {
    final ok = switch (await ref.read(unlockAppProvider)()) {
      Ok(:final value) => value,
      Err() => false,
    };
    if (ok) state = const AsyncData(false);
    return ok;
  }
}
