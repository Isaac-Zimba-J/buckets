// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_rates_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 37 Fee rates, live: the saved tariffs; empty means no rates yet.

@ProviderFor(FeeRatesController)
final feeRatesControllerProvider = FeeRatesControllerProvider._();

/// Screen 37 Fee rates, live: the saved tariffs; empty means no rates yet.
final class FeeRatesControllerProvider
    extends $StreamNotifierProvider<FeeRatesController, List<FeeTariff>> {
  /// Screen 37 Fee rates, live: the saved tariffs; empty means no rates yet.
  FeeRatesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feeRatesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feeRatesControllerHash();

  @$internal
  @override
  FeeRatesController create() => FeeRatesController();
}

String _$feeRatesControllerHash() =>
    r'a6098dffd06ee2814be003b3afa7dd56c5822fca';

/// Screen 37 Fee rates, live: the saved tariffs; empty means no rates yet.

abstract class _$FeeRatesController extends $StreamNotifier<List<FeeTariff>> {
  Stream<List<FeeTariff>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<FeeTariff>>, List<FeeTariff>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FeeTariff>>, List<FeeTariff>>,
              AsyncValue<List<FeeTariff>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
