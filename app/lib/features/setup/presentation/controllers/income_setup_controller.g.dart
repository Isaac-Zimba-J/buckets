// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_setup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 02 Income: list and add income sources.

@ProviderFor(IncomeSetupController)
final incomeSetupControllerProvider = IncomeSetupControllerProvider._();

/// Screen 02 Income: list and add income sources.
final class IncomeSetupControllerProvider
    extends $AsyncNotifierProvider<IncomeSetupController, IncomeSetupState> {
  /// Screen 02 Income: list and add income sources.
  IncomeSetupControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomeSetupControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomeSetupControllerHash();

  @$internal
  @override
  IncomeSetupController create() => IncomeSetupController();
}

String _$incomeSetupControllerHash() =>
    r'506117eb1d701add72cec015e278ee94a1e825b9';

/// Screen 02 Income: list and add income sources.

abstract class _$IncomeSetupController
    extends $AsyncNotifier<IncomeSetupState> {
  FutureOr<IncomeSetupState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<IncomeSetupState>, IncomeSetupState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<IncomeSetupState>, IncomeSetupState>,
              AsyncValue<IncomeSetupState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
