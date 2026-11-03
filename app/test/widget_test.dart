import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/main.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('BucketsApp boots into the router; first run is Welcome', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: fakePortOverrides(),
        retry: retryUnlessFailure,
        child: const BucketsApp(),
      ),
    );
    await tester.pumpAndSettle();
    final container = ProviderScope.containerOf(
      tester.element(find.byType(MaterialApp)),
    );
    expect(container.read(routerProvider).state.uri.path, Routes.welcome);
  });
}
