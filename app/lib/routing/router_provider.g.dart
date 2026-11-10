// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The screen widgets (tests override this with placeholders).

@ProviderFor(screenBuilder)
final screenBuilderProvider = ScreenBuilderProvider._();

/// The screen widgets (tests override this with placeholders).

final class ScreenBuilderProvider
    extends $FunctionalProvider<ScreenBuilder, ScreenBuilder, ScreenBuilder>
    with $Provider<ScreenBuilder> {
  /// The screen widgets (tests override this with placeholders).
  ScreenBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenBuilderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenBuilderHash();

  @$internal
  @override
  $ProviderElement<ScreenBuilder> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ScreenBuilder create(Ref ref) {
    return screenBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScreenBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScreenBuilder>(value),
    );
  }
}

String _$screenBuilderHash() => r'57f47c36ae1fd10fec69bc5d08cf523b79c10269';

/// Guards backed by the settings and alert stores.

@ProviderFor(routeGuards)
final routeGuardsProvider = RouteGuardsProvider._();

/// Guards backed by the settings and alert stores.

final class RouteGuardsProvider
    extends $FunctionalProvider<RouteGuards, RouteGuards, RouteGuards>
    with $Provider<RouteGuards> {
  /// Guards backed by the settings and alert stores.
  RouteGuardsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routeGuardsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routeGuardsHash();

  @$internal
  @override
  $ProviderElement<RouteGuards> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RouteGuards create(Ref ref) {
    return routeGuards(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RouteGuards value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RouteGuards>(value),
    );
  }
}

String _$routeGuardsHash() => r'11521e6307702469040a2b85a6f60727b4bc25c1';

/// The app's router; a tapped notification opens its deep link
/// (R-NOTIF-4), including the one that launched the app.

@ProviderFor(router)
final routerProvider = RouterProvider._();

/// The app's router; a tapped notification opens its deep link
/// (R-NOTIF-4), including the one that launched the app.

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// The app's router; a tapped notification opens its deep link
  /// (R-NOTIF-4), including the one that launched the app.
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'4bc6cf9a02d89d0e66767b003805df4918328f95';
