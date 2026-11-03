import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_riverpod/misc.dart' show Override;

/// Every port on an in-memory fake: for controller tests and demo mode.
/// Nothing touches the database, the plugins or the network.
/// Pass a fake to keep a handle on it in tests.
List<Override> fakePortOverrides({
  Clock? clock,
  TextRecognizer? textRecognizer,
  ReceiptTextParser? receiptParser,
  ImageCapture? imageCapture,
}) => [
  clockProvider.overrideWithValue(
    clock ?? FakeClock(DateTime.utc(2026, 10, 25, 6)),
  ),
  localTimeZoneProvider.overrideWithValue(LusakaTimeZone()),
  accountRepositoryProvider.overrideWithValue(InMemoryAccountRepository()),
  bucketRepositoryProvider.overrideWithValue(InMemoryBucketRepository()),
  incomeRepositoryProvider.overrideWithValue(InMemoryIncomeRepository()),
  splitProfileRepositoryProvider.overrideWithValue(
    InMemorySplitProfileRepository(),
  ),
  billRepositoryProvider.overrideWithValue(InMemoryBillRepository()),
  settingsRepositoryProvider.overrideWithValue(InMemorySettingsRepository()),
  ledgerRepositoryProvider.overrideWithValue(InMemoryLedgerRepository()),
  paydayRepositoryProvider.overrideWithValue(InMemoryPaydayRepository()),
  heldIncomeRepositoryProvider.overrideWithValue(
    InMemoryHeldIncomeRepository(),
  ),
  goalRepositoryProvider.overrideWithValue(InMemoryGoalRepository()),
  checkInRepositoryProvider.overrideWithValue(InMemoryCheckInRepository()),
  alertRepositoryProvider.overrideWithValue(InMemoryAlertRepository()),
  transactionRepositoryProvider.overrideWithValue(
    InMemoryTransactionRepository(),
  ),
  merchantRuleRepositoryProvider.overrideWithValue(
    InMemoryMerchantRuleRepository(),
  ),
  receiptRepositoryProvider.overrideWithValue(InMemoryReceiptRepository()),
  planningRepositoryProvider.overrideWithValue(InMemoryPlanningRepository()),
  paymentAlertSourceProvider.overrideWithValue(FakePaymentAlertSource()),
  notificationSchedulerProvider.overrideWithValue(FakeNotificationScheduler()),
  permissionGatewayProvider.overrideWithValue(FakePermissionGateway()),
  textRecognizerProvider.overrideWithValue(
    textRecognizer ?? FakeTextRecognizer(),
  ),
  receiptTextParserProvider.overrideWithValue(
    receiptParser ?? FakeReceiptTextParser(),
  ),
  imageCaptureProvider.overrideWithValue(imageCapture ?? FakeImageCapture()),
  appLockProvider.overrideWithValue(const _OpenLock()),
];

/// An app lock that is never set up, for tests and demo mode.
final class _OpenLock implements AppLock {
  const new();

  @override
  Future<Result<bool>> isAvailable() async => const Ok(false);

  @override
  Future<Result<bool>> authenticate() async => const Ok(true);
}
