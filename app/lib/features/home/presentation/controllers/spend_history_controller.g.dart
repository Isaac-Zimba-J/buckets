// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spend_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Spend history screen, live.

@ProviderFor(SpendHistoryController)
final spendHistoryControllerProvider = SpendHistoryControllerProvider._();

/// Spend history screen, live.
final class SpendHistoryControllerProvider
    extends $StreamNotifierProvider<SpendHistoryController, SpendHistory> {
  /// Spend history screen, live.
  SpendHistoryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spendHistoryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spendHistoryControllerHash();

  @$internal
  @override
  SpendHistoryController create() => SpendHistoryController();
}

String _$spendHistoryControllerHash() =>
    r'8fad60d4f5e401b99af7e255732cd586fb792cfc';

/// Spend history screen, live.

abstract class _$SpendHistoryController extends $StreamNotifier<SpendHistory> {
  Stream<SpendHistory> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SpendHistory>, SpendHistory>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SpendHistory>, SpendHistory>,
              AsyncValue<SpendHistory>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
