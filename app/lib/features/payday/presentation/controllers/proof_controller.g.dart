// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proof_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screens 14–15 for [transferId] of [paydayId].

@ProviderFor(ProofController)
final proofControllerProvider = ProofControllerFamily._();

/// Screens 14–15 for [transferId] of [paydayId].
final class ProofControllerProvider
    extends $NotifierProvider<ProofController, ProofState> {
  /// Screens 14–15 for [transferId] of [paydayId].
  ProofControllerProvider._({
    required ProofControllerFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'proofControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$proofControllerHash();

  @override
  String toString() {
    return r'proofControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ProofController create() => ProofController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProofState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProofState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ProofControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$proofControllerHash() => r'72f56e8f587cd94a55550801a1ef40330f1815e1';

/// Screens 14–15 for [transferId] of [paydayId].

final class ProofControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ProofController,
          ProofState,
          ProofState,
          ProofState,
          (String, String)
        > {
  ProofControllerFamily._()
    : super(
        retry: null,
        name: r'proofControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Screens 14–15 for [transferId] of [paydayId].

  ProofControllerProvider call(String paydayId, String transferId) =>
      ProofControllerProvider._(argument: (paydayId, transferId), from: this);

  @override
  String toString() => r'proofControllerProvider';
}

/// Screens 14–15 for [transferId] of [paydayId].

abstract class _$ProofController extends $Notifier<ProofState> {
  late final _$args = ref.$arg as (String, String);
  String get paydayId => _$args.$1;
  String get transferId => _$args.$2;

  ProofState build(String paydayId, String transferId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ProofState, ProofState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProofState, ProofState>,
              ProofState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}
