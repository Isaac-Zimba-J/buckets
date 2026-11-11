import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Placeholder screens: the screen name and its parameters.
Widget placeholder(AppScreen screen, Map<String, String> params) =>
    Text('${screen.name} $params', textDirection: TextDirection.ltr);

PaymentAlert alert(String id, MessageDirection direction) =>
    PaymentAlert.create(
      id: id,
      rawText: null,
      source: AlertSource.mtnMomo,
      receivedAt: DateTime.utc(2026, 10, 25, 6),
      parsed: ParsedMessage(
        confidence: 1,
        direction: direction,
        amount: const Money.kwacha(100),
      ),
    ).orThrow();

void main() {
  late ProviderContainer c;
  late FakeNotificationsApi notifications;

  Future<void> start(
    WidgetTester tester, {
    bool setUp = true,
    String? launch,
  }) async {
    notifications = FakeNotificationsApi(launch: launch);
    c = ProviderContainer(
      overrides: [
        ...fakePortOverrides(notifications: notifications),
        screenBuilderProvider.overrideWithValue(placeholder),
      ],
      retry: retryUnlessFailure,
    );
    addTearDown(c.dispose);
    await tester.runAsync(() async {
      (await seedDemo(c)).orThrow();
      if (setUp) (await c.read(completeSetupProvider)()).orThrow();
      for (final a in [
        alert('in', MessageDirection.incoming),
        alert('out', MessageDirection.outgoing),
      ]) {
        (await c.read(alertRepositoryProvider).save(a)).orThrow();
      }
    });
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: c,
        child: MaterialApp.router(routerConfig: c.read(routerProvider)),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> go(WidgetTester tester, String location) async {
    c.read(routerProvider).go(location);
    await tester.pumpAndSettle();
  }

  void shows(String text) => expect(find.text(text), findsOneWidget);

  group('setup guard', () {
    testWidgets('before setup everything goes to Welcome', (tester) async {
      await start(tester, setUp: false);
      shows('welcome {}');
      await go(tester, Routes.home);
      shows('welcome {}');
      await go(tester, Routes.payday('p'));
      shows('welcome {}');
      await go(tester, Routes.setupSplit('salary'));
      shows('split {incomeId: salary}');
      await go(tester, Routes.setupProfile);
      shows('profile {}');
    });

    testWidgets('after setup, setup routes go Home', (tester) async {
      await start(tester);
      shows('home {}');
      await go(tester, Routes.welcome);
      shows('home {}');
      await go(tester, Routes.setupBills);
      shows('home {}');
      await go(tester, Routes.meBills);
      shows('bills {from: me}');
    });

    testWidgets('unknown paths open Home', (tester) async {
      await start(tester);
      await go(tester, '/no/such/page');
      shows('home {}');
    });
  });

  group('routes', () {
    testWidgets('carry their parameters', (tester) async {
      await start(tester);
      await go(tester, Routes.proof('p1', 't1'));
      shows('proof {paydayId: p1, transferId: t1}');
      await go(tester, Routes.paydayDone('p1'));
      shows('paydayDone {paydayId: p1}');
      await go(tester, Routes.receipt('r1'));
      shows('receipt {draftId: r1}');
      await go(tester, Routes.scan);
      shows('scan {}');
    });
  });

  group('profile, settings and help routes (DOC-01)', () {
    testWidgets('resolve to their screens', (tester) async {
      await start(tester);
      await go(tester, Routes.meSettings);
      shows('settings {}');
      await go(tester, Routes.meSecurity);
      shows('security {}');
      await go(tester, Routes.meData);
      shows('dataPrivacy {}');
      await go(tester, Routes.meRules);
      shows('rules {}');
      await go(tester, Routes.meAbout);
      shows('about {}');
      await go(tester, Routes.help);
      shows('help {}');
      await go(tester, Routes.helpReport);
      shows('report {}');
      await go(tester, Routes.helpArticle('app-lock'));
      shows('helpArticle {articleId: app-lock}');
      await go(tester, Routes.meProfile);
      shows('profile {from: me}');
    });
  });

  group('notification taps (R-NOTIF-4)', () {
    testWidgets('each payload opens its screen', (tester) async {
      await start(tester);
      final cases = {
        'buckets://payday/p1': 'payday {paydayId: p1}',
        'buckets://alert/in': 'incomeReceived {alertId: in}',
        'buckets://alert/out': 'sort {}',
        'buckets://alert/missing': 'sort {}',
        'buckets://checkin': 'checkIn {}',
        'buckets://plan/wish/w1': 'plan {tab: wishes, wish: w1}',
        'buckets://plan/bills': 'bills {from: me}',
        'buckets://bucket/b1': 'bucket {bucketId: b1}',
        'garbage': 'home {}',
      };
      for (final MapEntry(:key, :value) in cases.entries) {
        notifications.tap(key);
        await tester.pumpAndSettle();
        expect(find.text(value), findsOneWidget, reason: key);
      }
    });

    testWidgets('the tap that launched the app opens its screen', (
      tester,
    ) async {
      await start(tester, launch: 'buckets://checkin');
      shows('checkIn {}');
    });

    testWidgets('a deep link before setup still lands on Welcome', (
      tester,
    ) async {
      await start(tester, setUp: false);
      notifications.tap('buckets://payday/p1');
      await tester.pumpAndSettle();
      shows('welcome {}');
    });

    testWidgets('a platform deep link is mapped too', (tester) async {
      await start(tester);
      await go(tester, 'buckets://checkin');
      shows('checkIn {}');
    });
  });
}
