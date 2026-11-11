// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_privacy_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Screen 27 Data & privacy, live.

@ProviderFor(DataPrivacyController)
final dataPrivacyControllerProvider = DataPrivacyControllerProvider._();

/// Screen 27 Data & privacy, live.
final class DataPrivacyControllerProvider
    extends $AsyncNotifierProvider<DataPrivacyController, DataPrivacyState> {
  /// Screen 27 Data & privacy, live.
  DataPrivacyControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataPrivacyControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataPrivacyControllerHash();

  @$internal
  @override
  DataPrivacyController create() => DataPrivacyController();
}

String _$dataPrivacyControllerHash() =>
    r'2a9d9c5a260de0b6362030c5abae2eedf0a5f26e';

/// Screen 27 Data & privacy, live.

abstract class _$DataPrivacyController
    extends $AsyncNotifier<DataPrivacyState> {
  FutureOr<DataPrivacyState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<DataPrivacyState>, DataPrivacyState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DataPrivacyState>, DataPrivacyState>,
              AsyncValue<DataPrivacyState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
