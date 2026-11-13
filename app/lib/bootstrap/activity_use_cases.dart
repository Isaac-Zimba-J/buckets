import 'package:buckets/bootstrap/bills_fees_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_use_cases.g.dart';

// Payday loop, logging, plan and check-in:
// one provider per use case, wired from the port providers.

/// [StartPayday] (screen payday).
@Riverpod(keepAlive: true)
StartPayday startPayday(Ref ref) => StartPayday(
  incomes: ref.watch(incomeRepositoryProvider),
  profiles: ref.watch(splitProfileRepositoryProvider),
  buckets: ref.watch(bucketRepositoryProvider),
  reservations: ref.watch(getBillReservationsProvider),
  ledger: ref.watch(ledgerRepositoryProvider),
  paydays: ref.watch(paydayRepositoryProvider),
  ids: ref.watch(idsProvider),
  clock: ref.watch(clockProvider),
);

/// [WatchPayday] (screen 13).
@Riverpod(keepAlive: true)
WatchPayday watchPayday(Ref ref) =>
    WatchPayday(ref.watch(paydayRepositoryProvider));

/// [SnoozePaydayAlarm] (screen 13).
@Riverpod(keepAlive: true)
SnoozePaydayAlarm snoozePaydayAlarm(Ref ref) => SnoozePaydayAlarm(
  ref.watch(paydayRepositoryProvider),
  ref.watch(settingsRepositoryProvider),
  ref.watch(clockProvider),
  ref.watch(localTimeZoneProvider),
);

/// [ProveTransfer] (screen 14).
@Riverpod(keepAlive: true)
ProveTransfer proveTransfer(Ref ref) => ProveTransfer(
  ref.watch(paydayRepositoryProvider),
  ref.watch(accountRepositoryProvider),
  ref.watch(smsParserProvider),
  ref.watch(clockProvider),
  ref.watch(localTimeZoneProvider),
  ref.watch(recordTransferFeeProvider),
);

/// [RecordPartialTransfer] (screen 15).
@Riverpod(keepAlive: true)
RecordPartialTransfer recordPartialTransfer(Ref ref) => RecordPartialTransfer(
  ref.watch(proveTransferProvider),
  ref.watch(clockProvider),
);

/// [MarkTransferSelfReported] (screen 14).
@Riverpod(keepAlive: true)
MarkTransferSelfReported markTransferSelfReported(Ref ref) =>
    MarkTransferSelfReported(
      ref.watch(paydayRepositoryProvider),
      ref.watch(proveTransferProvider),
      ref.watch(clockProvider),
    );

/// [GetPaydaySummary] (screen 16).
@Riverpod(keepAlive: true)
GetPaydaySummary getPaydaySummary(Ref ref) => GetPaydaySummary(
  paydays: ref.watch(paydayRepositoryProvider),
  ledger: ref.watch(ledgerRepositoryProvider),
  buckets: ref.watch(bucketRepositoryProvider),
  goals: ref.watch(goalRepositoryProvider),
  incomes: ref.watch(incomeRepositoryProvider),
  clock: ref.watch(clockProvider),
  zone: ref.watch(localTimeZoneProvider),
);

/// [ClassifyIncomingAlert] (screen 17).
@Riverpod(keepAlive: true)
ClassifyIncomingAlert classifyIncomingAlert(Ref ref) => ClassifyIncomingAlert(
  ref.watch(alertRepositoryProvider),
  ref.watch(incomeRepositoryProvider),
);

/// [IgnoreAlert] (screen 17-18).
@Riverpod(keepAlive: true)
IgnoreAlert ignoreAlert(Ref ref) =>
    IgnoreAlert(ref.watch(alertRepositoryProvider));

/// [SplitSideHustleIncome] (screen 17).
@Riverpod(keepAlive: true)
SplitSideHustleIncome splitSideHustleIncome(Ref ref) => SplitSideHustleIncome(
  ref.watch(alertRepositoryProvider),
  ref.watch(startPaydayProvider),
);

/// [HoldSideHustleIncome] (screen 17).
@Riverpod(keepAlive: true)
HoldSideHustleIncome holdSideHustleIncome(Ref ref) => HoldSideHustleIncome(
  ref.watch(alertRepositoryProvider),
  ref.watch(heldIncomeRepositoryProvider),
  ref.watch(idsProvider),
  ref.watch(clockProvider),
  ref.watch(localTimeZoneProvider),
);

/// [ReleaseHeldIncome] (screen 17).
@Riverpod(keepAlive: true)
ReleaseHeldIncome releaseHeldIncome(Ref ref) => ReleaseHeldIncome(
  ref.watch(heldIncomeRepositoryProvider),
  ref.watch(startPaydayProvider),
);

