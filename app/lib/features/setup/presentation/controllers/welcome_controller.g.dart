// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 01 Welcome: ready only. True once setup is complete, which the
/// router uses to skip setup.

@ProviderFor(WelcomeController)
final welcomeControllerProvider = WelcomeControllerProvider._();

/// Screen 01 Welcome: ready only. True once setup is complete, which the
/// router uses to skip setup.
final class WelcomeControllerProvider
    extends $AsyncNotifierProvider<WelcomeController, bool> {
  /// Screen 01 Welcome: ready only. True once setup is complete, which the
  /// router uses to skip setup.
  WelcomeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'welcomeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$welcomeControllerHash();

  @$internal
  @override
  WelcomeController create() => WelcomeController();
}

String _$welcomeControllerHash() => r'16ef6d2cbdf7b4b43cbea6fc89f6e9338cb1b17b';

/// Screen 01 Welcome: ready only. True once setup is complete, which the
/// router uses to skip setup.

abstract class _$WelcomeController extends $AsyncNotifier<bool> {
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
