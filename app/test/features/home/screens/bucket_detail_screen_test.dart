import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../setup/screens/screen_harness.dart';

String k(String text) => text.replaceAll('K ', 'K ');

void main() {
  late ProviderContainer c;

  String bucketOf(BucketKind kind) =>
      (c.read(bucketRepositoryProvider) as InMemoryBucketRepository)
          .store
          .items
          .values
          .firstWhere((b) => b.kind == kind)
          .id;

  Future<void> spend(BucketKind kind, int kwacha) async =>
      (await c.read(logCashPaymentProvider)(
        amount: Money.kwacha(kwacha),
        category: Category.food,
        bucketId: bucketOf(kind),
      )).orThrow();

  Future<void> start(WidgetTester tester, {int livingSpend = 0}) async {
    c = fakeContainer();
    addTearDown(c.dispose);
    (await seedDemo(c)).orThrow();
    (await c.read(completeSetupProvider)()).orThrow();
    if (livingSpend > 0) await spend(BucketKind.living, livingSpend);
    await pumpApp(tester, c);
    c.read(routerProvider).go(Routes.bucket(bucketOf(BucketKind.living)));
    await settleStreams(tester);
  }

  testWidgets('normal: left to spend and this cycle', (tester) async {
    await start(tester, livingSpend: 80);
    expect(find.text('Living'), findsWidgets);
    expect(find.text(l.bucketLeft), findsOneWidget);
    expect(find.text(k('K 3,000')), findsOneWidget);
    expect(find.text(l.bucketThisCycle), findsOneWidget);
    expect(find.text(l.bucketEntrySpend), findsOneWidget);
    expect(find.text(l.bucketEntryPayday), findsWidgets);
  });

  testWidgets('overspent: K 310 over, options in order, cover moves it', (
    tester,
  ) async {
    // Spend the bill money too, so the balance itself goes below K 0.
    await start(tester, livingSpend: 7690);
    expect(find.text(l.bucketOver(k('K 310'))), findsOneWidget);
    expect(find.text(l.bucketCoverFrom(k('K 310'))), findsOneWidget);
    final cards = tester
        .widgetList<BkRadioCard>(find.byType(BkRadioCard))
        .map((c) => c.title)
        .toList();
    // R-OVER-2: Guilt-free, Short-term, then next cycle's Living.
    expect(cards.first, 'Guilt-free');
    expect(cards.last, l.bucketNextCycle('Living'));
    // Guilt-free and Short-term both hold K 770.
    expect(
      find.text(l.bucketCoverChange(k('K 770'), k('K 460'))),
      findsNWidgets(2),
    );
    expect(find.text(l.bucketLockNote), findsOneWidget);
    await tapOn(tester, find.text(l.bucketMove(k('K 310'))));
    await settleStreams(tester);
    expect(
      find.text(l.bucketCovered(k('K 310'), 'Guilt-free')),
      findsOneWidget,
    );
    expect(find.text(l.bucketLeft), findsOneWidget);
    expect(find.text(l.bucketEntryMoveIn), findsOneWidget);
  });

  testWidgets('cover from next cycle when picked', (tester) async {
    await start(tester, livingSpend: 7690);
    await tapOn(tester, find.text(l.bucketNextCycle('Living')));
    await tapOn(tester, find.text(l.bucketMove(k('K 310'))));
    await settleStreams(tester);
    expect(
      find.text(l.bucketCovered(k('K 310'), l.bucketNextCycle('Living'))),
      findsOneWidget,
    );
  });
}
