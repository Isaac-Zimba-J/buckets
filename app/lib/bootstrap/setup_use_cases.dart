import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets_data/buckets_data.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setup_use_cases.g.dart';

// Setup, home, goals and notifications:
// one provider per use case, wired from the port providers.

/// [GetSetupStatus] (screen 01).
@Riverpod(keepAlive: true)
GetSetupStatus getSetupStatus(Ref ref) =>
    GetSetupStatus(ref.watch(settingsRepositoryProvider));

/// [CompleteSetup] (screen 06).
@Riverpod(keepAlive: true)
CompleteSetup completeSetup(Ref ref) => CompleteSetup(
  ref.watch(accountRepositoryProvider),
  ref.watch(bucketRepositoryProvider),
  ref.watch(incomeRepositoryProvider),
  ref.watch(settingsRepositoryProvider),
  ref.watch(clockProvider),
);

/// [SaveNotificationPreferences] (screen 06).
@Riverpod(keepAlive: true)
SaveNotificationPreferences saveNotificationPreferences(Ref ref) =>
    SaveNotificationPreferences(ref.watch(settingsRepositoryProvider));

/// [SavePlanningPreferences] (Me tab).
@Riverpod(keepAlive: true)
SavePlanningPreferences savePlanningPreferences(Ref ref) =>
    SavePlanningPreferences(ref.watch(settingsRepositoryProvider));

/// [SetAppLock] (Me tab).
@Riverpod(keepAlive: true)
SetAppLock setAppLock(Ref ref) => SetAppLock(
  ref.watch(settingsRepositoryProvider),
  ref.watch(appLockProvider),
);

/// [UnlockApp] (the lock on launch and resume).
@Riverpod(keepAlive: true)
UnlockApp unlockApp(Ref ref) => UnlockApp(ref.watch(appLockProvider));

/// [GetPermissionStatus] (screen 06).
@Riverpod(keepAlive: true)
GetPermissionStatus getPermissionStatus(Ref ref) =>
    GetPermissionStatus(ref.watch(permissionGatewayProvider));

/// [RequestNotificationPermission] (screen 06).
@Riverpod(keepAlive: true)
RequestNotificationPermission requestNotificationPermission(Ref ref) =>
    RequestNotificationPermission(ref.watch(permissionGatewayProvider));

/// [OpenNotificationAccessSettings] (screen 06).
@Riverpod(keepAlive: true)
OpenNotificationAccessSettings openNotificationAccessSettings(Ref ref) =>
    OpenNotificationAccessSettings(ref.watch(permissionGatewayProvider));

/// [SaveIncomeSource] (screen 02).
@Riverpod(keepAlive: true)
SaveIncomeSource saveIncomeSource(Ref ref) => SaveIncomeSource(
  ref.watch(incomeRepositoryProvider),
  ref.watch(splitProfileRepositoryProvider),
  ref.watch(bucketRepositoryProvider),
  ref.watch(settingsRepositoryProvider),
  ref.watch(idsProvider),
);

/// [ListIncomeSources] (screen 02).
@Riverpod(keepAlive: true)
ListIncomeSources listIncomeSources(Ref ref) =>
    ListIncomeSources(ref.watch(incomeRepositoryProvider));

/// [SaveBill] (screen 03).
@Riverpod(keepAlive: true)
SaveBill saveBill(Ref ref) => SaveBill(
  ref.watch(billRepositoryProvider),
  ref.watch(bucketRepositoryProvider),
  ref.watch(idsProvider),
);

/// [DeleteBill] (screen 03).
@Riverpod(keepAlive: true)
DeleteBill deleteBill(Ref ref) => DeleteBill(ref.watch(billRepositoryProvider));

/// [ListBills] (screen 03).
@Riverpod(keepAlive: true)
ListBills listBills(Ref ref) => ListBills(ref.watch(billRepositoryProvider));

/// [GetBillReservations] (screen 03).
@Riverpod(keepAlive: true)
GetBillReservations getBillReservations(Ref ref) => GetBillReservations(
  ref.watch(billRepositoryProvider),
  ref.watch(ledgerRepositoryProvider),
  ref.watch(incomeRepositoryProvider),
  ref.watch(clockProvider),
  ref.watch(localTimeZoneProvider),
  ref.watch(paydayRepositoryProvider),
);

/// [PreviewSplit] (screen 04).
@Riverpod(keepAlive: true)
PreviewSplit previewSplit(Ref ref) => const PreviewSplit();

/// [SaveSplitProfile] (screen 04).
@Riverpod(keepAlive: true)
SaveSplitProfile saveSplitProfile(Ref ref) =>
    SaveSplitProfile(ref.watch(splitProfileRepositoryProvider));

/// [SaveAccount] (screen 05).
@Riverpod(keepAlive: true)
SaveAccount saveAccount(Ref ref) =>
    SaveAccount(ref.watch(accountRepositoryProvider), ref.watch(idsProvider));

