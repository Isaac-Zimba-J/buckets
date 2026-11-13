// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 35 for [billId], live.

@ProviderFor(BillHistoryController)
final billHistoryControllerProvider = BillHistoryControllerFamily._();

/// Screen 35 for [billId], live.
final class BillHistoryControllerProvider
    extends $StreamNotifierProvider<BillHistoryController, BillHistoryState> {
  /// Screen 35 for [billId], live.
  BillHistoryControllerProvider._({
    required BillHistoryControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'billHistoryControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$billHistoryControllerHash();

  @override
  String toString() {
    return r'billHistoryControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BillHistoryController create() => BillHistoryController();

  @override
  bool operator ==(Object other) {
    return other is BillHistoryControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$billHistoryControllerHash() =>
    r'b45c6835ac777b6f9191a70f1af08dbf9248ed4b';

/// Screen 35 for [billId], live.

final class BillHistoryControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BillHistoryController,
          AsyncValue<BillHistoryState>,
          BillHistoryState,
          Stream<BillHistoryState>,
          String
        > {
  BillHistoryControllerFamily._()
    : super(
        retry: null,
        name: r'billHistoryControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Screen 35 for [billId], live.

  BillHistoryControllerProvider call(String billId) =>
      BillHistoryControllerProvider._(argument: billId, from: this);

  @override
  String toString() => r'billHistoryControllerProvider';
}

/// Screen 35 for [billId], live.

abstract class _$BillHistoryController
    extends $StreamNotifier<BillHistoryState> {
  late final _$args = ref.$arg as String;
  String get billId => _$args;

  Stream<BillHistoryState> build(String billId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<BillHistoryState>, BillHistoryState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BillHistoryState>, BillHistoryState>,
              AsyncValue<BillHistoryState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
