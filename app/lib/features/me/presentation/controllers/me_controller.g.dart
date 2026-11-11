// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 24 Me, live.

@ProviderFor(MeController)
final meControllerProvider = MeControllerProvider._();

/// Screen 24 Me, live.
final class MeControllerProvider
    extends $StreamNotifierProvider<MeController, MeState> {
  /// Screen 24 Me, live.
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

String _$meControllerHash() => r'b67c16741cdb21b19b161b11607f6efe5eebb88b';

/// Screen 24 Me, live.

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
