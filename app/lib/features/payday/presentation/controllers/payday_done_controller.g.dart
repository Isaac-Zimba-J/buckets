// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payday_done_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 16 for [paydayId].

@ProviderFor(PaydayDoneController)
final paydayDoneControllerProvider = PaydayDoneControllerFamily._();

/// Screen 16 for [paydayId].
final class PaydayDoneControllerProvider
    extends $AsyncNotifierProvider<PaydayDoneController, PaydayDoneState> {
  /// Screen 16 for [paydayId].
  PaydayDoneControllerProvider._({
    required PaydayDoneControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'paydayDoneControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paydayDoneControllerHash();

  @override
  String toString() {
    return r'paydayDoneControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PaydayDoneController create() => PaydayDoneController();

  @override
  bool operator ==(Object other) {
    return other is PaydayDoneControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paydayDoneControllerHash() =>
    r'c82a5ceccc179b011ceed4244926c507f39dfa87';

/// Screen 16 for [paydayId].

final class PaydayDoneControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          PaydayDoneController,
          AsyncValue<PaydayDoneState>,
          PaydayDoneState,
          FutureOr<PaydayDoneState>,
          String
        > {
  PaydayDoneControllerFamily._()
    : super(
        retry: null,
        name: r'paydayDoneControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Screen 16 for [paydayId].

  PaydayDoneControllerProvider call(String paydayId) =>
      PaydayDoneControllerProvider._(argument: paydayId, from: this);

  @override
  String toString() => r'paydayDoneControllerProvider';
}

/// Screen 16 for [paydayId].

abstract class _$PaydayDoneController extends $AsyncNotifier<PaydayDoneState> {
  late final _$args = ref.$arg as String;
  String get paydayId => _$args;

  FutureOr<PaydayDoneState> build(String paydayId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PaydayDoneState>, PaydayDoneState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PaydayDoneState>, PaydayDoneState>,
              AsyncValue<PaydayDoneState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
