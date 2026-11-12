import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'me_use_cases.g.dart';

// Profile, settings, help, support and about use cases (SCREENS 01b, 24–32),
// one provider per use case, wired from the port providers.

/// [SaveProfile] (screens 01b, 24).
@Riverpod(keepAlive: true)
SaveProfile saveProfile(Ref ref) =>
    SaveProfile(ref.watch(profileRepositoryProvider));

/// [GetDeviceTimeZone] (screen 01b).
@Riverpod(keepAlive: true)
GetDeviceTimeZone getDeviceTimeZone(Ref ref) =>
    GetDeviceTimeZone(ref.watch(deviceTimeZoneProvider));

/// [WatchProfileSummary] (screen 24).
@Riverpod(keepAlive: true)
WatchProfileSummary watchProfileSummary(Ref ref) =>
    WatchProfileSummary(ref.watch(profileRepositoryProvider));

/// [WatchSettings] (screen 25).
@Riverpod(keepAlive: true)
WatchSettings watchSettings(Ref ref) =>
    WatchSettings(ref.watch(settingsRepositoryProvider));

/// [SetLockTimeout] (screen 26).
@Riverpod(keepAlive: true)
SetLockTimeout setLockTimeout(Ref ref) =>
    SetLockTimeout(ref.watch(settingsRepositoryProvider));

/// [SetHideAmounts] (screen 26).
@Riverpod(keepAlive: true)
SetHideAmounts setHideAmounts(Ref ref) =>
    SetHideAmounts(ref.watch(settingsRepositoryProvider));

/// [SetBillReminders] (screen 25).
@Riverpod(keepAlive: true)
SetBillReminders setBillReminders(Ref ref) =>
    SetBillReminders(ref.watch(settingsRepositoryProvider));

/// [ClearAlertHistory] (screen 27).
@Riverpod(keepAlive: true)
ClearAlertHistory clearAlertHistory(Ref ref) => ClearAlertHistory(
  ref.watch(alertRepositoryProvider),
  ref.watch(clockProvider),
);

/// [GetStorageSummary] (screen 27).
@Riverpod(keepAlive: true)
GetStorageSummary getStorageSummary(Ref ref) =>
    GetStorageSummary(ref.watch(storageManagerProvider));

/// [WatchCategories] (screen 28).
@Riverpod(keepAlive: true)
WatchCategories watchCategories(Ref ref) =>
    WatchCategories(ref.watch(categoryRepositoryProvider));

/// [WatchMerchantRules] (screen 28).
@Riverpod(keepAlive: true)
WatchMerchantRules watchMerchantRules(Ref ref) =>
    WatchMerchantRules(ref.watch(merchantRuleRepositoryProvider));

/// [DeleteMerchantRule] (screen 28).
@Riverpod(keepAlive: true)
DeleteMerchantRule deleteMerchantRule(Ref ref) =>
    DeleteMerchantRule(ref.watch(merchantRuleRepositoryProvider));

/// [AddCategory] (screen 28).
@Riverpod(keepAlive: true)
AddCategory addCategory(Ref ref) =>
    AddCategory(ref.watch(categoryRepositoryProvider));

/// [RenameCategory] (screen 28).
@Riverpod(keepAlive: true)
RenameCategory renameCategory(Ref ref) =>
    RenameCategory(ref.watch(categoryRepositoryProvider));

/// [ArchiveCategory] (screen 28).
@Riverpod(keepAlive: true)
ArchiveCategory archiveCategory(Ref ref) =>
    ArchiveCategory(ref.watch(categoryRepositoryProvider));

/// [ListHelpArticles] (screen 29).
@Riverpod(keepAlive: true)
ListHelpArticles listHelpArticles(Ref ref) =>
    ListHelpArticles(ref.watch(helpContentRepositoryProvider));

/// [SearchHelp] (screen 29).
@Riverpod(keepAlive: true)
SearchHelp searchHelp(Ref ref) =>
    SearchHelp(ref.watch(helpContentRepositoryProvider));

/// [GetHelpArticle] (screen 30).
@Riverpod(keepAlive: true)
GetHelpArticle getHelpArticle(Ref ref) =>
    GetHelpArticle(ref.watch(helpContentRepositoryProvider));

/// [RecordArticleFeedback] (screen 30).
@Riverpod(keepAlive: true)
RecordArticleFeedback recordArticleFeedback(Ref ref) =>
    RecordArticleFeedback(ref.watch(helpContentRepositoryProvider));

/// [BuildProblemReport] (screen 31).
@Riverpod(keepAlive: true)
BuildProblemReport buildProblemReport(Ref ref) =>
    BuildProblemReport(ref.watch(appInfoReaderProvider));

/// [OpenEmailComposer] (screen 31).
@Riverpod(keepAlive: true)
OpenEmailComposer openEmailComposer(Ref ref) =>
    OpenEmailComposer(ref.watch(emailComposerProvider));

/// [GetAppInfo] (screen 32).
@Riverpod(keepAlive: true)
GetAppInfo getAppInfo(Ref ref) => GetAppInfo(ref.watch(appInfoReaderProvider));

/// [OpenStoreListing] (screen 32).
@Riverpod(keepAlive: true)
OpenStoreListing openStoreListing(Ref ref) =>
    OpenStoreListing(ref.watch(systemSettingsOpenerProvider));

/// [OpenBatterySettings] (screen 30).
@Riverpod(keepAlive: true)
OpenBatterySettings openBatterySettings(Ref ref) =>
    OpenBatterySettings(ref.watch(systemSettingsOpenerProvider));
