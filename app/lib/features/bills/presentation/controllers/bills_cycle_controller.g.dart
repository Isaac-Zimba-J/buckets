// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_cycle_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 33, live. Creates this cycle's occurrences on open (idempotent,
/// R-BILL-6) so the list is never behind payday.

@ProviderFor(BillsCycleController)
final billsCycleControllerProvider = BillsCycleControllerProvider._();

/// Screen 33, live. Creates this cycle's occurrences on open (idempotent,
/// R-BILL-6) so the list is never behind payday.
final class BillsCycleControllerProvider
    extends $StreamNotifierProvider<BillsCycleController, BillsCycleState> {
  /// Screen 33, live. Creates this cycle's occurrences on open (idempotent,
  /// R-BILL-6) so the list is never behind payday.
  BillsCycleControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'billsCycleControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$billsCycleControllerHash();

  @$internal
  @override
  BillsCycleController create() => BillsCycleController();
}

String _$billsCycleControllerHash() =>
    r'095593d31f9d524c9b248fd7ada7321d577d63f9';

/// Screen 33, live. Creates this cycle's occurrences on open (idempotent,
/// R-BILL-6) so the list is never behind payday.

abstract class _$BillsCycleController extends $StreamNotifier<BillsCycleState> {
  Stream<BillsCycleState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BillsCycleState>, BillsCycleState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BillsCycleState>, BillsCycleState>,
              AsyncValue<BillsCycleState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
