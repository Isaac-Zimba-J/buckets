// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 29 Help, live.

@ProviderFor(HelpController)
final helpControllerProvider = HelpControllerProvider._();

/// Screen 29 Help, live.
final class HelpControllerProvider
    extends $AsyncNotifierProvider<HelpController, HelpState> {
  /// Screen 29 Help, live.
  HelpControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'helpControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$helpControllerHash();

  @$internal
  @override
  HelpController create() => HelpController();
}

String _$helpControllerHash() => r'7c425443c7b3aff524f361d549a2c820757a306d';

/// Screen 29 Help, live.

abstract class _$HelpController extends $AsyncNotifier<HelpState> {
  FutureOr<HelpState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<HelpState>, HelpState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HelpState>, HelpState>,
              AsyncValue<HelpState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
