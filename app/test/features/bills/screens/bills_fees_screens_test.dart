import 'package:buckets/bootstrap/bills_fees_use_cases.dart';
import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
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

String k(String text) => text.replaceAll('K ', 'K ');

void main() {
  late ProviderContainer c;
  String path() => c.read(routerProvider).state.uri.path;

  Future<void> start(WidgetTester tester, String route) async {
    c = ProviderContainer(
      overrides: fakePortOverrides(),
      retry: retryUnlessFailure,
    );
    addTearDown(c.dispose);
    (await seedDemo(c)).orThrow();
    (await c.read(completeSetupProvider)()).orThrow();
    await pumpApp(tester, c);
    c.read(routerProvider).go(route);
    await settleStreams(tester);
  }

  Future<String> billId(String name) async =>
      (await c.read(billRepositoryProvider).getAll())
          .orThrow()
          .firstWhere((b) => b.name == name)
          .id;

  group('33 Plan · Bills this cycle', () {
    testWidgets('some due: hero, rows and the fees card', (tester) async {
      await start(tester, Routes.planBills);
      expect(find.textContaining(k('K 4,300 set aside')), findsOneWidget);
      expect(find.text(l.billsStillToPay), findsOneWidget);
      expect(find.byType(BkBillRow), findsNWidgets(4));
      expect(find.text(l.billsFeesCardTitle), findsOneWidget);
    });

    testWidgets('no bills: empty state leads to adding one', (tester) async {
      await start(tester, Routes.home);
      for (final b
          in (await c.read(billRepositoryProvider).getAll()).orThrow()) {
        (await c.read(deleteBillProvider)(b.id)).orThrow();
      }
      c.read(routerProvider).go(Routes.planBills);
      await settleStreams(tester);
      expect(find.text(l.billsEmptyTitle), findsOneWidget);
      await tapOn(tester, find.text(l.billsEmptyAction));
      await settleStreams(tester);
      expect(path(), Routes.meBills);
    });

    testWidgets('the Bills segment of Plan opens it (S-07b)', (tester) async {
      await start(tester, Routes.plan);
      await tapOn(tester, find.text(l.planBills));
      await settleStreams(tester);
      expect(path(), Routes.planBills);
      expect(find.byType(BkBillRow), findsNWidgets(4));
    });

    testWidgets('the Wishes segment goes back to Plan', (tester) async {
      await start(tester, Routes.planBills);
      await tapOn(tester, find.text(l.planWishes));
      await settleStreams(tester);
      expect(path(), Routes.plan);
    });
  });

  group('34 Mark bill paid', () {
    testWidgets('paying marks it paid and returns to the list', (tester) async {
      await start(tester, Routes.planBills);
      await tapOn(tester, find.byType(BkBillRow).first);
      await settleStreams(tester);
      expect(path(), startsWith('/plan/bills/'));
      c.read(routerProvider).go(Routes.billPay(await billId('Rent')));
      await settleStreams(tester);
      expect(find.text(l.billPayConfirm), findsOneWidget);
      expect(find.text(l.billPayFeeUnknown), findsOneWidget);
      expect(find.byType(BkSmsField), findsOneWidget);
      await tapOn(tester, find.text(l.billPayConfirm));
      await settleStreams(tester);
      expect(path(), Routes.planBills);
      expect(find.text(l.billsBadgePaid), findsOneWidget);
    });

    testWidgets('a saved rate shows the estimated fee', (tester) async {
      await start(tester, Routes.home);
      (await c.read(saveFeeBandProvider)(
        provider: AlertSource.mtnMomo,
        feeType: FeeType.billPay,
        min: Money.zero,
        max: const Money.kwacha(5000),
        fee: const Money.kwacha(4),
      )).orThrow();
      await c.read(ensureBillOccurrencesProvider)();
      c.read(routerProvider).go(Routes.billPay(await billId('ZESCO')));
      await settleStreams(tester);
      expect(find.text(l.billPayFeeAbout(k('K 4'))), findsOneWidget);
    });
  });

  group('35 Bill history', () {
    testWidgets('first cycle: nothing paid yet', (tester) async {
      await start(tester, Routes.home);
      await c.read(ensureBillOccurrencesProvider)();
      c.read(routerProvider).go(Routes.billHistory(await billId('Rent')));
      await settleStreams(tester);
      expect(find.text('Rent'), findsOneWidget);
      expect(find.text(l.billHistoryFirstCycle), findsOneWidget);
      expect(find.byType(BkMonthGrid), findsOneWidget);
      expect(find.text(l.billHistoryFees), findsOneWidget);
    });
  });

  group('36 Fees', () {
    testWidgets('empty, then a missing fee warns', (tester) async {
      await start(tester, Routes.fees);
      expect(find.text(l.feesEmptyTitle), findsOneWidget);
      expect(find.text(l.feesRatesTitle), findsOneWidget);

      await c.read(ensureBillOccurrencesProvider)();
      final occ = (await c.read(billOccurrenceRepositoryProvider).getAll())
          .orThrow()
          .first;
      (await c.read(markBillPaidProvider)(
        occurrenceId: occ.id,
        amount: occ.expectedAmount,
        accountId: 'momo',
      )).orThrow();
      await settleStreams(tester);
      expect(find.text(l.feesMissingTitle(1)), findsOneWidget);
    });
  });

  group('37 Fee rates', () {
    testWidgets('a learned change is offered, and Update applies it', (
      tester,
    ) async {
      await start(tester, Routes.feeRates);
      (await c.read(saveFeeBandProvider)(
        provider: AlertSource.mtnMomo,
        feeType: FeeType.send,
        min: Money.zero,
        max: const Money.kwacha(150),
        fee: const Money.kwacha(2),
      )).orThrow();
      final tariff = (await c.read(feeTariffRepositoryProvider).getAll())
          .orThrow()
          .single;
      (await c
              .read(pendingFeeChangesProvider)
              .add(
                PendingFeeChange(
                  AlertSource.mtnMomo,
                  FeeType.send,
                  FeeChange(tariff.bands.single, const Money.kwacha(3)),
                ),
              ))
          .orThrow();
      await settleStreams(tester);
      expect(find.text(l.feeRatesChangeTitle), findsOneWidget);
      await tapOn(tester, find.text(l.feeRatesChangeAccept));
      await settleStreams(tester);
      expect(find.text(l.feeRatesChangeTitle), findsNothing);
      final band = (await c.read(feeTariffRepositoryProvider).getAll())
          .orThrow()
          .single
          .bands
          .single;
      expect(band.fee, const Money.kwacha(3));
    });

    testWidgets('empty, then a band shows and can be deleted', (tester) async {
      await start(tester, Routes.feeRates);
      expect(find.text(l.feeRatesEmptyTitle), findsOneWidget);
      (await c.read(saveFeeBandProvider)(
        provider: AlertSource.mtnMomo,
        feeType: FeeType.send,
        min: Money.zero,
        max: const Money.kwacha(150),
        fee: const Money.kwacha(2),
      )).orThrow();
      await settleStreams(tester);
      expect(find.text(l.feeRatesEntered), findsOneWidget);
      await tapOn(tester, find.text(l.feeRatesEntered));
      await settleStreams(tester);
      await tapOn(tester, find.text(l.feeRatesDelete));
      await settleStreams(tester);
      expect(find.text(l.feeRatesEmptyTitle), findsOneWidget);
    });
  });
}
