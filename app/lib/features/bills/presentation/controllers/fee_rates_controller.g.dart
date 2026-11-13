// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_rates_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 37, live.

@ProviderFor(FeeRatesController)
final feeRatesControllerProvider = FeeRatesControllerProvider._();

/// Screen 37, live.
final class FeeRatesControllerProvider
    extends $StreamNotifierProvider<FeeRatesController, FeeRatesState> {
  /// Screen 37, live.
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
    r'563b7ed6c7a28d7608472ed244332ef465ed92ef';

/// Screen 37, live.

abstract class _$FeeRatesController extends $StreamNotifier<FeeRatesState> {
  Stream<FeeRatesState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<FeeRatesState>, FeeRatesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FeeRatesState>, FeeRatesState>,
              AsyncValue<FeeRatesState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
