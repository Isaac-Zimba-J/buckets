// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 26 Security, live.

@ProviderFor(SecurityController)
final securityControllerProvider = SecurityControllerProvider._();

/// Screen 26 Security, live.
final class SecurityControllerProvider
    extends $StreamNotifierProvider<SecurityController, SecurityState> {
  /// Screen 26 Security, live.
  SecurityControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'securityControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$securityControllerHash();

  @$internal
  @override
  SecurityController create() => SecurityController();
}

String _$securityControllerHash() =>
    r'4221cae1c4d2ae262a47f08f27eb94acbde617d0';

/// Screen 26 Security, live.

abstract class _$SecurityController extends $StreamNotifier<SecurityState> {
  Stream<SecurityState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SecurityState>, SecurityState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SecurityState>, SecurityState>,
              AsyncValue<SecurityState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
