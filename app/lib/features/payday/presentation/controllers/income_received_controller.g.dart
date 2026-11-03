// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_received_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 17 for the incoming alert [alertId].

@ProviderFor(IncomeReceivedController)
final incomeReceivedControllerProvider = IncomeReceivedControllerFamily._();

/// Screen 17 for the incoming alert [alertId].
final class IncomeReceivedControllerProvider
    extends
        $AsyncNotifierProvider<IncomeReceivedController, IncomeReceivedState> {
  /// Screen 17 for the incoming alert [alertId].
  IncomeReceivedControllerProvider._({
    required IncomeReceivedControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'incomeReceivedControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$incomeReceivedControllerHash();

  @override
  String toString() {
    return r'incomeReceivedControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IncomeReceivedController create() => IncomeReceivedController();

  @override
  bool operator ==(Object other) {
    return other is IncomeReceivedControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$incomeReceivedControllerHash() =>
    r'27e822466dcb7d106d4da61c65676efccc4d6fca';

/// Screen 17 for the incoming alert [alertId].

final class IncomeReceivedControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          IncomeReceivedController,
          AsyncValue<IncomeReceivedState>,
          IncomeReceivedState,
          FutureOr<IncomeReceivedState>,
          String
        > {
  IncomeReceivedControllerFamily._()
    : super(
        retry: null,
        name: r'incomeReceivedControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Screen 17 for the incoming alert [alertId].

  IncomeReceivedControllerProvider call(String alertId) =>
      IncomeReceivedControllerProvider._(argument: alertId, from: this);

  @override
  String toString() => r'incomeReceivedControllerProvider';
}

/// Screen 17 for the incoming alert [alertId].

abstract class _$IncomeReceivedController
    extends $AsyncNotifier<IncomeReceivedState> {
  late final _$args = ref.$arg as String;
  String get alertId => _$args;

  FutureOr<IncomeReceivedState> build(String alertId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<IncomeReceivedState>, IncomeReceivedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<IncomeReceivedState>, IncomeReceivedState>,
              AsyncValue<IncomeReceivedState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
