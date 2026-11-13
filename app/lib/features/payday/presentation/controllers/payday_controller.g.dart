// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payday_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 13 for [paydayId], live.

@ProviderFor(PaydayController)
final paydayControllerProvider = PaydayControllerFamily._();

/// Screen 13 for [paydayId], live.
final class PaydayControllerProvider
    extends $StreamNotifierProvider<PaydayController, PaydayState> {
  /// Screen 13 for [paydayId], live.
  PaydayControllerProvider._({
    required PaydayControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'paydayControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$paydayControllerHash();

  @override
  String toString() {
    return r'paydayControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PaydayController create() => PaydayController();

  @override
  bool operator ==(Object other) {
    return other is PaydayControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paydayControllerHash() => r'cbc00d3e5d5502a4ef1a349984fcfa04f39dc713';

/// Screen 13 for [paydayId], live.

final class PaydayControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          PaydayController,
          AsyncValue<PaydayState>,
          PaydayState,
          Stream<PaydayState>,
          String
        > {
  PaydayControllerFamily._()
    : super(
        retry: null,
        name: r'paydayControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Screen 13 for [paydayId], live.

  PaydayControllerProvider call(String paydayId) =>
      PaydayControllerProvider._(argument: paydayId, from: this);

  @override
  String toString() => r'paydayControllerProvider';
}

/// Screen 13 for [paydayId], live.

abstract class _$PaydayController extends $StreamNotifier<PaydayState> {
  late final _$args = ref.$arg as String;
  String get paydayId => _$args;

  Stream<PaydayState> build(String paydayId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PaydayState>, PaydayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PaydayState>, PaydayState>,
              AsyncValue<PaydayState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
