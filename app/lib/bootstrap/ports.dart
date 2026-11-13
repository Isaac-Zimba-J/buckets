import 'package:buckets/bootstrap/notification_copy.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/buckets_data.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ports.g.dart';

// Every port wired to its production implementation (ARCHITECTURE §3).
// Tests and demo mode override these with the fakes from
// package:buckets_data/fakes.dart (see overrides.dart).

/// English strings outside a widget, for notification copy.
@Riverpod(keepAlive: true)
AppLocalizations strings(Ref ref) => lookupAppLocalizations(const Locale('en'));

/// The one database file.
@Riverpod(keepAlive: true)
BucketsDatabase database(Ref ref) {
  final db = openBucketsDatabase();
  ref.onDispose(db.close);
  return db;
}

/// The device time zone; `main()` overrides it after loading it.
@Riverpod(keepAlive: true)
LocalTimeZone localTimeZone(Ref ref) =>
    ZoneTimeZone.named(ZoneTimeZone.fallback);

/// The only clock.
@Riverpod(keepAlive: true)
Clock clock(Ref ref) => const SystemClock();

/// The only ID source.
@Riverpod(keepAlive: true)
IdGenerator ids(Ref ref) => const UuidGenerator();

/// Accounts.
@Riverpod(keepAlive: true)
AccountRepository accountRepository(Ref ref) =>
    DriftAccountRepository(ref.watch(databaseProvider));

/// Buckets.
@Riverpod(keepAlive: true)
BucketRepository bucketRepository(Ref ref) =>
    DriftBucketRepository(ref.watch(databaseProvider));

/// Income sources.
@Riverpod(keepAlive: true)
IncomeRepository incomeRepository(Ref ref) =>
    DriftIncomeRepository(ref.watch(databaseProvider));

/// Split profiles.
@Riverpod(keepAlive: true)
SplitProfileRepository splitProfileRepository(Ref ref) =>
    DriftSplitProfileRepository(ref.watch(databaseProvider));

/// Bills.
@Riverpod(keepAlive: true)
BillRepository billRepository(Ref ref) =>
    DriftBillRepository(ref.watch(databaseProvider));

/// Bill occurrences (DOC-03).
@Riverpod(keepAlive: true)
BillOccurrenceRepository billOccurrenceRepository(Ref ref) =>
    DriftBillOccurrenceRepository(ref.watch(databaseProvider));

/// Fee rates (DOC-03).
@Riverpod(keepAlive: true)
FeeTariffRepository feeTariffRepository(Ref ref) =>
    DriftFeeTariffRepository(ref.watch(databaseProvider));

/// Settings.
@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) =>
    DriftSettingsRepository(ref.watch(databaseProvider));

/// The ledger.
@Riverpod(keepAlive: true)
LedgerRepository ledgerRepository(Ref ref) =>
    DriftLedgerRepository(ref.watch(databaseProvider));

/// Paydays.
@Riverpod(keepAlive: true)
PaydayRepository paydayRepository(Ref ref) =>
    DriftPaydayRepository(ref.watch(databaseProvider));

/// Side-hustle money held until month end.
@Riverpod(keepAlive: true)
HeldIncomeRepository heldIncomeRepository(Ref ref) =>
    DriftHeldIncomeRepository(ref.watch(databaseProvider));

/// Goals.
@Riverpod(keepAlive: true)
GoalRepository goalRepository(Ref ref) =>
    DriftGoalRepository(ref.watch(databaseProvider));

/// Check-ins.
@Riverpod(keepAlive: true)
CheckInRepository checkInRepository(Ref ref) =>
    DriftCheckInRepository(ref.watch(databaseProvider));

/// Payment alerts.
@Riverpod(keepAlive: true)
AlertRepository alertRepository(Ref ref) =>
    DriftAlertRepository(ref.watch(databaseProvider));

/// Transactions and withdrawals.
@Riverpod(keepAlive: true)
TransactionRepository transactionRepository(Ref ref) =>
    DriftTransactionRepository(ref.watch(databaseProvider));

/// Merchant rules.
@Riverpod(keepAlive: true)
MerchantRuleRepository merchantRuleRepository(Ref ref) =>
    DriftMerchantRuleRepository(ref.watch(databaseProvider));

/// Scanned receipts.
@Riverpod(keepAlive: true)
ReceiptRepository receiptRepository(Ref ref) =>
    DriftReceiptRepository(ref.watch(databaseProvider));

