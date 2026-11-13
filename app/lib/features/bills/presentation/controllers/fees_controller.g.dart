// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fees_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 36, live.

@ProviderFor(FeesController)
final feesControllerProvider = FeesControllerProvider._();

/// Screen 36, live.
final class FeesControllerProvider
    extends $StreamNotifierProvider<FeesController, FeesState> {
  /// Screen 36, live.
  FeesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feesControllerHash();

  @$internal
  @override
  FeesController create() => FeesController();
}

String _$feesControllerHash() => r'4bc01d12082fbfe6fd3f1be8c49c307779e46c63';

/// Screen 36, live.

abstract class _$FeesController extends $StreamNotifier<FeesState> {
  Stream<FeesState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<FeesState>, FeesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FeesState>, FeesState>,
              AsyncValue<FeesState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
