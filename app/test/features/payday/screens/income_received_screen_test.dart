import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../setup/screens/screen_harness.dart';

String k(String text) => text.replaceAll('K ', 'K\u00a0');

void main() {
  late ProviderContainer c;
  String path() => c.read(routerProvider).state.uri.path;

  Future<void> start(
    WidgetTester tester, {
    Money? amount = const Money.kwacha(2000),
    bool hustle = true,
  }) async {
    c = fakeContainer();
    addTearDown(c.dispose);
    (await seedDemo(c)).orThrow();
    (await c.read(completeSetupProvider)()).orThrow();
    if (hustle) {
      (await c.read(saveIncomeSourceProvider)(
        name: 'Tutoring',
        kind: IncomeKind.sideHustle,
        landsInAccountId: 'momo',
      )).orThrow();
    }
    (await c
            .read(alertRepositoryProvider)
            .save(
              PaymentAlert.create(
                id: 'al',
                rawText: null,
                source: AlertSource.mtnMomo,
                receivedAt: c.read(clockProvider).now(),
                parsed: ParsedMessage(
                  confidence: 1,
                  direction: MessageDirection.incoming,
                  amount: amount,
                  counterparty: '[CUSTOMER]',
                ),
              ).orThrow(),
            ))
        .orThrow();
    await pumpApp(tester, c);
    c.read(routerProvider).go(Routes.incomeReceived('al'));
    await settleStreams(tester);
  }

  testWidgets('ready: source, amount, the hustle and its split', (
    tester,
  ) async {
    await start(tester);
    expect(
      find.text(l.incomeSourceAt(l.incomeSourceMtn, '08:00')),
      findsOneWidget,
    );
    expect(find.text(l.incomeFrom('[CUSTOMER]')), findsOneWidget);
    expect(find.text(k('+K 2,000')), findsOneWidget);
    expect(find.text(l.incomeAskHustle), findsOneWidget);
    expect(find.widgetWithText(BkSegmented<String>, 'Tutoring'), findsOne);
    // R-SPLIT-5 with no business bucket: Restock becomes Short-term.
    expect(find.text(l.incomeShare('30%', k('K 600'))), findsNWidgets(2));
    expect(find.text(l.incomeShare('20%', k('K 400'))), findsNWidgets(2));
  });

  testWidgets('split it starts the payday and opens 13', (tester) async {
    await start(tester);
    await tapOn(tester, find.widgetWithText(BkButton, l.incomeSplitIt));
    await settleStreams(tester);
    expect(path(), startsWith('/payday/'));
    expect(find.text(l.paydayHeadline), findsOneWidget);
  });

  testWidgets('hold until month end: when it will be split', (tester) async {
    await start(tester);
    await tapOn(tester, find.widgetWithText(BkButton, l.incomeHold));
    await settleStreams(tester);
    expect(find.text(l.incomeHoldingTitle), findsOneWidget);
    expect(find.text(l.incomeHoldingBody('31 Oct', '18:00')), findsOneWidget);
    await tapOn(tester, find.widgetWithText(BkButton, l.done));
    expect(path(), Routes.home);
  });

  testWidgets('something else: leave it out, back home', (tester) async {
    await start(tester);
    await tapOn(tester, find.text(l.incomeSomethingElse));
    expect(find.text(l.incomeItsSplit.toUpperCase()), findsNothing);
    expect(find.text(l.incomeNotHustleBody), findsOneWidget);
    await tapOn(tester, find.widgetWithText(BkButton, l.incomeNotHustle));
    await settleStreams(tester);
    expect(path(), Routes.home);
    expect(find.text(l.incomeLeftOut), findsOneWidget);
  });

  testWidgets('no amount read: enter it before splitting', (tester) async {
    await start(tester, amount: null);
    expect(find.text(l.incomeAmountMissing), findsWidgets);
    await typeAmount(tester, '1000');
    expect(find.text(l.incomeShare('30%', k('K 300'))), findsNWidgets(2));
  });

  testWidgets('no side hustle yet: empty state links to Income', (
    tester,
  ) async {
    await start(tester, hustle: false);
    expect(find.text(l.incomeNoHustlesTitle), findsOneWidget);
    await tapOn(tester, find.text(l.incomeAddHustle));
    expect(path(), Routes.meIncome);
  });

  testWidgets('salary landed: start payday from the alert', (tester) async {
    await start(tester, amount: const Money.kwacha(12000));
    expect(find.text(l.incomeSalaryTitle), findsOneWidget);
    await tapOn(tester, find.text(l.incomeNotSalary));
    expect(find.text(l.incomeAskHustle), findsOneWidget);
  });
}
