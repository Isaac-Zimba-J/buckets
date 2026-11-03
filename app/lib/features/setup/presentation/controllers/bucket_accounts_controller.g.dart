// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_accounts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 05 Where buckets live.

@ProviderFor(BucketAccountsController)
final bucketAccountsControllerProvider = BucketAccountsControllerProvider._();

/// Screen 05 Where buckets live.
final class BucketAccountsControllerProvider
    extends
        $AsyncNotifierProvider<BucketAccountsController, BucketAccountsState> {
  /// Screen 05 Where buckets live.
  BucketAccountsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bucketAccountsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bucketAccountsControllerHash();

  @$internal
  @override
  BucketAccountsController create() => BucketAccountsController();
}

String _$bucketAccountsControllerHash() =>
    r'd696e1d7e7bf294b578dbd2998a564817fa6016f';

/// Screen 05 Where buckets live.

abstract class _$BucketAccountsController
    extends $AsyncNotifier<BucketAccountsState> {
  FutureOr<BucketAccountsState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<BucketAccountsState>, BucketAccountsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BucketAccountsState>, BucketAccountsState>,
              AsyncValue<BucketAccountsState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
