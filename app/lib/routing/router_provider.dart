import 'dart:async';

import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/routing/app_router.dart';
import 'package:buckets/routing/app_screens.dart';
import 'package:buckets/routing/deep_links.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

/// The screen widgets (tests override this with placeholders).
@Riverpod(keepAlive: true)
ScreenBuilder screenBuilder(Ref ref) => appScreen;

/// Guards backed by the settings and alert stores.
@Riverpod(keepAlive: true)
RouteGuards routeGuards(Ref ref) => RouteGuards(
  isSetUp: () async => switch (await ref.read(getSetupStatusProvider)()) {
    Ok(:final value) => value,
    Err() => false,
  },
  isIncomeAlert: (id) async =>
      switch (await ref.read(alertRepositoryProvider).get(id)) {
        Ok(:final value) => value.parsed.direction == MessageDirection.incoming,
        Err() => false,
      },
);

/// The app's router; a tapped notification opens its deep link
/// (R-NOTIF-4), including the one that launched the app.
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  final router = buildRouter(
    guards: ref.watch(routeGuardsProvider),
    screen: ref.watch(screenBuilderProvider),
  );
  ref.onDispose(router.dispose);
  final api = ref.watch(notificationsApiProvider);
  unawaited(
    api.initialize((payload) => router.go(locationForPayload(payload))),
  );
  unawaited(
    api.launchPayload().then((p) {
      if (p != null) router.go(locationForPayload(p));
    }),
  );
  return router;
}
