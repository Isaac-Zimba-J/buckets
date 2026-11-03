// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 22 Sunday check-in.

@ProviderFor(CheckInController)
final checkInControllerProvider = CheckInControllerProvider._();

/// Screen 22 Sunday check-in.
final class CheckInControllerProvider
    extends $AsyncNotifierProvider<CheckInController, CheckInState> {
  /// Screen 22 Sunday check-in.
  CheckInControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'checkInControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$checkInControllerHash();

  @$internal
  @override
  CheckInController create() => CheckInController();
}

String _$checkInControllerHash() => r'db563d47b303df7c54a3d39c78cbe1314576406a';

/// Screen 22 Sunday check-in.

abstract class _$CheckInController extends $AsyncNotifier<CheckInState> {
  FutureOr<CheckInState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CheckInState>, CheckInState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CheckInState>, CheckInState>,
              AsyncValue<CheckInState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
