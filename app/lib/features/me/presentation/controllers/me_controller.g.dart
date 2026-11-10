// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The Me tab, live.

@ProviderFor(MeController)
final meControllerProvider = MeControllerProvider._();

/// The Me tab, live.
final class MeControllerProvider
    extends $StreamNotifierProvider<MeController, MeState> {
  /// The Me tab, live.
  MeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'meControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$meControllerHash();

  @$internal
  @override
  MeController create() => MeController();
}

String _$meControllerHash() => r'1abfafd9b28825271a16d9ccf3344a9825187ad5';

/// The Me tab, live.

abstract class _$MeController extends $StreamNotifier<MeState> {
  Stream<MeState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<MeState>, MeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MeState>, MeState>,
              AsyncValue<MeState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
