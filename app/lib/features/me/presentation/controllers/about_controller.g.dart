// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 32 About: the app and device facts.

@ProviderFor(AboutController)
final aboutControllerProvider = AboutControllerProvider._();

/// Screen 32 About: the app and device facts.
final class AboutControllerProvider
    extends $AsyncNotifierProvider<AboutController, AppInfo> {
  /// Screen 32 About: the app and device facts.
  AboutControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aboutControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aboutControllerHash();

  @$internal
  @override
  AboutController create() => AboutController();
}

String _$aboutControllerHash() => r'31946e5e5ca110588e4caa8bc887d3fc3ea06efe';

/// Screen 32 About: the app and device facts.

abstract class _$AboutController extends $AsyncNotifier<AppInfo> {
  FutureOr<AppInfo> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppInfo>, AppInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppInfo>, AppInfo>,
              AsyncValue<AppInfo>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
