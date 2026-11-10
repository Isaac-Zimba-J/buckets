import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Buckets'**
  String get appName;

  /// No description provided for @notifPaydayTitle.
  ///
  /// In en, this message translates to:
  /// **'Move your savings'**
  String get notifPaydayTitle;

  /// No description provided for @notifPaydayBody.
  ///
  /// In en, this message translates to:
  /// **'{pending, plural, =1{1 transfer still open. Prove it to unlock spending.} other{{pending} transfers still open. Prove them to unlock spending.}}'**
  String notifPaydayBody(int pending);

  /// No description provided for @notifAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{New payment} other{{count} new payments}}'**
  String notifAlertTitle(int count);

  /// No description provided for @notifAlertBody.
  ///
  /// In en, this message translates to:
  /// **'Tap to file it.'**
  String get notifAlertBody;

  /// No description provided for @notifIncomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Money received'**
  String get notifIncomeTitle;

  /// No description provided for @notifIncomeBody.
  ///
  /// In en, this message translates to:
  /// **'Side hustle money? Tap to split it.'**
  String get notifIncomeBody;

  /// No description provided for @notifBillTitle.
  ///
  /// In en, this message translates to:
  /// **'A bill is due soon'**
  String get notifBillTitle;

  /// No description provided for @notifBillBody.
  ///
  /// In en, this message translates to:
  /// **'It\'s due in 2 days. Check your bills.'**
  String get notifBillBody;

  /// No description provided for @notifWishTitle.
  ///
  /// In en, this message translates to:
  /// **'Cooling-off is over'**
  String get notifWishTitle;

  /// No description provided for @notifWishBody.
  ///
  /// In en, this message translates to:
  /// **'Still want it? Decide in Plan.'**
  String get notifWishBody;

  /// No description provided for @notifCheckInTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Sunday check-in'**
  String get notifCheckInTitle;

  /// No description provided for @notifCheckInBody.
  ///
  /// In en, this message translates to:
  /// **'Sort your payments, then count your cash.'**
  String get notifCheckInBody;

  /// No description provided for @notifLowTitle.
  ///
  /// In en, this message translates to:
  /// **'Living is running low'**
  String get notifLowTitle;

  /// No description provided for @notifLowBody.
  ///
  /// In en, this message translates to:
  /// **'Open Living to see what\'s left until payday.'**
  String get notifLowBody;

  /// No description provided for @channelPayday.
  ///
  /// In en, this message translates to:
  /// **'Payday alarm'**
  String get channelPayday;

  /// No description provided for @channelAlert.
  ///
  /// In en, this message translates to:
  /// **'Payments to file'**
  String get channelAlert;

  /// No description provided for @channelIncome.
  ///
  /// In en, this message translates to:
  /// **'Money received'**
  String get channelIncome;

  /// No description provided for @channelBill.
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get channelBill;

  /// No description provided for @channelWish.
  ///
  /// In en, this message translates to:
  /// **'Wishes'**
  String get channelWish;

  /// No description provided for @channelCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Weekly check-in'**
  String get channelCheckIn;

  /// No description provided for @channelLow.
  ///
  /// In en, this message translates to:
  /// **'Living running low'**
  String get channelLow;

  /// No description provided for @appLockReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock Buckets'**
  String get appLockReason;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'{step} of {total}'**
  String stepOf(int step, int total);

  /// No description provided for @errLoad.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load this. Try again.'**
  String get errLoad;

  /// No description provided for @errGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something isn\'t right. Check it and try again.'**
  String get errGeneric;

  /// No description provided for @errAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount above K 0.'**
  String get errAmount;

  /// No description provided for @errDay.
  ///
  /// In en, this message translates to:
  /// **'Pick a day from 1 to 31.'**
  String get errDay;

  /// No description provided for @errName.
  ///
  /// In en, this message translates to:
  /// **'Add a name.'**
  String get errName;

  /// No description provided for @errMatchKey.
  ///
  /// In en, this message translates to:
  /// **'Use at least 3 characters, like the last 4 digits.'**
  String get errMatchKey;

  /// No description provided for @errNoIncome.
  ///
  /// In en, this message translates to:
  /// **'Add the money you get first.'**
  String get errNoIncome;

  /// No description provided for @errSplitTotal.
  ///
  /// In en, this message translates to:
  /// **'The split must add up to 100%.'**
  String get errSplitTotal;

  /// No description provided for @errNextDue.
  ///
  /// In en, this message translates to:
  /// **'Pick when it\'s next due.'**
  String get errNextDue;

  /// No description provided for @accountKindBank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get accountKindBank;

  /// No description provided for @accountKindMtn.
  ///
  /// In en, this message translates to:
  /// **'MTN MoMo'**
  String get accountKindMtn;

  /// No description provided for @accountKindAirtel.
  ///
  /// In en, this message translates to:
  /// **'Airtel Money'**
  String get accountKindAirtel;

  /// No description provided for @accountKindCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get accountKindCash;

  /// No description provided for @accountKindInvestment.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get accountKindInvestment;

  /// No description provided for @accountKindOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get accountKindOther;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Split every payday before you spend it'**
  String get welcomeTitle;

  /// No description provided for @welcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Tell us what you earn and what your bills are. We split the rest into buckets and remind you to move the savings.'**
  String get welcomeBody;

  /// No description provided for @welcomeStart.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get welcomeStart;

  /// No description provided for @welcomePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Everything stays on this phone. No account, no internet.'**
  String get welcomePrivacy;

  /// No description provided for @incomeTitle.
  ///
  /// In en, this message translates to:
  /// **'What money do you get?'**
  String get incomeTitle;

  /// No description provided for @incomeName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get incomeName;

  /// No description provided for @incomeNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Salary'**
  String get incomeNameHint;

  /// No description provided for @incomeKindSalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get incomeKindSalary;

  /// No description provided for @incomeKindSideHustle.
  ///
  /// In en, this message translates to:
  /// **'Side hustle'**
  String get incomeKindSideHustle;

  /// No description provided for @incomeExpected.
  ///
  /// In en, this message translates to:
  /// **'How much, usually'**
  String get incomeExpected;

  /// No description provided for @incomePayday.
  ///
  /// In en, this message translates to:
  /// **'Payday (day of the month)'**
  String get incomePayday;

  /// No description provided for @incomePaydayHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 25'**
  String get incomePaydayHint;

  /// No description provided for @incomeLandsIn.
  ///
  /// In en, this message translates to:
  /// **'Lands in'**
  String get incomeLandsIn;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get choose;

  /// No description provided for @incomeSave.
  ///
  /// In en, this message translates to:
  /// **'Save income'**
  String get incomeSave;

  /// No description provided for @incomeYours.
  ///
  /// In en, this message translates to:
  /// **'Your income'**
  String get incomeYours;

  /// No description provided for @incomePaydayOn.
  ///
  /// In en, this message translates to:
  /// **'Payday on day {day}'**
  String incomePaydayOn(int day);

  /// No description provided for @incomeIrregular.
  ///
  /// In en, this message translates to:
  /// **'Comes when it comes'**
  String get incomeIrregular;

  /// No description provided for @accountSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Where does it land?'**
  String get accountSheetTitle;

  /// No description provided for @accountAdd.
  ///
  /// In en, this message translates to:
  /// **'Add account'**
  String get accountAdd;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account name'**
  String get accountName;

  /// No description provided for @accountNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Zanaco savings'**
  String get accountNameHint;

  /// No description provided for @accountMatchKey.
  ///
  /// In en, this message translates to:
  /// **'Last digits (optional)'**
  String get accountMatchKey;

  /// No description provided for @accountMatchKeyHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 4521'**
  String get accountMatchKeyHint;

  /// No description provided for @accountSpending.
  ///
  /// In en, this message translates to:
  /// **'Spending account'**
  String get accountSpending;

  /// No description provided for @accountSpendingSub.
  ///
  /// In en, this message translates to:
  /// **'Living and Guilt-free live here'**
  String get accountSpendingSub;

  /// No description provided for @billsTitle.
  ///
  /// In en, this message translates to:
  /// **'Fixed bills'**
  String get billsTitle;

  /// No description provided for @billsIntro.
  ///
  /// In en, this message translates to:
  /// **'Bills come off the top, before the split.'**
  String get billsIntro;

  /// No description provided for @billsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No bills yet'**
  String get billsEmptyTitle;

  /// No description provided for @billsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add rent, ZESCO or school fees. They\'re set aside first.'**
  String get billsEmptyBody;

  /// No description provided for @billsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add a bill'**
  String get billsAdd;

  /// No description provided for @billName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get billName;

  /// No description provided for @billNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Rent'**
  String get billNameHint;

  /// No description provided for @billAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get billAmount;

  /// No description provided for @billMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get billMonthly;

  /// No description provided for @billTermly.
  ///
  /// In en, this message translates to:
  /// **'Termly'**
  String get billTermly;

  /// No description provided for @billYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get billYearly;

  /// No description provided for @billDueDay.
  ///
  /// In en, this message translates to:
  /// **'Due day (of the month)'**
  String get billDueDay;

  /// No description provided for @billDueDayHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1'**
  String get billDueDayHint;

  /// No description provided for @billNextDue.
  ///
  /// In en, this message translates to:
  /// **'Next due'**
  String get billNextDue;

  /// No description provided for @billPickDate.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get billPickDate;

  /// No description provided for @billsTotal.
  ///
  /// In en, this message translates to:
  /// **'Set aside each payday'**
  String get billsTotal;

  /// No description provided for @billPutAside.
  ///
  /// In en, this message translates to:
  /// **'{putAside} of {amount} put aside'**
  String billPutAside(String putAside, String amount);

  /// No description provided for @billEach.
  ///
  /// In en, this message translates to:
  /// **'{amount} a month'**
  String billEach(String amount);

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @splitTitle.
  ///
  /// In en, this message translates to:
  /// **'Split what\'s left'**
  String get splitTitle;

  /// No description provided for @splitToSplit.
  ///
  /// In en, this message translates to:
  /// **'{amount} to split'**
  String splitToSplit(String amount);

  /// No description provided for @splitTotalOk.
  ///
  /// In en, this message translates to:
  /// **'{percent}% · adds up'**
  String splitTotalOk(int percent);

  /// No description provided for @splitTooMuch.
  ///
  /// In en, this message translates to:
  /// **'{percent}% · too much'**
  String splitTooMuch(int percent);

  /// No description provided for @splitTooLittle.
  ///
  /// In en, this message translates to:
  /// **'{percent}% · too little'**
  String splitTooLittle(int percent);

  /// No description provided for @splitBillsExceed.
  ///
  /// In en, this message translates to:
  /// **'Your bills are more than this income. Check your bills or the amount.'**
  String get splitBillsExceed;

  /// No description provided for @splitShare.
  ///
  /// In en, this message translates to:
  /// **'Share (%)'**
  String get splitShare;

  /// No description provided for @splitPerPayday.
  ///
  /// In en, this message translates to:
  /// **'{amount} each payday'**
  String splitPerPayday(String amount);

  /// No description provided for @accountsTitle.
  ///
  /// In en, this message translates to:
  /// **'Where buckets live'**
  String get accountsTitle;

  /// No description provided for @accountsInfo.
  ///
  /// In en, this message translates to:
  /// **'Pick where each bucket\'s money really sits. Proof checks look for this account.'**
  String get accountsInfo;

  /// No description provided for @accountsLater.
  ///
  /// In en, this message translates to:
  /// **'Set the rest later'**
  String get accountsLater;

  /// No description provided for @accountsPick.
  ///
  /// In en, this message translates to:
  /// **'Where does {bucket} live?'**
  String accountsPick(String bucket);

  /// No description provided for @permsTitle.
  ///
  /// In en, this message translates to:
  /// **'Alarms and alerts'**
  String get permsTitle;

  /// No description provided for @permsInfo.
  ///
  /// In en, this message translates to:
  /// **'Buckets reads payment alerts on this phone only. Nothing leaves it.'**
  String get permsInfo;

  /// No description provided for @permNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get permNotifications;

  /// No description provided for @permNotificationsSub.
  ///
  /// In en, this message translates to:
  /// **'Payday alarm and reminders'**
  String get permNotificationsSub;

  /// No description provided for @permAccess.
  ///
  /// In en, this message translates to:
  /// **'Payment alerts'**
  String get permAccess;

  /// No description provided for @permAccessSub.
  ///
  /// In en, this message translates to:
  /// **'Read MoMo, Airtel and bank alerts'**
  String get permAccessSub;

  /// No description provided for @permExact.
  ///
  /// In en, this message translates to:
  /// **'Exact alarms'**
  String get permExact;

  /// No description provided for @permExactSub.
  ///
  /// In en, this message translates to:
  /// **'Ring on time on payday'**
  String get permExactSub;

  /// No description provided for @permsDenied.
  ///
  /// In en, this message translates to:
  /// **'Some permissions are off. Turn them on in Settings.'**
  String get permsDenied;

  /// No description provided for @permsOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get permsOpenSettings;

  /// No description provided for @permsFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish setup'**
  String get permsFinish;

  /// No description provided for @incomeNeedAccount.
  ///
  /// In en, this message translates to:
  /// **'Choose where it lands first.'**
  String get incomeNeedAccount;

  /// No description provided for @errNoSpending.
  ///
  /// In en, this message translates to:
  /// **'Add a spending account first: where Living and Guilt-free money lives.'**
  String get errNoSpending;

  /// No description provided for @errManySpending.
  ///
  /// In en, this message translates to:
  /// **'Only one account can be the spending account. Turn it off on the others.'**
  String get errManySpending;

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabGoals.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get tabGoals;

  /// No description provided for @tabPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get tabPlan;

  /// No description provided for @tabMe.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get tabMe;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Muli shani'**
  String get homeGreeting;

  /// No description provided for @homeTitleFirstRun.
  ///
  /// In en, this message translates to:
  /// **'Payday is coming'**
  String get homeTitleFirstRun;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Your money'**
  String get homeTitle;

  /// No description provided for @homeLog.
  ///
  /// In en, this message translates to:
  /// **'Log a payment'**
  String get homeLog;

  /// No description provided for @homeToSort.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No payments to sort} =1{1 payment to sort} other{{count} payments to sort}}'**
  String homeToSort(int count);

  /// No description provided for @homePaydayIn.
  ///
  /// In en, this message translates to:
  /// **'{days, plural, =0{Payday is today} =1{Payday is tomorrow} other{Payday in {days} days}}'**
  String homePaydayIn(int days);

  /// No description provided for @homeNoPayday.
  ///
  /// In en, this message translates to:
  /// **'Your buckets fill when money comes in'**
  String get homeNoPayday;

  /// No description provided for @homeFirstRunBody.
  ///
  /// In en, this message translates to:
  /// **'On payday we split your money into these buckets and remind you to move the savings.'**
  String get homeFirstRunBody;

  /// No description provided for @homePaydayBanner.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 transfer to move} other{{count} transfers to move}}'**
  String homePaydayBanner(int count);

  /// No description provided for @homePaydayBannerBody.
  ///
  /// In en, this message translates to:
  /// **'{amount} still to move. Prove it to unlock spending.'**
  String homePaydayBannerBody(String amount);

  /// No description provided for @homeLivingLeft.
  ///
  /// In en, this message translates to:
  /// **'Living left'**
  String get homeLivingLeft;

  /// No description provided for @homePerDay.
  ///
  /// In en, this message translates to:
  /// **'About {amount} a day until payday'**
  String homePerDay(String amount);

  /// No description provided for @homeGuiltFree.
  ///
  /// In en, this message translates to:
  /// **'Guilt-free'**
  String get homeGuiltFree;

  /// No description provided for @homeLocked.
  ///
  /// In en, this message translates to:
  /// **'Living and Guilt-free unlock when your transfers are done.'**
  String get homeLocked;

  /// No description provided for @homeRecent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get homeRecent;

  /// No description provided for @homeRecentEmpty.
  ///
  /// In en, this message translates to:
  /// **'No payments yet. Log one with +.'**
  String get homeRecentEmpty;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @sortTitle.
  ///
  /// In en, this message translates to:
  /// **'What was this?'**
  String get sortTitle;

  /// No description provided for @sortFile.
  ///
  /// In en, this message translates to:
  /// **'File it'**
  String get sortFile;

  /// No description provided for @sortSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get sortSkip;

  /// No description provided for @sortPickBoth.
  ///
  /// In en, this message translates to:
  /// **'Pick what it was and which bucket paid.'**
  String get sortPickBoth;

  /// No description provided for @sortAlways.
  ///
  /// In en, this message translates to:
  /// **'Always file {who} like this'**
  String sortAlways(String who);

  /// No description provided for @sortRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Last one} =1{1 more to sort} other{{count} more to sort}}'**
  String sortRemaining(int count);

  /// No description provided for @sortLast.
  ///
  /// In en, this message translates to:
  /// **'Last one'**
  String get sortLast;

  /// No description provided for @sortDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'All sorted'**
  String get sortDoneTitle;

  /// No description provided for @sortDoneBody.
  ///
  /// In en, this message translates to:
  /// **'Every payment is filed. New ones show up here.'**
  String get sortDoneBody;

  /// No description provided for @logTitle.
  ///
  /// In en, this message translates to:
  /// **'Log a payment'**
  String get logTitle;

  /// No description provided for @logScan.
  ///
  /// In en, this message translates to:
  /// **'Scan a receipt'**
  String get logScan;

  /// No description provided for @logCash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get logCash;

  /// No description provided for @logPaste.
  ///
  /// In en, this message translates to:
  /// **'Paste message'**
  String get logPaste;

  /// No description provided for @logMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment message'**
  String get logMessage;

  /// No description provided for @logMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Paste the MoMo or bank SMS'**
  String get logMessageHint;

  /// No description provided for @logReadAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount read from the message'**
  String get logReadAmount;

  /// No description provided for @logWishTitle.
  ///
  /// In en, this message translates to:
  /// **'A big buy?'**
  String get logWishTitle;

  /// No description provided for @logWishBody.
  ///
  /// In en, this message translates to:
  /// **'Add it to your wishes and wait 48 hours before you buy.'**
  String get logWishBody;

  /// No description provided for @logCategory.
  ///
  /// In en, this message translates to:
  /// **'What was it?'**
  String get logCategory;

  /// No description provided for @logBucket.
  ///
  /// In en, this message translates to:
  /// **'Which bucket paid?'**
  String get logBucket;

  /// No description provided for @logNote.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get logNote;

  /// No description provided for @logNoteHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. bus to town and back'**
  String get logNoteHint;

  /// No description provided for @logSaved.
  ///
  /// In en, this message translates to:
  /// **'Payment saved'**
  String get logSaved;

  /// No description provided for @scanHint.
  ///
  /// In en, this message translates to:
  /// **'Hold the receipt flat in good light, then take the photo.'**
  String get scanHint;

  /// No description provided for @scanNoText.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t read any text. Retake it in better light.'**
  String get scanNoText;

  /// No description provided for @scanNoCamera.
  ///
  /// In en, this message translates to:
  /// **'Buckets can\'t use the camera. Allow it in Settings, or pick a photo instead.'**
  String get scanNoCamera;

  /// No description provided for @scanGallery.
  ///
  /// In en, this message translates to:
  /// **'Pick a photo'**
  String get scanGallery;

  /// No description provided for @scanShutter.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get scanShutter;

  /// No description provided for @scanRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get scanRetake;

  /// No description provided for @receiptTitle.
  ///
  /// In en, this message translates to:
  /// **'Check the receipt'**
  String get receiptTitle;

  /// No description provided for @receiptUnknownShop.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get receiptUnknownShop;

  /// No description provided for @receiptCheckTotal.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t read the total. Please check it.'**
  String get receiptCheckTotal;

  /// No description provided for @receiptUseTotal.
  ///
  /// In en, this message translates to:
  /// **'Use this total'**
  String get receiptUseTotal;

  /// No description provided for @receiptItemsOff.
  ///
  /// In en, this message translates to:
  /// **'The items are {amount} off the total. Check them or the total.'**
  String receiptItemsOff(String amount);

  /// No description provided for @receiptItemsMatch.
  ///
  /// In en, this message translates to:
  /// **'The items add up to the total.'**
  String get receiptItemsMatch;

  /// No description provided for @receiptNotReady.
  ///
  /// In en, this message translates to:
  /// **'Check the total, then pick what it was and the bucket.'**
  String get receiptNotReady;

  /// No description provided for @paydayDate.
  ///
  /// In en, this message translates to:
  /// **'Payday · {date}'**
  String paydayDate(String date);

  /// No description provided for @paydayAlarmRepeats.
  ///
  /// In en, this message translates to:
  /// **'Alarm repeats every 30 min'**
  String get paydayAlarmRepeats;

  /// No description provided for @paydayHeadline.
  ///
  /// In en, this message translates to:
  /// **'Move your savings before you spend.'**
  String get paydayHeadline;

  /// No description provided for @paydayLeftOf.
  ///
  /// In en, this message translates to:
  /// **'left to move of {total}'**
  String paydayLeftOf(String total);

  /// No description provided for @paydayTo.
  ///
  /// In en, this message translates to:
  /// **'To {account}'**
  String paydayTo(String account);

  /// No description provided for @paydayNeedsProof.
  ///
  /// In en, this message translates to:
  /// **'Needs proof'**
  String get paydayNeedsProof;

  /// No description provided for @paydayProven.
  ///
  /// In en, this message translates to:
  /// **'Proven'**
  String get paydayProven;

  /// No description provided for @paydayProvenAt.
  ///
  /// In en, this message translates to:
  /// **'Proven {time}'**
  String paydayProvenAt(String time);

  /// No description provided for @paydaySelfReported.
  ///
  /// In en, this message translates to:
  /// **'Self-reported'**
  String get paydaySelfReported;

  /// No description provided for @paydayOwed.
  ///
  /// In en, this message translates to:
  /// **'{amount} owed'**
  String paydayOwed(String amount);

  /// No description provided for @paydayLockNote.
  ///
  /// In en, this message translates to:
  /// **'Living and Guilt-free unlock on Home once every transfer is proven or you snooze.'**
  String get paydayLockNote;

  /// No description provided for @paydayUnlockedNote.
  ///
  /// In en, this message translates to:
  /// **'Living and Guilt-free are unlocked on Home. The alarm keeps going until every transfer is proven.'**
  String get paydayUnlockedNote;

  /// No description provided for @paydaySnooze.
  ///
  /// In en, this message translates to:
  /// **'{left, plural, =1{Snooze until {time} · 1 left} other{Snooze until {time} · {left} left}}'**
  String paydaySnooze(int left, String time);

  /// No description provided for @paydaySnoozeLabel.
  ///
  /// In en, this message translates to:
  /// **'Snooze'**
  String get paydaySnoozeLabel;

  /// No description provided for @paydaySnoozeNoneLeft.
  ///
  /// In en, this message translates to:
  /// **'No snoozes left this payday.'**
  String get paydaySnoozeNoneLeft;

  /// No description provided for @paydaySnoozeTooLate.
  ///
  /// In en, this message translates to:
  /// **'It\'s after 21:00. The alarm comes back at 07:00.'**
  String get paydaySnoozeTooLate;

  /// No description provided for @paydaySnoozedUntil.
  ///
  /// In en, this message translates to:
  /// **'Snoozed until {time}.'**
  String paydaySnoozedUntil(String time);

  /// No description provided for @proofTitle.
  ///
  /// In en, this message translates to:
  /// **'Show me the receipt'**
  String get proofTitle;

  /// No description provided for @proofBody.
  ///
  /// In en, this message translates to:
  /// **'Paste the confirmation SMS for this transfer.'**
  String get proofBody;

  /// No description provided for @proofField.
  ///
  /// In en, this message translates to:
  /// **'Confirmation SMS'**
  String get proofField;

  /// No description provided for @proofPaste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get proofPaste;

  /// No description provided for @proofHint.
  ///
  /// In en, this message translates to:
  /// **'Paste the message your bank or wallet sent'**
  String get proofHint;

  /// No description provided for @proofCheck.
  ///
  /// In en, this message translates to:
  /// **'Check message'**
  String get proofCheck;

  /// No description provided for @proofEmpty.
  ///
  /// In en, this message translates to:
  /// **'Paste the message first.'**
  String get proofEmpty;

  /// No description provided for @proofMarkSaved.
  ///
  /// In en, this message translates to:
  /// **'Mark as saved without proof'**
  String get proofMarkSaved;

  /// No description provided for @proofSelfReportedNote.
  ///
  /// In en, this message translates to:
  /// **'It counts as done, but not towards your streak.'**
  String get proofSelfReportedNote;

  /// No description provided for @proofAllPassed.
  ///
  /// In en, this message translates to:
  /// **'All 4 checks passed'**
  String get proofAllPassed;

  /// No description provided for @proofSomePassed.
  ///
  /// In en, this message translates to:
  /// **'{passed} of 4 checks passed'**
  String proofSomePassed(int passed);

  /// No description provided for @proofCheckAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount matches'**
  String get proofCheckAmount;

  /// No description provided for @proofCheckAccount.
  ///
  /// In en, this message translates to:
  /// **'Right account'**
  String get proofCheckAccount;

  /// No description provided for @proofCheckDate.
  ///
  /// In en, this message translates to:
  /// **'Sent today or yesterday'**
  String get proofCheckDate;

  /// No description provided for @proofCheckReference.
  ///
  /// In en, this message translates to:
  /// **'New reference'**
  String get proofCheckReference;

  /// No description provided for @proofNotFound.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get proofNotFound;

  /// No description provided for @proofAmountMismatch.
  ///
  /// In en, this message translates to:
  /// **'{parsed} ≠ {due}'**
  String proofAmountMismatch(String parsed, String due);

  /// No description provided for @proofReferenceNew.
  ///
  /// In en, this message translates to:
  /// **'Not used before'**
  String get proofReferenceNew;

  /// No description provided for @proofReferenceUsed.
  ///
  /// In en, this message translates to:
  /// **'Used before'**
  String get proofReferenceUsed;

  /// No description provided for @proofTryAnother.
  ///
  /// In en, this message translates to:
  /// **'Paste a different message'**
  String get proofTryAnother;

  /// No description provided for @proofSavePartial.
  ///
  /// In en, this message translates to:
  /// **'Save {parsed} and mark {owed} as owed'**
  String proofSavePartial(String parsed, String owed);

  /// No description provided for @proofPartialNote.
  ///
  /// In en, this message translates to:
  /// **'The alarm keeps going for {owed} until it is moved.'**
  String proofPartialNote(String owed);

  /// No description provided for @proofFailAmountLowTitle.
  ///
  /// In en, this message translates to:
  /// **'The amount doesn\'t match'**
  String get proofFailAmountLowTitle;

  /// No description provided for @proofFailAmountLow.
  ///
  /// In en, this message translates to:
  /// **'This SMS is for {parsed}, but this transfer is {due}. Paste the right message, or save what was sent and move the rest later.'**
  String proofFailAmountLow(String parsed, String due);

  /// No description provided for @proofFailAmountHighTitle.
  ///
  /// In en, this message translates to:
  /// **'The amount doesn\'t match'**
  String get proofFailAmountHighTitle;

  /// No description provided for @proofFailAmountHigh.
  ///
  /// In en, this message translates to:
  /// **'This SMS is for {parsed}, but this transfer is {due}. Paste the message for this transfer.'**
  String proofFailAmountHigh(String parsed, String due);

  /// No description provided for @proofFailAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Wrong account'**
  String get proofFailAccountTitle;

  /// No description provided for @proofFailAccount.
  ///
  /// In en, this message translates to:
  /// **'This money didn\'t go to this bucket\'s account. Paste the message for this transfer.'**
  String get proofFailAccount;

  /// No description provided for @proofFailDateTitle.
  ///
  /// In en, this message translates to:
  /// **'This message is too old'**
  String get proofFailDateTitle;

  /// No description provided for @proofFailDate.
  ///
  /// In en, this message translates to:
  /// **'Proof must be from today or yesterday. Paste a newer message.'**
  String get proofFailDate;

  /// No description provided for @proofFailBeforePaydayTitle.
  ///
  /// In en, this message translates to:
  /// **'This is from before payday'**
  String get proofFailBeforePaydayTitle;

  /// No description provided for @proofFailBeforePayday.
  ///
  /// In en, this message translates to:
  /// **'Paste the message for a transfer you made since payday.'**
  String get proofFailBeforePayday;

  /// No description provided for @proofFailReferenceTitle.
  ///
  /// In en, this message translates to:
  /// **'Already used'**
  String get proofFailReferenceTitle;

  /// No description provided for @proofFailReference.
  ///
  /// In en, this message translates to:
  /// **'This message proved another transfer. Paste a new one.'**
  String get proofFailReference;

  /// No description provided for @proofFailUnknownTitle.
  ///
  /// In en, this message translates to:
  /// **'Some details are missing'**
  String get proofFailUnknownTitle;

  /// No description provided for @proofFailUnknown.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t read every detail in this message. Paste the full SMS, or mark it as saved.'**
  String get proofFailUnknown;

  /// No description provided for @doneMoved.
  ///
  /// In en, this message translates to:
  /// **'{amount} moved to savings.'**
  String doneMoved(String amount);

  /// No description provided for @doneAllProven.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 transfer proven.} other{All {count} transfers proven.}}'**
  String doneAllProven(int count);

  /// No description provided for @doneAllDone.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 transfer done.} other{All {count} transfers done.}}'**
  String doneAllDone(int count);

  /// No description provided for @doneUnlockedPerDay.
  ///
  /// In en, this message translates to:
  /// **'Unlocked: Living {living} (about {perDay} a day) and Guilt-free {fun} to enjoy.'**
  String doneUnlockedPerDay(String living, String perDay, String fun);

  /// No description provided for @doneUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked: Living {living} and Guilt-free {fun} to enjoy.'**
  String doneUnlocked(String living, String fun);

  /// No description provided for @doneStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get doneStreak;

  /// No description provided for @doneStreakValue.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{Starts next payday} =1{1 payday} other{{count} paydays}}'**
  String doneStreakValue(int count);

  /// No description provided for @doneGoalValue.
  ///
  /// In en, this message translates to:
  /// **'{percent}% there'**
  String doneGoalValue(int percent);

  /// No description provided for @doneGoHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get doneGoHome;

  /// No description provided for @incomeFrom.
  ///
  /// In en, this message translates to:
  /// **'From {who}'**
  String incomeFrom(String who);

  /// No description provided for @incomeSourceMtn.
  ///
  /// In en, this message translates to:
  /// **'MTN MoMo'**
  String get incomeSourceMtn;

  /// No description provided for @incomeSourceAirtel.
  ///
  /// In en, this message translates to:
  /// **'Airtel Money'**
  String get incomeSourceAirtel;

  /// No description provided for @incomeSourceBank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get incomeSourceBank;

  /// No description provided for @incomeSourceOther.
  ///
  /// In en, this message translates to:
  /// **'Money received'**
  String get incomeSourceOther;

  /// No description provided for @incomeSourceAt.
  ///
  /// In en, this message translates to:
  /// **'{source} · {time}'**
  String incomeSourceAt(String source, String time);

  /// No description provided for @incomeSalaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Is this your salary?'**
  String get incomeSalaryTitle;

  /// No description provided for @incomeSalaryBody.
  ///
  /// In en, this message translates to:
  /// **'It looks like your salary. Start payday to split it.'**
  String get incomeSalaryBody;

  /// No description provided for @incomeSalaryStart.
  ///
  /// In en, this message translates to:
  /// **'Start payday'**
  String get incomeSalaryStart;

  /// No description provided for @incomeNotSalary.
  ///
  /// In en, this message translates to:
  /// **'It\'s side hustle money'**
  String get incomeNotSalary;

  /// No description provided for @incomeAskHustle.
  ///
  /// In en, this message translates to:
  /// **'Is this side hustle money?'**
  String get incomeAskHustle;

  /// No description provided for @incomeSomethingElse.
  ///
  /// In en, this message translates to:
  /// **'Something else'**
  String get incomeSomethingElse;

  /// No description provided for @incomeItsSplit.
  ///
  /// In en, this message translates to:
  /// **'Its split'**
  String get incomeItsSplit;

  /// No description provided for @incomeShare.
  ///
  /// In en, this message translates to:
  /// **'{percent} · {amount}'**
  String incomeShare(String percent, String amount);

  /// No description provided for @incomeSplitIt.
  ///
  /// In en, this message translates to:
  /// **'Split it'**
  String get incomeSplitIt;

  /// No description provided for @incomeHold.
  ///
  /// In en, this message translates to:
  /// **'Hold until month end'**
  String get incomeHold;

  /// No description provided for @incomeNotHustleBody.
  ///
  /// In en, this message translates to:
  /// **'It stays out of your buckets. Nothing is split.'**
  String get incomeNotHustleBody;

  /// No description provided for @incomeNotHustle.
  ///
  /// In en, this message translates to:
  /// **'Leave it out'**
  String get incomeNotHustle;

  /// No description provided for @incomeNoHustlesTitle.
  ///
  /// In en, this message translates to:
  /// **'No side hustle yet'**
  String get incomeNoHustlesTitle;

  /// No description provided for @incomeNoHustlesBody.
  ///
  /// In en, this message translates to:
  /// **'Add one in Income to split money like this.'**
  String get incomeNoHustlesBody;

  /// No description provided for @incomeAddHustle.
  ///
  /// In en, this message translates to:
  /// **'Add a side hustle'**
  String get incomeAddHustle;

  /// No description provided for @incomeAmountMissing.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t read the amount. Enter it to split.'**
  String get incomeAmountMissing;

  /// No description provided for @incomeHoldingTitle.
  ///
  /// In en, this message translates to:
  /// **'Held until month end'**
  String get incomeHoldingTitle;

  /// No description provided for @incomeHoldingBody.
  ///
  /// In en, this message translates to:
  /// **'It\'s split with the rest on {date} at {time}.'**
  String incomeHoldingBody(String date, String time);

  /// No description provided for @incomeLeftOut.
  ///
  /// In en, this message translates to:
  /// **'Left out of your buckets.'**
  String get incomeLeftOut;

  /// No description provided for @bucketLeft.
  ///
  /// In en, this message translates to:
  /// **'Left to spend'**
  String get bucketLeft;

  /// No description provided for @bucketBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get bucketBalance;

  /// No description provided for @bucketOver.
  ///
  /// In en, this message translates to:
  /// **'{amount} over'**
  String bucketOver(String amount);

  /// No description provided for @bucketThisCycle.
  ///
  /// In en, this message translates to:
  /// **'This cycle'**
  String get bucketThisCycle;

  /// No description provided for @bucketEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing in this bucket yet this cycle.'**
  String get bucketEmpty;

  /// No description provided for @bucketEntryPayday.
  ///
  /// In en, this message translates to:
  /// **'From payday'**
  String get bucketEntryPayday;

  /// No description provided for @bucketEntrySpend.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get bucketEntrySpend;

  /// No description provided for @bucketEntryMoveIn.
  ///
  /// In en, this message translates to:
  /// **'Moved in'**
  String get bucketEntryMoveIn;

  /// No description provided for @bucketEntryMoveOut.
  ///
  /// In en, this message translates to:
  /// **'Moved out'**
  String get bucketEntryMoveOut;

  /// No description provided for @bucketEntryAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Adjustment'**
  String get bucketEntryAdjustment;

  /// No description provided for @bucketEntryReversal.
  ///
  /// In en, this message translates to:
  /// **'Reversed'**
  String get bucketEntryReversal;

  /// No description provided for @bucketCoverFrom.
  ///
  /// In en, this message translates to:
  /// **'Cover the {amount} from'**
  String bucketCoverFrom(String amount);

  /// No description provided for @bucketCoverChange.
  ///
  /// In en, this message translates to:
  /// **'{before} → {after}'**
  String bucketCoverChange(String before, String after);

  /// No description provided for @bucketNextCycle.
  ///
  /// In en, this message translates to:
  /// **'Next month\'s {bucket}'**
  String bucketNextCycle(String bucket);

  /// No description provided for @bucketNextCycleNote.
  ///
  /// In en, this message translates to:
  /// **'It comes off next month\'s {bucket}.'**
  String bucketNextCycleNote(String bucket);

  /// No description provided for @bucketLockNote.
  ///
  /// In en, this message translates to:
  /// **'Emergency and Long-term aren\'t offered here. Taking from them is a separate, deliberate step.'**
  String get bucketLockNote;

  /// No description provided for @bucketMove.
  ///
  /// In en, this message translates to:
  /// **'Move {amount}'**
  String bucketMove(String amount);

  /// No description provided for @bucketCovered.
  ///
  /// In en, this message translates to:
  /// **'Covered {amount} from {from}.'**
  String bucketCovered(String amount, String from);

  /// No description provided for @bucketTightTitle.
  ///
  /// In en, this message translates to:
  /// **'Your split may be too tight'**
  String get bucketTightTitle;

  /// No description provided for @bucketTightBody.
  ///
  /// In en, this message translates to:
  /// **'{bucket} ran over in 2 of the last 3 months.'**
  String bucketTightBody(String bucket);

  /// No description provided for @bucketChangeSplit.
  ///
  /// In en, this message translates to:
  /// **'Change the split'**
  String get bucketChangeSplit;

  /// No description provided for @bucketNoCover.
  ///
  /// In en, this message translates to:
  /// **'Nothing can cover this right now. It comes off next month.'**
  String get bucketNoCover;

  /// No description provided for @goalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Goals'**
  String get goalsTitle;

  /// No description provided for @goalsNew.
  ///
  /// In en, this message translates to:
  /// **'New goal'**
  String get goalsNew;

  /// No description provided for @goalsSavedSoFar.
  ///
  /// In en, this message translates to:
  /// **'Saved so far'**
  String get goalsSavedSoFar;

  /// No description provided for @goalsSavedThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Saved this month'**
  String get goalsSavedThisMonth;

  /// No description provided for @goalsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Pick something to save for'**
  String get goalsEmptyTitle;

  /// No description provided for @goalsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'A laptop, a plot, school fees. It gets a share of every payday.'**
  String get goalsEmptyBody;

  /// No description provided for @goalsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add a goal'**
  String get goalsAdd;

  /// No description provided for @goalsOf.
  ///
  /// In en, this message translates to:
  /// **'of {target}'**
  String goalsOf(String target);

  /// No description provided for @goalsPerMonth.
  ///
  /// In en, this message translates to:
  /// **'{amount} a month'**
  String goalsPerMonth(String amount);

  /// No description provided for @goalsEtaMonths.
  ///
  /// In en, this message translates to:
  /// **'{amount} a month · about {months, plural, =1{1 month} other{{months} months}}'**
  String goalsEtaMonths(String amount, int months);

  /// No description provided for @goalsEtaDate.
  ///
  /// In en, this message translates to:
  /// **'{amount} a month · on track for {date}'**
  String goalsEtaDate(String amount, String date);

  /// No description provided for @goalsReached.
  ///
  /// In en, this message translates to:
  /// **'Reached. Its share can go to another bucket now.'**
  String get goalsReached;

  /// No description provided for @goalsNotInSplit.
  ///
  /// In en, this message translates to:
  /// **'Not in any split yet'**
  String get goalsNotInSplit;

  /// No description provided for @goalsGivePercent.
  ///
  /// In en, this message translates to:
  /// **'Give it a percentage'**
  String get goalsGivePercent;

  /// No description provided for @goalsCelebrate.
  ///
  /// In en, this message translates to:
  /// **'{name} reached. Nice.'**
  String goalsCelebrate(String name);

  /// No description provided for @goalName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get goalName;

  /// No description provided for @goalNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Laptop'**
  String get goalNameHint;

  /// No description provided for @goalTarget.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get goalTarget;

  /// No description provided for @goalAccount.
  ///
  /// In en, this message translates to:
  /// **'Where it lives'**
  String get goalAccount;

  /// No description provided for @goalPickAccount.
  ///
  /// In en, this message translates to:
  /// **'Pick an account'**
  String get goalPickAccount;

  /// No description provided for @goalSaved.
  ///
  /// In en, this message translates to:
  /// **'Goal added.'**
  String get goalSaved;

  /// No description provided for @planTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get planTitle;

  /// No description provided for @planToBuy.
  ///
  /// In en, this message translates to:
  /// **'To buy'**
  String get planToBuy;

  /// No description provided for @planWishes.
  ///
  /// In en, this message translates to:
  /// **'Wishes'**
  String get planWishes;

  /// No description provided for @planAddBuy.
  ///
  /// In en, this message translates to:
  /// **'Add a planned buy'**
  String get planAddBuy;

  /// No description provided for @planAddWish.
  ///
  /// In en, this message translates to:
  /// **'Add a wish'**
  String get planAddWish;

  /// No description provided for @planBuyEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing planned'**
  String get planBuyEmptyTitle;

  /// No description provided for @planBuyEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add the things you know you\'ll buy this month.'**
  String get planBuyEmptyBody;

  /// No description provided for @planWishEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No wishes cooling off'**
  String get planWishEmptyTitle;

  /// No description provided for @planWishEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Want something unplanned? Add it here and decide in a couple of days.'**
  String get planWishEmptyBody;

  /// No description provided for @planCoolingOff.
  ///
  /// In en, this message translates to:
  /// **'Cooling off'**
  String get planCoolingOff;

  /// No description provided for @planHoursLeft.
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String planHoursLeft(int hours);

  /// No description provided for @planFrom.
  ///
  /// In en, this message translates to:
  /// **'From {bucket}'**
  String planFrom(String bucket);

  /// No description provided for @planAskAgain.
  ///
  /// In en, this message translates to:
  /// **'We\'ll ask again in {hours, plural, =1{1 hour} other{{hours} hours}}. Still want it then? Buy it guilt-free.'**
  String planAskAgain(int hours);

  /// No description provided for @planChangedMind.
  ///
  /// In en, this message translates to:
  /// **'Changed my mind'**
  String get planChangedMind;

  /// No description provided for @planTimeUp.
  ///
  /// In en, this message translates to:
  /// **'Time\'s up. Still want it?'**
  String get planTimeUp;

  /// No description provided for @planStillWant.
  ///
  /// In en, this message translates to:
  /// **'Still want it'**
  String get planStillWant;

  /// No description provided for @planDrop.
  ///
  /// In en, this message translates to:
  /// **'Drop it'**
  String get planDrop;

  /// No description provided for @planApproved.
  ///
  /// In en, this message translates to:
  /// **'Go ahead, buy it guilt-free.'**
  String get planApproved;

  /// No description provided for @planItemName.
  ///
  /// In en, this message translates to:
  /// **'What'**
  String get planItemName;

  /// No description provided for @planItemNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Gas refill'**
  String get planItemNameHint;

  /// No description provided for @planAdded.
  ///
  /// In en, this message translates to:
  /// **'Added.'**
  String get planAdded;

  /// No description provided for @checkInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sunday check-in'**
  String get checkInTitle;

  /// No description provided for @checkInStepSort.
  ///
  /// In en, this message translates to:
  /// **'Sort payments'**
  String get checkInStepSort;

  /// No description provided for @checkInStepCount.
  ///
  /// In en, this message translates to:
  /// **'Count your cash'**
  String get checkInStepCount;

  /// No description provided for @checkInStepSummary.
  ///
  /// In en, this message translates to:
  /// **'Your week'**
  String get checkInStepSummary;

  /// No description provided for @checkInNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get checkInNow;

  /// No description provided for @checkInMinute.
  ///
  /// In en, this message translates to:
  /// **'1 minute'**
  String get checkInMinute;

  /// No description provided for @checkInToSort.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{All sorted} =1{1 to sort} other{{count} to sort}}'**
  String checkInToSort(int count);

  /// No description provided for @checkInSortBody.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 payment is waiting for a bucket.} other{{count} payments are waiting for a bucket.}}'**
  String checkInSortBody(int count);

  /// No description provided for @checkInAllSorted.
  ///
  /// In en, this message translates to:
  /// **'Every payment is in a bucket.'**
  String get checkInAllSorted;

  /// No description provided for @checkInSortNow.
  ///
  /// In en, this message translates to:
  /// **'Sort them now'**
  String get checkInSortNow;

  /// No description provided for @checkInNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get checkInNext;

  /// No description provided for @checkInShouldHave.
  ///
  /// In en, this message translates to:
  /// **'You should have'**
  String get checkInShouldHave;

  /// No description provided for @checkInWallet.
  ///
  /// In en, this message translates to:
  /// **'What\'s in your wallet?'**
  String get checkInWallet;

  /// No description provided for @checkInCount.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get checkInCount;

  /// No description provided for @checkInMissingTitle.
  ///
  /// In en, this message translates to:
  /// **'{amount} not logged'**
  String checkInMissingTitle(String amount);

  /// No description provided for @checkInMissingBody.
  ///
  /// In en, this message translates to:
  /// **'Small things add up: snacks, tips, a minibus fare.'**
  String get checkInMissingBody;

  /// No description provided for @checkInLogNow.
  ///
  /// In en, this message translates to:
  /// **'Log it now'**
  String get checkInLogNow;

  /// No description provided for @checkInMarkUntracked.
  ///
  /// In en, this message translates to:
  /// **'Mark untracked'**
  String get checkInMarkUntracked;

  /// No description provided for @checkInReceivedTitle.
  ///
  /// In en, this message translates to:
  /// **'{amount} more than expected'**
  String checkInReceivedTitle(String amount);

  /// No description provided for @checkInReceivedBody.
  ///
  /// In en, this message translates to:
  /// **'Did you receive cash? Put it where it belongs.'**
  String get checkInReceivedBody;

  /// No description provided for @checkInIntoLiving.
  ///
  /// In en, this message translates to:
  /// **'Into Living'**
  String get checkInIntoLiving;

  /// No description provided for @checkInKeepCash.
  ///
  /// In en, this message translates to:
  /// **'Keep as cash'**
  String get checkInKeepCash;

  /// No description provided for @checkInSpotOn.
  ///
  /// In en, this message translates to:
  /// **'Spot on. Your cash matches.'**
  String get checkInSpotOn;

  /// No description provided for @checkInRecorded.
  ///
  /// In en, this message translates to:
  /// **'Recorded.'**
  String get checkInRecorded;

  /// No description provided for @checkInSpent.
  ///
  /// In en, this message translates to:
  /// **'Spent this week'**
  String get checkInSpent;

  /// No description provided for @checkInNothingSpent.
  ///
  /// In en, this message translates to:
  /// **'Nothing spent this week.'**
  String get checkInNothingSpent;

  /// No description provided for @checkInSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved this cycle'**
  String get checkInSaved;

  /// No description provided for @checkInUntracked.
  ///
  /// In en, this message translates to:
  /// **'Untracked'**
  String get checkInUntracked;

  /// No description provided for @checkInDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get checkInDone;

  /// No description provided for @meTitle.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get meTitle;

  /// No description provided for @meMoney.
  ///
  /// In en, this message translates to:
  /// **'Money'**
  String get meMoney;

  /// No description provided for @meIncomeSources.
  ///
  /// In en, this message translates to:
  /// **'Income sources'**
  String get meIncomeSources;

  /// No description provided for @meBills.
  ///
  /// In en, this message translates to:
  /// **'Bills'**
  String get meBills;

  /// No description provided for @meSplitOf.
  ///
  /// In en, this message translates to:
  /// **'Split for {income}'**
  String meSplitOf(String income);

  /// No description provided for @meBucketsAccounts.
  ///
  /// In en, this message translates to:
  /// **'Buckets & accounts'**
  String get meBucketsAccounts;

  /// No description provided for @meAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get meAlerts;

  /// No description provided for @meNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications & alarm'**
  String get meNotifications;

  /// No description provided for @meSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get meSecurity;

  /// No description provided for @meAppLock.
  ///
  /// In en, this message translates to:
  /// **'App lock'**
  String get meAppLock;

  /// No description provided for @meAppLockBody.
  ///
  /// In en, this message translates to:
  /// **'Ask for your fingerprint or PIN when Buckets opens'**
  String get meAppLockBody;

  /// No description provided for @meHabits.
  ///
  /// In en, this message translates to:
  /// **'Payday & spending'**
  String get meHabits;

  /// No description provided for @meSnoozes.
  ///
  /// In en, this message translates to:
  /// **'Payday snoozes'**
  String get meSnoozes;

  /// No description provided for @meSnoozesBody.
  ///
  /// In en, this message translates to:
  /// **'How many times you can snooze the payday alarm'**
  String get meSnoozesBody;

  /// No description provided for @meCoolingOff.
  ///
  /// In en, this message translates to:
  /// **'Wish cooling-off'**
  String get meCoolingOff;

  /// No description provided for @meHours.
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String meHours(int hours);

  /// No description provided for @meThreshold.
  ///
  /// In en, this message translates to:
  /// **'Suggest a wish above'**
  String get meThreshold;

  /// No description provided for @meAutoFile.
  ///
  /// In en, this message translates to:
  /// **'Auto-file known shops'**
  String get meAutoFile;

  /// No description provided for @meAutoFileBody.
  ///
  /// In en, this message translates to:
  /// **'File payments that match a rule without asking'**
  String get meAutoFileBody;

  /// No description provided for @meAbout.
  ///
  /// In en, this message translates to:
  /// **'About & privacy'**
  String get meAbout;

  /// No description provided for @meAboutBody.
  ///
  /// In en, this message translates to:
  /// **'Buckets keeps everything on this phone. No account, no internet, no ads. Your messages and receipts never leave the device.'**
  String get meAboutBody;

  /// No description provided for @meSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved.'**
  String get meSaved;

  /// No description provided for @errAppLockUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Set a screen lock on your phone first.'**
  String get errAppLockUnavailable;

  /// No description provided for @errAppLockCancelled.
  ///
  /// In en, this message translates to:
  /// **'Unlock to change this.'**
  String get errAppLockCancelled;

  /// No description provided for @errCoolingOffHours.
  ///
  /// In en, this message translates to:
  /// **'Pick 24, 48 or 72 hours.'**
  String get errCoolingOffHours;

  /// No description provided for @lockTitle.
  ///
  /// In en, this message translates to:
  /// **'Buckets is locked'**
  String get lockTitle;

  /// No description provided for @lockBody.
  ///
  /// In en, this message translates to:
  /// **'Unlock with your fingerprint or PIN.'**
  String get lockBody;

  /// No description provided for @lockUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get lockUnlock;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
