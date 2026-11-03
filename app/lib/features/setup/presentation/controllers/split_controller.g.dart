// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'split_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 04 for the income [incomeId].

@ProviderFor(SplitController)
final splitControllerProvider = SplitControllerFamily._();

/// Screen 04 for the income [incomeId].
final class SplitControllerProvider
    extends $AsyncNotifierProvider<SplitController, SplitState> {
  /// Screen 04 for the income [incomeId].
  SplitControllerProvider._({
    required SplitControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'splitControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$splitControllerHash();

  @override
  String toString() {
    return r'splitControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SplitController create() => SplitController();

  @override
  bool operator ==(Object other) {
    return other is SplitControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$splitControllerHash() => r'ebcc09aa8f5974157de596865888e87143d1afd0';

/// Screen 04 for the income [incomeId].

final class SplitControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          SplitController,
          AsyncValue<SplitState>,
          SplitState,
          FutureOr<SplitState>,
          String
        > {
  SplitControllerFamily._()
    : super(
        retry: null,
        name: r'splitControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Screen 04 for the income [incomeId].

  SplitControllerProvider call(String incomeId) =>
      SplitControllerProvider._(argument: incomeId, from: this);

  @override
  String toString() => r'splitControllerProvider';
}

/// Screen 04 for the income [incomeId].

abstract class _$SplitController extends $AsyncNotifier<SplitState> {
  late final _$args = ref.$arg as String;
  String get incomeId => _$args;

  FutureOr<SplitState> build(String incomeId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SplitState>, SplitState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SplitState>, SplitState>,
              AsyncValue<SplitState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
