// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 03 Fixed bills.

@ProviderFor(BillsController)
final billsControllerProvider = BillsControllerProvider._();

/// Screen 03 Fixed bills.
final class BillsControllerProvider
    extends $AsyncNotifierProvider<BillsController, BillsState> {
  /// Screen 03 Fixed bills.
  BillsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billsControllerHash();

  @$internal
  @override
  BillsController create() => BillsController();
}

String _$billsControllerHash() => r'c99c86a4d5ae49fae957337d1baa3ca8f3709b9e';

/// Screen 03 Fixed bills.

abstract class _$BillsController extends $AsyncNotifier<BillsState> {
  FutureOr<BillsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BillsState>, BillsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BillsState>, BillsState>,
              AsyncValue<BillsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
