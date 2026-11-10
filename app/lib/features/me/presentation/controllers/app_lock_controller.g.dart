// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_lock_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Whether the app shows its lock: at launch when the app lock is on, and
/// on resume after a minute away (`AppLockPolicy`).

@ProviderFor(AppLockController)
final appLockControllerProvider = AppLockControllerProvider._();

/// Whether the app shows its lock: at launch when the app lock is on, and
/// on resume after a minute away (`AppLockPolicy`).
final class AppLockControllerProvider
    extends $AsyncNotifierProvider<AppLockController, bool> {
  /// Whether the app shows its lock: at launch when the app lock is on, and
  /// on resume after a minute away (`AppLockPolicy`).
  AppLockControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLockControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLockControllerHash();

  @$internal
  @override
  AppLockController create() => AppLockController();
}

String _$appLockControllerHash() => r'2d63fc65a45e44c23174b72e83d82d61e0216800';

/// Whether the app shows its lock: at launch when the app lock is on, and
/// on resume after a minute away (`AppLockPolicy`).

abstract class _$AppLockController extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
