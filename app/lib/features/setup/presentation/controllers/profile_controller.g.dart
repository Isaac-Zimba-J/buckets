// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The profile form, live.

@ProviderFor(ProfileController)
final profileControllerProvider = ProfileControllerProvider._();

/// The profile form, live.
final class ProfileControllerProvider
    extends $AsyncNotifierProvider<ProfileController, ProfileFormState> {
  /// The profile form, live.
  ProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();
}

String _$profileControllerHash() => r'595ec81a2313d31808838df5130a62a836386c19';

/// The profile form, live.

abstract class _$ProfileController extends $AsyncNotifier<ProfileFormState> {
  FutureOr<ProfileFormState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ProfileFormState>, ProfileFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProfileFormState>, ProfileFormState>,
              AsyncValue<ProfileFormState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
