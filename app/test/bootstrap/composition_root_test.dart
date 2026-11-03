import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderListenable;
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer c;
  setUp(() => c = ProviderContainer(overrides: fakePortOverrides()));
  tearDown(() => c.dispose());

  test('every use case resolves on the fakes', () {
    final all = <ProviderListenable<Object>>[
      getSetupStatusProvider,
      completeSetupProvider,
      saveNotificationPreferencesProvider,
      getPermissionStatusProvider,
      requestNotificationPermissionProvider,
      openNotificationAccessSettingsProvider,
      saveIncomeSourceProvider,
      listIncomeSourcesProvider,
      saveBillProvider,
      deleteBillProvider,
      listBillsProvider,
      getBillReservationsProvider,
      previewSplitProvider,
      saveSplitProfileProvider,
      saveAccountProvider,
      listBucketsWithAccountsProvider,
      assignBucketAccountProvider,
      firstRunSeedProvider,
      getCurrentCycleProvider,
      watchHomeProvider,
      getNextPaydayProvider,
      watchBucketProvider,
      getCoverOptionsProvider,
      coverOverspendProvider,
      createGoalProvider,
      watchGoalsProvider,
      getSavingsStatsProvider,
      scheduleNotificationsProvider,
      startPaydayProvider,
      watchPaydayProvider,
      snoozePaydayAlarmProvider,
      proveTransferProvider,
      recordPartialTransferProvider,
      markTransferSelfReportedProvider,
      getPaydaySummaryProvider,
      classifyIncomingAlertProvider,
      ignoreAlertProvider,
      splitSideHustleIncomeProvider,
      holdSideHustleIncomeProvider,
      releaseHeldIncomeProvider,
      spendWriterProvider,
      ingestPaymentAlertsProvider,
      watchUnsortedAlertsProvider,
      suggestAlertFilingProvider,
      categorizeAlertProvider,
      saveMerchantRuleProvider,
      skipAlertProvider,
      logCashPaymentProvider,
      parsePastedMessageProvider,
      logPastedPaymentProvider,
      suggestWishProvider,
      captureReceiptImageProvider,
      recognizeReceiptProvider,
      updateReceiptDraftProvider,
      saveReceiptProvider,
      addPlannedPurchaseProvider,
      togglePlannedPurchaseProvider,
      watchPlannedPurchasesProvider,
      watchWishesProvider,
      addWishProvider,
      approveWishProvider,
      dropWishProvider,
      checkInContextProvider,
      getCheckInStateProvider,
      countCashProvider,
      recordUntrackedCashProvider,
      recordReceivedCashProvider,
      getWeekSummaryProvider,
    ];
    for (final p in all) {
      expect(c.read<Object>(p), isNotNull, reason: '$p');
    }
    expect(all, hasLength(68));
  });

  test('demo mode reproduces the canvas', () async {
    final seeded = await seedDemo(c);
    expect(seeded, isA<Ok<void>>(), reason: '$seeded');
    final home = switch (await c.read(watchHomeProvider)().first) {
      Ok(:final value) => value,
      Err(:final failure) => fail('$failure'),
    };
    expect(home.livingLeft, const Money.kwacha(3080));
    expect(home.guiltFreeLeft, const Money.kwacha(770));
    final payday = home.openPayday!;
    expect(payday.transfers, hasLength(4));
    expect(
      payday.transfers.fold(Money.zero, (s, t) => s + t.amount),
      const Money.kwacha(3850),
    );
    expect(home.unlocked, isFalse);
  });
}
