/// Every screen the router can show. Screen numbers match the design canvas
/// and `docs/SCREENS.md`.
enum AppScreen {
  /// 01.
  welcome,

  /// 02, in setup and from Me.
  income,

  /// 03, in setup and from Me.
  bills,

  /// 04, in setup and from Me; needs `incomeId`.
  split,

  /// 05, in setup and from Me.
  accounts,

  /// 06, in setup and from Me.
  permissions,

  /// 07–08.
  home,

  /// 09; needs `bucketId`.
  bucket,

  /// 10.
  goals,

  /// 11; optional `tab` and `wish` query parameters.
  plan,

  /// 13; needs `paydayId`.
  payday,

  /// 14–15; needs `paydayId` and `transferId`.
  proof,

  /// 16; needs `paydayId`.
  paydayDone,

  /// 17; needs `alertId`.
  incomeReceived,

  /// 18.
  sort,

  /// 19.
  log,

  /// 20.
  scan,

  /// 21; needs `draftId`.
  receipt,

  /// 22.
  checkIn,

  /// Me tab.
  me,

  /// 01b, in setup and from Me.
  profile,

  /// 25.
  settings,

  /// 26.
  security,

  /// 27.
  dataPrivacy,

  /// 28.
  rules,

  /// 29.
  help,

  /// 30; needs `articleId`.
  helpArticle,

  /// 31.
  report,

  /// 32.
  about,
}

/// Every route path, declared once (ARCHITECTURE §11).
abstract final class Routes {
  /// 01.
  static const welcome = '/welcome';

  /// Paths under this prefix belong to first-run setup.
  static const setupPrefix = '/setup';

  /// 01b in setup.
  static const setupProfile = '/setup/profile';

  /// 02 in setup.
  static const setupIncome = '/setup/income';

  /// 03 in setup.
  static const setupBills = '/setup/bills';

  /// 04 in setup for [incomeId].
  static String setupSplit(String incomeId) => '/setup/split/$incomeId';

  /// 05 in setup.
  static const setupAccounts = '/setup/accounts';

  /// 06 in setup.
  static const setupPermissions = '/setup/permissions';

  /// 07–08.
  static const home = '/home';

  /// 09 for [bucketId].
  static String bucket(String bucketId) => '/bucket/$bucketId';

  /// 10.
  static const goals = '/goals';

  /// 11.
  static const plan = '/plan';

  /// 11 on the wishes tab with [wishId] in view.
  static String planWish(String wishId) => '/plan?tab=wishes&wish=$wishId';

  /// 13 for [paydayId].
  static String payday(String paydayId) => '/payday/$paydayId';

  /// 14–15 for one transfer of a payday.
  static String proof(String paydayId, String transferId) =>
      '/payday/$paydayId/proof/$transferId';

  /// 16 for [paydayId].
  static String paydayDone(String paydayId) => '/payday/$paydayId/done';

  /// Resolves to 17 or 18 depending on the alert's direction.
  static String alert(String alertId) => '/alert/$alertId';

  /// 17 for the incoming alert [alertId].
  static String incomeReceived(String alertId) => '/income/received/$alertId';

  /// 18.
  static const sort = '/sort';

  /// 19.
  static const log = '/log';

  /// 20.
  static const scan = '/log/scan';

  /// 21 for [draftId].
  static String receipt(String draftId) => '/log/receipt/$draftId';

  /// 22.
  static const checkIn = '/checkin';

  /// Me tab.
  static const me = '/me';

  /// 02 from Me.
  static const meIncome = '/me/income';

  /// 03 from Me.
  static const meBills = '/me/bills';

  /// 04 from Me for [incomeId].
  static String meSplit(String incomeId) => '/me/split/$incomeId';

  /// 05 from Me.
  static const meAccounts = '/me/accounts';

  /// 06 from Me.
  static const meNotifications = '/me/notifications';

  /// 01b from Me (edit profile).
  static const meProfile = '/me/profile';

  /// 24 → 25 Settings.
  static const meSettings = '/me/settings';

  /// 26 Security.
  static const meSecurity = '/me/settings/security';

  /// 27 Data & privacy.
  static const meData = '/me/settings/data';

  /// 28 Auto-filing rules.
  static const meRules = '/me/rules';

  /// 32 About.
  static const meAbout = '/me/about';

  /// 29 Help.
  static const help = '/help';

  /// 31 Report a problem.
  static const helpReport = '/help/report';

  /// 30 Help article [articleId].
  static String helpArticle(String articleId) => '/help/$articleId';

  /// Whether [path] is part of first-run setup.
  static bool isSetup(String path) =>
      path == welcome || path.startsWith('$setupPrefix/');
}
