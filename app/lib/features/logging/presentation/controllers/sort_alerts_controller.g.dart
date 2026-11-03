// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_alerts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 18, live over the unsorted alerts.

@ProviderFor(SortAlertsController)
final sortAlertsControllerProvider = SortAlertsControllerProvider._();

/// Screen 18, live over the unsorted alerts.
final class SortAlertsControllerProvider
    extends $StreamNotifierProvider<SortAlertsController, SortAlertsState> {
  /// Screen 18, live over the unsorted alerts.
  SortAlertsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortAlertsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortAlertsControllerHash();

  @$internal
  @override
  SortAlertsController create() => SortAlertsController();
}

String _$sortAlertsControllerHash() =>
    r'61a654ff5e4a2746bb04dad1db69037f3316e979';

/// Screen 18, live over the unsorted alerts.

abstract class _$SortAlertsController extends $StreamNotifier<SortAlertsState> {
  Stream<SortAlertsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SortAlertsState>, SortAlertsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SortAlertsState>, SortAlertsState>,
              AsyncValue<SortAlertsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
