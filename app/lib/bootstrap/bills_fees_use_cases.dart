import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bills_fees_use_cases.g.dart';

// Bills and transaction-fee use cases (SCREENS 33–37, payday fees), one
// provider per use case, wired from the port providers.

/// [EnsureBillOccurrences] (screen 33).
@Riverpod(keepAlive: true)
EnsureBillOccurrences ensureBillOccurrences(Ref ref) => EnsureBillOccurrences(
  ref.watch(billRepositoryProvider),
  ref.watch(billOccurrenceRepositoryProvider),
  ref.watch(getCurrentCycleProvider),
  ref.watch(clockProvider),
  ref.watch(localTimeZoneProvider),
  ref.watch(idsProvider),
);

/// [GetBillsCycle] (screen 33).
@Riverpod(keepAlive: true)
GetBillsCycle getBillsCycle(Ref ref) => GetBillsCycle(
  ref.watch(billOccurrenceRepositoryProvider),
  ref.watch(getBillReservationsProvider),
  ref.watch(getCurrentCycleProvider),
  ref.watch(transactionRepositoryProvider),
  ref.watch(clockProvider),
  ref.watch(localTimeZoneProvider),
);

/// [WatchBillsCycle] (screen 33).
@Riverpod(keepAlive: true)
WatchBillsCycle watchBillsCycle(Ref ref) => WatchBillsCycle(
  ref.watch(billOccurrenceRepositoryProvider),
  ref.watch(getBillsCycleProvider),
);

/// [MarkBillPaid] (screen 34).
@Riverpod(keepAlive: true)
MarkBillPaid markBillPaid(Ref ref) => MarkBillPaid(
  ref.watch(billOccurrenceRepositoryProvider),
  ref.watch(billRepositoryProvider),
  ref.watch(bucketRepositoryProvider),
  ref.watch(accountRepositoryProvider),
  ref.watch(feeTariffRepositoryProvider),
  ref.watch(spendWriterProvider),
  ref.watch(clockProvider),
  ref.watch(idsProvider),
);

/// [WatchBillHistory] (screen 35).
@Riverpod(keepAlive: true)
WatchBillHistory watchBillHistory(Ref ref) =>
    WatchBillHistory(ref.watch(billOccurrenceRepositoryProvider));

/// [GetBillStats] (screen 35).
@Riverpod(keepAlive: true)
GetBillStats getBillStats(Ref ref) => GetBillStats(
  ref.watch(billOccurrenceRepositoryProvider),
  ref.watch(clockProvider),
  ref.watch(localTimeZoneProvider),
);

/// [EstimateFee] (screens 34, 13).
@Riverpod(keepAlive: true)
EstimateFee estimateFee(Ref ref) =>
    EstimateFee(ref.watch(feeTariffRepositoryProvider));

/// [LearnFee] (screens 14, 34).
@Riverpod(keepAlive: true)
LearnFee learnFee(Ref ref) => LearnFee(ref.watch(feeTariffRepositoryProvider));

/// [SaveFeeBand] (screen 37).
@Riverpod(keepAlive: true)
SaveFeeBand saveFeeBand(Ref ref) =>
    SaveFeeBand(ref.watch(feeTariffRepositoryProvider));

/// [DeleteFeeBand] (screen 37).
@Riverpod(keepAlive: true)
DeleteFeeBand deleteFeeBand(Ref ref) =>
    DeleteFeeBand(ref.watch(feeTariffRepositoryProvider));

/// [ResolveFeeChange] (screen 37).
@Riverpod(keepAlive: true)
ResolveFeeChange resolveFeeChange(Ref ref) =>
    ResolveFeeChange(ref.watch(feeTariffRepositoryProvider));

/// [WatchFeeTariffs] (screen 37).
@Riverpod(keepAlive: true)
WatchFeeTariffs watchFeeTariffs(Ref ref) =>
    WatchFeeTariffs(ref.watch(feeTariffRepositoryProvider));

/// [GetFeesSummary] (screen 36).
@Riverpod(keepAlive: true)
GetFeesSummary getFeesSummary(Ref ref) => GetFeesSummary(
  ref.watch(transactionRepositoryProvider),
  ref.watch(getCurrentCycleProvider),
  ref.watch(incomeRepositoryProvider),
  ref.watch(paydayRepositoryProvider),
);

/// [WatchFeesSummary] (screen 36).
@Riverpod(keepAlive: true)
WatchFeesSummary watchFeesSummary(Ref ref) => WatchFeesSummary(
  ref.watch(transactionRepositoryProvider),
  ref.watch(getFeesSummaryProvider),
);

/// [ListMissingFees] (screen 36).
@Riverpod(keepAlive: true)
ListMissingFees listMissingFees(Ref ref) => ListMissingFees(
  ref.watch(transactionRepositoryProvider),
  ref.watch(getCurrentCycleProvider),
);

/// [EstimatePaydayFees] (screen 13).
@Riverpod(keepAlive: true)
EstimatePaydayFees estimatePaydayFees(Ref ref) => EstimatePaydayFees(
  ref.watch(paydayRepositoryProvider),
  ref.watch(incomeRepositoryProvider),
  ref.watch(accountRepositoryProvider),
  ref.watch(feeTariffRepositoryProvider),
  ref.watch(transactionRepositoryProvider),
  ref.watch(clockProvider),
);

/// [RecordTransferFee] (screen 14).
@Riverpod(keepAlive: true)
RecordTransferFee recordTransferFee(Ref ref) => RecordTransferFee(
  ref.watch(paydayRepositoryProvider),
  ref.watch(incomeRepositoryProvider),
  ref.watch(accountRepositoryProvider),
  ref.watch(bucketRepositoryProvider),
  ref.watch(feeTariffRepositoryProvider),
  ref.watch(learnFeeProvider),
  ref.watch(spendWriterProvider),
  ref.watch(clockProvider),
  ref.watch(idsProvider),
);