/// [SpendWriter] (screen logging).
@Riverpod(keepAlive: true)
SpendWriter spendWriter(Ref ref) => SpendWriter(
  ref.watch(transactionRepositoryProvider),
  ref.watch(ledgerRepositoryProvider),
  ref.watch(idsProvider),
);

/// [IngestPaymentAlerts] (screen alerts).
@Riverpod(keepAlive: true)
IngestPaymentAlerts ingestPaymentAlerts(Ref ref) => IngestPaymentAlerts(
  source: ref.watch(paymentAlertSourceProvider),
  parser: ref.watch(smsParserProvider),
  alerts: ref.watch(alertRepositoryProvider),
  packageSources: ref.watch(packageSourcesProvider),
  ids: ref.watch(idsProvider),
  zone: ref.watch(localTimeZoneProvider),
);

/// [WatchUnsortedAlerts] (screen 18).
@Riverpod(keepAlive: true)
WatchUnsortedAlerts watchUnsortedAlerts(Ref ref) =>
    WatchUnsortedAlerts(ref.watch(alertRepositoryProvider));

/// [SuggestAlertFiling] (screen 18).
@Riverpod(keepAlive: true)
SuggestAlertFiling suggestAlertFiling(Ref ref) => SuggestAlertFiling(
  ref.watch(merchantRuleRepositoryProvider),
  ref.watch(settingsRepositoryProvider),
);

/// [CategorizeAlert] (screen 18).
@Riverpod(keepAlive: true)
CategorizeAlert categorizeAlert(Ref ref) => CategorizeAlert(
  alerts: ref.watch(alertRepositoryProvider),
  accounts: ref.watch(accountRepositoryProvider),
  transactions: ref.watch(transactionRepositoryProvider),
  rules: ref.watch(merchantRuleRepositoryProvider),
  writer: ref.watch(spendWriterProvider),
  ids: ref.watch(idsProvider),
);

/// [SaveMerchantRule] (screen 18).
@Riverpod(keepAlive: true)
SaveMerchantRule saveMerchantRule(Ref ref) => SaveMerchantRule(
  ref.watch(merchantRuleRepositoryProvider),
  ref.watch(idsProvider),
);

/// [SkipAlert] (screen 18).
@Riverpod(keepAlive: true)
SkipAlert skipAlert(Ref ref) => SkipAlert(ref.watch(alertRepositoryProvider));

/// [LogCashPayment] (screen 19).
@Riverpod(keepAlive: true)
LogCashPayment logCashPayment(Ref ref) => LogCashPayment(
  ref.watch(accountRepositoryProvider),
  ref.watch(spendWriterProvider),
  ref.watch(idsProvider),
  ref.watch(clockProvider),
);

/// [ParsePastedMessage] (screen 19).
@Riverpod(keepAlive: true)
ParsePastedMessage parsePastedMessage(Ref ref) => ParsePastedMessage(
  ref.watch(smsParserProvider),
  ref.watch(clockProvider),
  ref.watch(localTimeZoneProvider),
);

/// [LogPastedPayment] (screen 19).
@Riverpod(keepAlive: true)
LogPastedPayment logPastedPayment(Ref ref) => LogPastedPayment(
  ref.watch(accountRepositoryProvider),
  ref.watch(spendWriterProvider),
  ref.watch(idsProvider),
  ref.watch(clockProvider),
);

/// [SuggestWish] (screen 19).
@Riverpod(keepAlive: true)
SuggestWish suggestWish(Ref ref) =>
    SuggestWish(ref.watch(settingsRepositoryProvider));

/// [CaptureReceiptImage] (screen 20).
@Riverpod(keepAlive: true)
CaptureReceiptImage captureReceiptImage(Ref ref) =>
    CaptureReceiptImage(ref.watch(imageCaptureProvider));

/// [RecognizeReceipt] (screen 20).
@Riverpod(keepAlive: true)
RecognizeReceipt recognizeReceipt(Ref ref) => RecognizeReceipt(
  recognizer: ref.watch(textRecognizerProvider),
  parser: ref.watch(receiptTextParserProvider),
  receipts: ref.watch(receiptRepositoryProvider),
  ids: ref.watch(idsProvider),
  clock: ref.watch(clockProvider),
  zone: ref.watch(localTimeZoneProvider),
);

/// [UpdateReceiptDraft] (screen 21).
@Riverpod(keepAlive: true)
UpdateReceiptDraft updateReceiptDraft(Ref ref) =>
    UpdateReceiptDraft(ref.watch(receiptRepositoryProvider));

