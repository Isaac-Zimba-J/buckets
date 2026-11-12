// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rules_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 28, live.

@ProviderFor(RulesController)
final rulesControllerProvider = RulesControllerProvider._();

/// Screen 28, live.
final class RulesControllerProvider
    extends $StreamNotifierProvider<RulesController, RulesState> {
  /// Screen 28, live.
  RulesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rulesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rulesControllerHash();

  @$internal
  @override
  RulesController create() => RulesController();
}

String _$rulesControllerHash() => r'60d617dd2b50fc3043a2827973a5f19e05089032';

/// Screen 28, live.

abstract class _$RulesController extends $StreamNotifier<RulesState> {
  Stream<RulesState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<RulesState>, RulesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RulesState>, RulesState>,
              AsyncValue<RulesState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
