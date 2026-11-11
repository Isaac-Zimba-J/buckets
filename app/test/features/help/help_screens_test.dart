import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../setup/screens/screen_harness.dart';

void main() {
  late ProviderContainer c;
  String path() => c.read(routerProvider).state.uri.path;

  Future<void> start(WidgetTester tester, String route) async {
    c = ProviderContainer(
      overrides: fakePortOverrides(),
      retry: retryUnlessFailure,
    );
    addTearDown(c.dispose);
    await tester.runAsync(() async {
      (await seedDemo(c)).orThrow();
      (await c.read(completeSetupProvider)()).orThrow();
    });
    await pumpApp(tester, c);
    c.read(routerProvider).go(route);
    await settleStreams(tester);
  }

  testWidgets('29 Help: topic cards and report CTA', (tester) async {
    await start(tester, Routes.help);
    // Topic cards for the bundled articles; tapping one opens the article.
    expect(find.text('How payday works'), findsOneWidget);
    await tapOn(tester, find.text('How payday works'));
    expect(path(), Routes.helpArticle('how-payday-works'));
    // Back to Help, then the report CTA navigates.
    c.read(routerProvider).go(Routes.help);
    await settleStreams(tester);
    await tapOn(tester, find.text(l.helpReportCta));
    expect(path(), Routes.helpReport);
  });

  testWidgets('30 Article: shows body and records feedback', (tester) async {
    await start(tester, Routes.helpArticle('how-payday-works'));
    expect(find.text('How payday works'), findsOneWidget);
    await tapOn(tester, find.text(l.helpYes));
    await settleStreams(tester);
    expect(find.text(l.helpThanks), findsOneWidget);
  });

  testWidgets('31 Report: opens the email app with the report', (tester) async {
    await start(tester, Routes.helpReport);
    // Disabled until there's text.
    final before = tester.widget<BkButton>(
      find.widgetWithText(BkButton, l.reportOpenEmail),
    );
    expect(before.onPressed, isNull);
    await type(tester, l.reportWhatHappened, 'The alarm did not ring');
    await settleStreams(tester);
    await tapOn(tester, find.widgetWithText(BkButton, l.reportOpenEmail));
    await settleStreams(tester);
    final email = c.read(emailComposerProvider) as FakeEmailComposer;
    expect(email.body, startsWith('The alarm did not ring'));
    expect(path(), Routes.help);
  });

  testWidgets('32 About: version and Rate opens the store', (tester) async {
    await start(tester, Routes.meAbout);
    expect(find.textContaining('1.0.0'), findsOneWidget);
    await tapOn(tester, find.text(l.aboutRate));
    await settleStreams(tester);
    final opener =
        c.read(systemSettingsOpenerProvider) as FakeSystemSettingsOpener;
    expect(opener.store, 1);
  });
}
