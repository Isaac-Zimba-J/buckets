// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_greeting_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The chosen greeting and name for the Home header, live.

@ProviderFor(homeGreeting)
final homeGreetingProvider = HomeGreetingProvider._();

/// The chosen greeting and name for the Home header, live.

final class HomeGreetingProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProfileSummary>,
          ProfileSummary,
          Stream<ProfileSummary>
        >
    with $FutureModifier<ProfileSummary>, $StreamProvider<ProfileSummary> {
  /// The chosen greeting and name for the Home header, live.
  HomeGreetingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeGreetingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeGreetingHash();

  @$internal
  @override
  $StreamProviderElement<ProfileSummary> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<ProfileSummary> create(Ref ref) {
    return homeGreeting(ref);
  }
}

String _$homeGreetingHash() => r'8e173bc7768d8df7a707e59c50dab69c71eaec56';
