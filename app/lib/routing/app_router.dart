import 'dart:async';

import 'package:buckets/routing/deep_links.dart';
import 'package:buckets/routing/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Builds the widget for [screen]; screens arrive in Phase 5, so until then
/// the app passes placeholders.
typedef ScreenBuilder = Widget Function(
  AppScreen screen,
  Map<String, String> params,
);

/// What the router needs to know before it shows a route.
final class RouteGuards {
  /// Creates the guards.
  const new({required this.isSetUp, required this.isIncomeAlert});

  /// Whether first-run setup is complete.
  final Future<bool> Function() isSetUp;

  /// Whether the alert is incoming money (17) rather than a payment (18).
  final Future<bool> Function(String alertId) isIncomeAlert;
}

/// The app's router: every route in `docs/SCREENS.md`, the setup guard and
/// `buckets://` deep links.
GoRouter buildRouter({
  required RouteGuards guards,
  required ScreenBuilder screen,
  String initialLocation = Routes.home,
}) => GoRouter(
  initialLocation: initialLocation,
  redirect: (_, state) => _guard(guards, state.uri),
  onException: (_, _, router) => router.go(Routes.home),
  routes: [
    GoRoute(path: '/', redirect: (_, _) => Routes.home),
    ..._setupRoutes(screen),
    _route(Routes.home, AppScreen.home, screen),
    _route('/bucket/:bucketId', AppScreen.bucket, screen),
    _route(Routes.goals, AppScreen.goals, screen),
    _route(Routes.plan, AppScreen.plan, screen),
    _route('/payday/:paydayId', AppScreen.payday, screen),
    _route('/payday/:paydayId/proof/:transferId', AppScreen.proof, screen),
    _route('/payday/:paydayId/done', AppScreen.paydayDone, screen),
    GoRoute(
      path: '/alert/:alertId',
      redirect: (_, state) async {
        final id = state.pathParameters['alertId']!;
        return await guards.isIncomeAlert(id)
            ? Routes.incomeReceived(id)
            : Routes.sort;
      },
    ),
    _route('/income/received/:alertId', AppScreen.incomeReceived, screen),
    _route(Routes.sort, AppScreen.sort, screen),
    _route(Routes.log, AppScreen.log, screen),
    _route(Routes.scan, AppScreen.scan, screen),
    _route('/log/receipt/:draftId', AppScreen.receipt, screen),
    _route(Routes.checkIn, AppScreen.checkIn, screen),
    ..._meRoutes(screen),
  ],
);

/// Deep links first, then the setup guard: before setup only setup
/// routes are reachable, after it setup routes go Home.
Future<String?> _guard(RouteGuards guards, Uri uri) async {
  if (uri.scheme == deepLinkScheme) return locationForDeepLink(uri);
  final inSetup = Routes.isSetup(uri.path);
  if (!await guards.isSetUp()) return inSetup ? null : Routes.welcome;
  return inSetup ? Routes.home : null;
}

List<GoRoute> _setupRoutes(ScreenBuilder screen) => [
  _route(Routes.welcome, AppScreen.welcome, screen),
  _route(Routes.setupIncome, AppScreen.income, screen),
  _route(Routes.setupBills, AppScreen.bills, screen),
  _route('/setup/split/:incomeId', AppScreen.split, screen),
  _route(Routes.setupAccounts, AppScreen.accounts, screen),
  _route(Routes.setupPermissions, AppScreen.permissions, screen),
];

List<GoRoute> _meRoutes(ScreenBuilder screen) => [
  _route(Routes.me, AppScreen.me, screen),
  _route(Routes.meIncome, AppScreen.income, screen),
  _route(Routes.meBills, AppScreen.bills, screen),
  _route('/me/split/:incomeId', AppScreen.split, screen),
  _route(Routes.meAccounts, AppScreen.accounts, screen),
  _route(Routes.meNotifications, AppScreen.permissions, screen),
];

GoRoute _route(String path, AppScreen id, ScreenBuilder screen) => GoRoute(
  path: path,
  builder: (_, state) =>
      screen(id, {...state.uri.queryParameters, ...state.pathParameters}),
);
