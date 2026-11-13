// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_pay_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 34 for [billId].

@ProviderFor(BillPayController)
final billPayControllerProvider = BillPayControllerFamily._();

/// Screen 34 for [billId].
final class BillPayControllerProvider
    extends $AsyncNotifierProvider<BillPayController, BillPayState> {
  /// Screen 34 for [billId].
  BillPayControllerProvider._({
    required BillPayControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'billPayControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$billPayControllerHash();

  @override
  String toString() {
    return r'billPayControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BillPayController create() => BillPayController();

  @override
  bool operator ==(Object other) {
    return other is BillPayControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$billPayControllerHash() => r'44dfe6358a219024256a282136f047f823fc8bf1';

/// Screen 34 for [billId].

final class BillPayControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BillPayController,
          AsyncValue<BillPayState>,
          BillPayState,
          FutureOr<BillPayState>,
          String
        > {
  BillPayControllerFamily._()
    : super(
        retry: null,
        name: r'billPayControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Screen 34 for [billId].

  BillPayControllerProvider call(String billId) =>
      BillPayControllerProvider._(argument: billId, from: this);

  @override
  String toString() => r'billPayControllerProvider';
}

/// Screen 34 for [billId].

abstract class _$BillPayController extends $AsyncNotifier<BillPayState> {
  late final _$args = ref.$arg as String;
  String get billId => _$args;

  FutureOr<BillPayState> build(String billId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BillPayState>, BillPayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BillPayState>, BillPayState>,
              AsyncValue<BillPayState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