/// [SaveReceipt] (screen 21).
@Riverpod(keepAlive: true)
SaveReceipt saveReceipt(Ref ref) => SaveReceipt(
  ref.watch(receiptRepositoryProvider),
  ref.watch(accountRepositoryProvider),
  ref.watch(spendWriterProvider),
  ref.watch(idsProvider),
  ref.watch(clockProvider),
);

/// [AddPlannedPurchase] (screen 11).
@Riverpod(keepAlive: true)
AddPlannedPurchase addPlannedPurchase(Ref ref) => AddPlannedPurchase(
  ref.watch(planningRepositoryProvider),
  ref.watch(idsProvider),
);

/// [TogglePlannedPurchase] (screen 11).
@Riverpod(keepAlive: true)
TogglePlannedPurchase togglePlannedPurchase(Ref ref) =>
    TogglePlannedPurchase(ref.watch(planningRepositoryProvider));

/// [WatchPlannedPurchases] (screen 11).
@Riverpod(keepAlive: true)
WatchPlannedPurchases watchPlannedPurchases(Ref ref) =>
    WatchPlannedPurchases(ref.watch(planningRepositoryProvider));

/// [WatchWishes] (screen 11).
@Riverpod(keepAlive: true)
WatchWishes watchWishes(Ref ref) =>
    WatchWishes(ref.watch(planningRepositoryProvider));

/// [AddWish] (screen 11).
@Riverpod(keepAlive: true)
AddWish addWish(Ref ref) => AddWish(
  ref.watch(planningRepositoryProvider),
  ref.watch(settingsRepositoryProvider),
  ref.watch(idsProvider),
  ref.watch(clockProvider),
);

/// [ApproveWish] (screen 11).
@Riverpod(keepAlive: true)
ApproveWish approveWish(Ref ref) => ApproveWish(
  ref.watch(planningRepositoryProvider),
  ref.watch(clockProvider),
);

/// [DropWish] (screen 11).
@Riverpod(keepAlive: true)
DropWish dropWish(Ref ref) => DropWish(ref.watch(planningRepositoryProvider));

/// [CheckInContext] (screen 22).
@Riverpod(keepAlive: true)
CheckInContext checkInContext(Ref ref) => CheckInContext(
  alerts: ref.watch(alertRepositoryProvider),
  accounts: ref.watch(accountRepositoryProvider),
  transactions: ref.watch(transactionRepositoryProvider),
  checkIns: ref.watch(checkInRepositoryProvider),
  clock: ref.watch(clockProvider),
);

/// [GetCheckInState] (screen 22).
@Riverpod(keepAlive: true)
GetCheckInState getCheckInState(Ref ref) =>
    GetCheckInState(ref.watch(checkInContextProvider));

/// [CountCash] (screen 22).
@Riverpod(keepAlive: true)
CountCash countCash(Ref ref) =>
    CountCash(ref.watch(checkInContextProvider), ref.watch(idsProvider));

/// [RecordUntrackedCash] (screen 22).
@Riverpod(keepAlive: true)
RecordUntrackedCash recordUntrackedCash(Ref ref) => RecordUntrackedCash(
  accounts: ref.watch(accountRepositoryProvider),
  buckets: ref.watch(bucketRepositoryProvider),
  transactions: ref.watch(transactionRepositoryProvider),
  ledger: ref.watch(ledgerRepositoryProvider),
  ids: ref.watch(idsProvider),
  clock: ref.watch(clockProvider),
);

/// [RecordReceivedCash] (screen 22).
@Riverpod(keepAlive: true)
RecordReceivedCash recordReceivedCash(Ref ref) => RecordReceivedCash(
  ref.watch(bucketRepositoryProvider),
  ref.watch(ledgerRepositoryProvider),
  ref.watch(idsProvider),
  ref.watch(clockProvider),
);

/// [WatchSpendHistory] (spend history screen).
@Riverpod(keepAlive: true)
WatchSpendHistory watchSpendHistory(Ref ref) =>
    WatchSpendHistory(ref.watch(ledgerRepositoryProvider));

/// [GetWeekSummary] (screen 22).
@Riverpod(keepAlive: true)
GetWeekSummary getWeekSummary(Ref ref) => GetWeekSummary(
  ref.watch(ledgerRepositoryProvider),
  ref.watch(transactionRepositoryProvider),
  ref.watch(bucketRepositoryProvider),
  ref.watch(getCurrentCycleProvider),
  ref.watch(clockProvider),
);
