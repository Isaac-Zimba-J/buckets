import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/logging/presentation/controllers/check_in_controller.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../setup/screens/screen_harness.dart';
import 'logging_screens_test.dart' show alert;

String k(String text) => text.replaceAll('K ', 'K\u00a0');

void main() {
  late ProviderContainer c;
  String path() => c.read(routerProvider).state.uri.path;

  Future<void> start(WidgetTester tester, {bool unsorted = false}) async {
    c = fakeContainer();
    addTearDown(c.dispose);
    (await seedDemo(c)).orThrow();
    (await c.read(completeSetupProvider)()).orThrow();
    if (unsorted) {
      (await c.read(alertRepositoryProvider).save(alert('a1', '[SHOP]', 0)))
          .orThrow();
    }
    await pumpApp(tester, c);
    c.read(routerProvider).go(Routes.checkIn);
    await settleStreams(tester);
  }

  Future<void> next(WidgetTester tester) async {
    await tapOn(tester, find.widgetWithText(BkButton, l.checkInNext));
    await settleStreams(tester);
  }

  Future<void> count(WidgetTester tester, String kwacha) async {
    await typeAmount(tester, kwacha);
    await tapOn(tester, find.widgetWithText(BkButton, l.checkInCount));
    await settleStreams(tester);
  }

  testWidgets('step 1: payments to sort link to the sort sheet', (
    tester,
  ) async {
    await start(tester, unsorted: true);
    expect(find.text(l.checkInTitle), findsOneWidget);
    expect(find.text(l.checkInToSort(1)), findsOneWidget);
    expect(find.text(l.checkInSortBody(1)), findsOneWidget);
    await tapOn(tester, find.widgetWithText(BkButton, l.checkInSortNow));
    expect(path(), Routes.sort);
  });

  testWidgets('count matches: spot on, then the week, then Home', (
    tester,
  ) async {
    await start(tester);
    // Nothing to sort: the check-in starts at counting (R-CHECKIN-1).
    expect(find.text(l.checkInStepSort), findsNothing);
    expect(find.text(l.checkInShouldHave), findsOneWidget);
    await count(tester, '0');
    expect(find.text(l.checkInSpotOn), findsOneWidget);
    await next(tester);
    expect(find.text(l.checkInSaved), findsOneWidget);
    expect(find.text(l.checkInUntracked), findsOneWidget);
    await tapOn(tester, find.widgetWithText(BkButton, l.checkInDone));
    expect(path(), Routes.home);
  });

  testWidgets('more cash: kept as cash; next week less: untracked', (
    tester,
  ) async {
    await start(tester);
    await count(tester, '100');
    expect(find.text(l.checkInReceivedTitle(k('K 100'))), findsOneWidget);
    await tapOn(tester, find.widgetWithText(BkButton, l.checkInKeepCash));
    await settleStreams(tester);
    expect(find.text(l.checkInRecorded), findsOneWidget);
    await next(tester);
    await tapOn(tester, find.widgetWithText(BkButton, l.checkInDone));

    // The next check-in expects the K 100 counted last time.
    c.invalidate(checkInControllerProvider);
    c.read(routerProvider).go(Routes.checkIn);
    await settleStreams(tester);
    expect(find.text(k('K 100')), findsOneWidget);
    await count(tester, '70');
    expect(find.text(l.checkInMissingTitle(k('K 30'))), findsOneWidget);
    expect(find.text(l.checkInLogNow), findsOneWidget);
    await tapOn(tester, find.widgetWithText(BkButton, l.checkInMarkUntracked));
    await settleStreams(tester);
    expect(find.text(l.checkInRecorded), findsOneWidget);
    await next(tester);
    expect(find.text(l.checkInUntracked), findsOneWidget);
  });
}
