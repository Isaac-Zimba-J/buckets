// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 11 Plan, live.

@ProviderFor(PlanController)
final planControllerProvider = PlanControllerProvider._();

/// Screen 11 Plan, live.
final class PlanControllerProvider
    extends $StreamNotifierProvider<PlanController, PlanState> {
  /// Screen 11 Plan, live.
  PlanControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'planControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$planControllerHash();

  @$internal
  @override
  PlanController create() => PlanController();
}

String _$planControllerHash() => r'32e6343abf64c5cf97b1ed4cce4d397340401c95';

/// Screen 11 Plan, live.

abstract class _$PlanController extends $StreamNotifier<PlanState> {
  Stream<PlanState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PlanState>, PlanState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PlanState>, PlanState>,
              AsyncValue<PlanState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