/// [ListBucketsWithAccounts] (screen 05).
@Riverpod(keepAlive: true)
ListBucketsWithAccounts listBucketsWithAccounts(Ref ref) =>
    ListBucketsWithAccounts(
      ref.watch(bucketRepositoryProvider),
      ref.watch(accountRepositoryProvider),
    );

/// [AssignBucketAccount] (screen 05).
@Riverpod(keepAlive: true)
AssignBucketAccount assignBucketAccount(Ref ref) => AssignBucketAccount(
  ref.watch(bucketRepositoryProvider),
  ref.watch(accountRepositoryProvider),
);

/// [FirstRunSeed] (screen first run).
@Riverpod(keepAlive: true)
FirstRunSeed firstRunSeed(Ref ref) => FirstRunSeed(
  accounts: ref.watch(accountRepositoryProvider),
  buckets: ref.watch(bucketRepositoryProvider),
  settings: ref.watch(settingsRepositoryProvider),
  ids: ref.watch(idsProvider),
);

/// [GetCurrentCycle] (screen shared).
@Riverpod(keepAlive: true)
GetCurrentCycle getCurrentCycle(Ref ref) => GetCurrentCycle(
  ref.watch(incomeRepositoryProvider),
  ref.watch(paydayRepositoryProvider),
  ref.watch(settingsRepositoryProvider),
  ref.watch(clockProvider),
  ref.watch(localTimeZoneProvider),
);

/// [WatchHome] (screen 07-08).
@Riverpod(keepAlive: true)
WatchHome watchHome(Ref ref) => WatchHome(
  ledger: ref.watch(ledgerRepositoryProvider),
  buckets: ref.watch(bucketRepositoryProvider),
  paydays: ref.watch(paydayRepositoryProvider),
  alerts: ref.watch(alertRepositoryProvider),
  transactions: ref.watch(transactionRepositoryProvider),
  cycle: ref.watch(getCurrentCycleProvider),
);

/// [GetNextPayday] (screen 07).
@Riverpod(keepAlive: true)
GetNextPayday getNextPayday(Ref ref) =>
    GetNextPayday(ref.watch(getCurrentCycleProvider));

/// [WatchBucket] (screen 09).
@Riverpod(keepAlive: true)
WatchBucket watchBucket(Ref ref) => WatchBucket(
  ref.watch(bucketRepositoryProvider),
  ref.watch(ledgerRepositoryProvider),
);

/// [GetCoverOptions] (screen 09).
@Riverpod(keepAlive: true)
GetCoverOptions getCoverOptions(Ref ref) => GetCoverOptions(
  ref.watch(bucketRepositoryProvider),
  ref.watch(ledgerRepositoryProvider),
  ref.watch(paydayRepositoryProvider),
  ref.watch(incomeRepositoryProvider),
  ref.watch(clockProvider),
);

/// [CoverOverspend] (screen 09).
@Riverpod(keepAlive: true)
CoverOverspend coverOverspend(Ref ref) => CoverOverspend(
  ref.watch(ledgerRepositoryProvider),
  ref.watch(idsProvider),
  ref.watch(clockProvider),
);

/// [CreateGoal] (screen 10).
@Riverpod(keepAlive: true)
CreateGoal createGoal(Ref ref) => CreateGoal(
  ref.watch(bucketRepositoryProvider),
  ref.watch(goalRepositoryProvider),
  ref.watch(idsProvider),
);

/// [WatchGoals] (screen 10).
@Riverpod(keepAlive: true)
WatchGoals watchGoals(Ref ref) => WatchGoals(
  goals: ref.watch(goalRepositoryProvider),
  buckets: ref.watch(bucketRepositoryProvider),
  ledger: ref.watch(ledgerRepositoryProvider),
  incomes: ref.watch(incomeRepositoryProvider),
  profiles: ref.watch(splitProfileRepositoryProvider),
  paydays: ref.watch(paydayRepositoryProvider),
  reservations: ref.watch(getBillReservationsProvider),
  clock: ref.watch(clockProvider),
  zone: ref.watch(localTimeZoneProvider),
);

/// [GetSavingsStats] (screen 10).
@Riverpod(keepAlive: true)
GetSavingsStats getSavingsStats(Ref ref) => GetSavingsStats(
  ref.watch(bucketRepositoryProvider),
  ref.watch(ledgerRepositoryProvider),
  ref.watch(getCurrentCycleProvider),
);

/// [ScheduleNotifications] (screen 12).
@Riverpod(keepAlive: true)
ScheduleNotifications scheduleNotifications(Ref ref) => ScheduleNotifications(
  scheduler: ref.watch(notificationSchedulerProvider),
  paydays: ref.watch(paydayRepositoryProvider),
  alerts: ref.watch(alertRepositoryProvider),
  bills: ref.watch(billRepositoryProvider),
  planning: ref.watch(planningRepositoryProvider),
  settings: ref.watch(settingsRepositoryProvider),
  ledger: ref.watch(ledgerRepositoryProvider),
  buckets: ref.watch(bucketRepositoryProvider),
  cycle: ref.watch(getCurrentCycleProvider),
  clock: ref.watch(clockProvider),
  zone: ref.watch(localTimeZoneProvider),
);
