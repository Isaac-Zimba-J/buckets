// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 09 for [bucketId], live.

@ProviderFor(BucketDetailController)
final bucketDetailControllerProvider = BucketDetailControllerFamily._();

/// Screen 09 for [bucketId], live.
final class BucketDetailControllerProvider
    extends $StreamNotifierProvider<BucketDetailController, BucketDetailState> {
  /// Screen 09 for [bucketId], live.
  BucketDetailControllerProvider._({
    required BucketDetailControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'bucketDetailControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bucketDetailControllerHash();

  @override
  String toString() {
    return r'bucketDetailControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BucketDetailController create() => BucketDetailController();

  @override
  bool operator ==(Object other) {
    return other is BucketDetailControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bucketDetailControllerHash() =>
    r'1ba65f1802264af8a85bb6771a902033dba0d1b5';

/// Screen 09 for [bucketId], live.

final class BucketDetailControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          BucketDetailController,
          AsyncValue<BucketDetailState>,
          BucketDetailState,
          Stream<BucketDetailState>,
          String
        > {
  BucketDetailControllerFamily._()
    : super(
        retry: null,
        name: r'bucketDetailControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Screen 09 for [bucketId], live.

  BucketDetailControllerProvider call(String bucketId) =>
      BucketDetailControllerProvider._(argument: bucketId, from: this);

  @override
  String toString() => r'bucketDetailControllerProvider';
}

/// Screen 09 for [bucketId], live.

abstract class _$BucketDetailController
    extends $StreamNotifier<BucketDetailState> {
  late final _$args = ref.$arg as String;
  String get bucketId => _$args;

  Stream<BucketDetailState> build(String bucketId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<BucketDetailState>, BucketDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BucketDetailState>, BucketDetailState>,
              AsyncValue<BucketDetailState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
