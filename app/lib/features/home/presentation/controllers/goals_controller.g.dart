// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 10 Goals, live.

@ProviderFor(GoalsController)
final goalsControllerProvider = GoalsControllerProvider._();

/// Screen 10 Goals, live.
final class GoalsControllerProvider
    extends $StreamNotifierProvider<GoalsController, GoalsState> {
  /// Screen 10 Goals, live.
  GoalsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalsControllerHash();

  @$internal
  @override
  GoalsController create() => GoalsController();
}

String _$goalsControllerHash() => r'ecfc56ee86547125440ac2f7dfee509cdc93d3ae';

/// Screen 10 Goals, live.

abstract class _$GoalsController extends $StreamNotifier<GoalsState> {
  Stream<GoalsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<GoalsState>, GoalsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GoalsState>, GoalsState>,
              AsyncValue<GoalsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