/// Planned purchases and wishes.
@Riverpod(keepAlive: true)
PlanningRepository planningRepository(Ref ref) =>
    DriftPlanningRepository(ref.watch(databaseProvider));

/// The native payment-notification listener (DA-08).
@Riverpod(keepAlive: true)
AndroidPaymentAlertSource androidAlertSource(Ref ref) =>
    AndroidPaymentAlertSource();

/// Captured payment notifications.
@Riverpod(keepAlive: true)
PaymentAlertSource paymentAlertSource(Ref ref) =>
    ref.watch(androidAlertSourceProvider);

/// The local notifications plugin.
@Riverpod(keepAlive: true)
NotificationsApi notificationsApi(Ref ref) => PluginNotificationsApi();

/// Shows and schedules notifications.
@Riverpod(keepAlive: true)
NotificationScheduler notificationScheduler(Ref ref) {
  final strings = ref.watch(stringsProvider);
  return LocalNotificationScheduler(
    copy: notificationCopy(strings),
    channelNames: channelNames(strings),
    clock: ref.watch(clockProvider),
    api: ref.watch(notificationsApiProvider),
  );
}

/// Permissions (screen 06).
@Riverpod(keepAlive: true)
PermissionGateway permissionGateway(Ref ref) => PlatformPermissionGateway(
  notifications: ref.watch(notificationsApiProvider),
  alerts: ref.watch(androidAlertSourceProvider),
);

/// On-device OCR.
@Riverpod(keepAlive: true)
TextRecognizer textRecognizer(Ref ref) => MlKitTextRecognizer();

/// Receipt OCR text parser: blocked on receipt fixtures (Open question 10).
@Riverpod(keepAlive: true)
ReceiptTextParser receiptTextParser(Ref ref) =>
    throw UnimplementedError('ReceiptTextParser waits for receipt fixtures');

/// Camera and gallery.
@Riverpod(keepAlive: true)
ImageCapture imageCapture(Ref ref) =>
    ImagePickerCapture(ids: ref.watch(idsProvider));

/// The app lock.
@Riverpod(keepAlive: true)
AppLock appLock(Ref ref) =>
    LocalAuthAppLock(reason: ref.watch(stringsProvider).appLockReason);

/// The local profile.
@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) =>
    DriftProfileRepository(ref.watch(databaseProvider));

/// Spending categories.
@Riverpod(keepAlive: true)
CategoryRepository categoryRepository(Ref ref) =>
    DriftCategoryRepository(ref.watch(databaseProvider));

/// Bundled help content.
@Riverpod(keepAlive: true)
HelpContentRepository helpContentRepository(Ref ref) =>
    BundledHelpContentRepository(ref.watch(databaseProvider));

/// On-device storage facts (Data & privacy).
@Riverpod(keepAlive: true)
StorageManager storageManager(Ref ref) =>
    DriftStorageManager(ref.watch(databaseProvider));

/// Wipes all data for Delete all data (R-PRIV-4).
@Riverpod(keepAlive: true)
DataWiper dataWiper(Ref ref) => DriftDataWiper(
  ref.watch(databaseProvider),
  ref.watch(notificationSchedulerProvider),
  photos: ImagePickerPhotoApi(),
);

/// The device time zone id (About you).
@Riverpod(keepAlive: true)
DeviceTimeZone deviceTimeZone(Ref ref) => const PlatformDeviceTimeZone();

/// Opens the email app for a problem report.
@Riverpod(keepAlive: true)
EmailComposer emailComposer(Ref ref) => PlatformEmailComposer();

/// Opens system and store screens from help and about.
@Riverpod(keepAlive: true)
SystemSettingsOpener systemSettingsOpener(Ref ref) =>
    PlatformSystemSettingsOpener();

/// Reads the whitelisted app and device facts.
@Riverpod(keepAlive: true)
AppInfoReader appInfoReader(Ref ref) => PlatformAppInfoReader();

/// SMS templates: none until fixtures exist (D-06a/b, Open question 1).
@Riverpod(keepAlive: true)
SmsParser smsParser(Ref ref) => const SmsParser([]);

/// Android package → provider for captured notifications (Open question 2).
@Riverpod(keepAlive: true)
Map<String, AlertSource> packageSources(Ref ref) => const {};
