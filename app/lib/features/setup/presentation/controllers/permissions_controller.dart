import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'permissions_controller.freezed.dart';
part 'permissions_controller.g.dart';

/// Screen 06 Alarms & alerts.
@freezed
abstract class PermissionsState with _$PermissionsState {
  /// Each permission's state; [denied] shows the inline warning with
  /// "Open settings".
  const factory PermissionsState({
    required Map<AppPermission, PermissionState> permissions,
    @Default(false) bool completing,
    @Default(false) bool completed,
    String? errorCode,
  }) = _PermissionsState;

  const PermissionsState._();

  /// Whether any permission needs the settings page.
  bool get denied =>
      permissions.values.any((s) => s != PermissionState.granted);
}

/// Screen 06 Alarms & alerts.
@riverpod
class PermissionsController extends _$PermissionsController {
  static const List<AppPermission> _shown = [
    AppPermission.notifications,
    AppPermission.exactAlarms,
    AppPermission.notificationAccess,
  ];

  @override
  Future<PermissionsState> build() async {
    final status = ref.watch(getPermissionStatusProvider);
    return PermissionsState(
      permissions: {for (final p in _shown) p: (await status(p)).orThrow()},
    );
  }

  /// Asks for [permission]; notification access opens settings instead.
  Future<void> request(AppPermission permission) async {
    if (permission == AppPermission.notificationAccess) {
      await ref.read(openNotificationAccessSettingsProvider)();
    } else if (permission == AppPermission.notifications) {
      await ref.read(requestNotificationPermissionProvider)();
    } else {
      await ref.read(permissionGatewayProvider).request(permission);
    }
    ref.invalidateSelf();
    await future;
  }

  /// Finishes setup (screen 06 → Home).
  Future<bool> complete() async {
    final current = await future;
    state = AsyncData(current.copyWith(completing: true, errorCode: null));
    final result = await ref.read(completeSetupProvider)();
    state = AsyncData(
      current.copyWith(
        completed: result is Ok,
        errorCode: result is Err ? (result as Err).failure.code : null,
      ),
    );
    return result is Ok;
  }
}
