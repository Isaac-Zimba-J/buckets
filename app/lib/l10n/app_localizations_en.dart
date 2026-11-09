// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Buckets';

  @override
  String get notifPaydayTitle => 'Move your savings';

  @override
  String notifPaydayBody(int pending) {
    String _temp0 = intl.Intl.pluralLogic(
      pending,
      locale: localeName,
      other: '$pending transfers still open. Prove them to unlock spending.',
      one: '1 transfer still open. Prove it to unlock spending.',
    );
    return '$_temp0';
  }

  @override
  String notifAlertTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count new payments',
      one: 'New payment',
    );
    return '$_temp0';
  }

  @override
  String get notifAlertBody => 'Tap to file it.';

  @override
  String get notifIncomeTitle => 'Money received';

  @override
  String get notifIncomeBody => 'Side hustle money? Tap to split it.';

  @override
  String get notifBillTitle => 'A bill is due soon';

  @override
  String get notifBillBody => 'It\'s due in 2 days. Check your bills.';

  @override
  String get notifWishTitle => 'Cooling-off is over';

  @override
  String get notifWishBody => 'Still want it? Decide in Plan.';

  @override
  String get notifCheckInTitle => 'Your Sunday check-in';

  @override
  String get notifCheckInBody => 'Sort your payments, then count your cash.';

  @override
  String get notifLowTitle => 'Living is running low';

  @override
  String get notifLowBody => 'Open Living to see what\'s left until payday.';

  @override
  String get channelPayday => 'Payday alarm';

  @override
  String get channelAlert => 'Payments to file';

  @override
  String get channelIncome => 'Money received';

  @override
  String get channelBill => 'Bills';

  @override
  String get channelWish => 'Wishes';

  @override
  String get channelCheckIn => 'Weekly check-in';

  @override
  String get channelLow => 'Living running low';

  @override
  String get appLockReason => 'Unlock Buckets';

  @override
  String get tryAgain => 'Try again';

  @override
  String get back => 'Back';

  @override
  String get close => 'Close';

  @override
  String get save => 'Save';

  @override
  String get continueLabel => 'Continue';

  @override
  String stepOf(int step, int total) {
    return '$step of $total';
  }

  @override
  String get errLoad => 'We couldn\'t load this. Try again.';

  @override
  String get errGeneric => 'Something isn\'t right. Check it and try again.';

  @override
  String get errAmount => 'Enter an amount above K 0.';

  @override
  String get errDay => 'Pick a day from 1 to 31.';

  @override
  String get errName => 'Add a name.';

  @override
  String get errMatchKey =>
      'Use at least 3 characters, like the last 4 digits.';

  @override
  String get errNoIncome => 'Add the money you get first.';

  @override
  String get errSplitTotal => 'The split must add up to 100%.';

  @override
  String get errNextDue => 'Pick when it\'s next due.';

  @override
  String get accountKindBank => 'Bank';

  @override
  String get accountKindMtn => 'MTN MoMo';

  @override
  String get accountKindAirtel => 'Airtel Money';

  @override
  String get accountKindCash => 'Cash';

  @override
  String get accountKindInvestment => 'Investment';

  @override
  String get accountKindOther => 'Other';

  @override
  String get welcomeTitle => 'Split every payday before you spend it';

  @override
  String get welcomeBody =>
      'Tell us what you earn and what your bills are. We split the rest into buckets and remind you to move the savings.';

  @override
  String get welcomeStart => 'Get started';

  @override
  String get welcomePrivacy =>
      'Everything stays on this phone. No account, no internet.';

  @override
  String get incomeTitle => 'What money do you get?';

  @override
  String get incomeName => 'Name';

  @override
  String get incomeNameHint => 'e.g. Salary';

  @override
  String get incomeKindSalary => 'Salary';

  @override
  String get incomeKindSideHustle => 'Side hustle';

  @override
  String get incomeExpected => 'How much, usually';

  @override
  String get incomePayday => 'Payday (day of the month)';

  @override
  String get incomePaydayHint => 'e.g. 25';

  @override
  String get incomeLandsIn => 'Lands in';

  @override
  String get choose => 'Choose';

  @override
  String get incomeSave => 'Save income';

  @override
  String get incomeYours => 'Your income';

  @override
  String incomePaydayOn(int day) {
    return 'Payday on day $day';
  }

  @override
  String get incomeIrregular => 'Comes when it comes';

  @override
  String get accountSheetTitle => 'Where does it land?';

  @override
  String get accountAdd => 'Add account';

  @override
  String get accountName => 'Account name';

  @override
  String get accountNameHint => 'e.g. Zanaco savings';

  @override
  String get accountMatchKey => 'Last digits (optional)';

  @override
  String get accountMatchKeyHint => 'e.g. 4521';

  @override
  String get accountSpending => 'Spending account';

  @override
  String get accountSpendingSub => 'Living and Guilt-free live here';

  @override
  String get billsTitle => 'Fixed bills';

  @override
  String get billsIntro => 'Bills come off the top, before the split.';

  @override
  String get billsEmptyTitle => 'No bills yet';

  @override
  String get billsEmptyBody =>
      'Add rent, ZESCO or school fees. They\'re set aside first.';

  @override
  String get billsAdd => 'Add a bill';

  @override
  String get billName => 'Name';

  @override
  String get billNameHint => 'e.g. Rent';

  @override
  String get billAmount => 'Amount';

  @override
  String get billMonthly => 'Monthly';

  @override
  String get billTermly => 'Termly';

  @override
  String get billYearly => 'Yearly';

  @override
  String get billDueDay => 'Due day (of the month)';

  @override
  String get billDueDayHint => 'e.g. 1';

  @override
  String get billNextDue => 'Next due';

  @override
  String get billPickDate => 'Pick a date';

  @override
  String get billsTotal => 'Set aside each payday';

  @override
  String billPutAside(String putAside, String amount) {
    return '$putAside of $amount put aside';
  }

  @override
  String billEach(String amount) {
    return '$amount a month';
  }

  @override
  String get remove => 'Remove';

  @override
  String get splitTitle => 'Split what\'s left';

  @override
  String splitToSplit(String amount) {
    return '$amount to split';
  }

  @override
  String splitTotalOk(int percent) {
    return '$percent% · adds up';
  }

  @override
  String splitTooMuch(int percent) {
    return '$percent% · too much';
  }

  @override
  String splitTooLittle(int percent) {
    return '$percent% · too little';
  }

  @override
  String get splitBillsExceed =>
      'Your bills are more than this income. Check your bills or the amount.';

  @override
  String get splitShare => 'Share (%)';

  @override
  String splitPerPayday(String amount) {
    return '$amount each payday';
  }

  @override
  String get accountsTitle => 'Where buckets live';

  @override
  String get accountsInfo =>
      'Pick where each bucket\'s money really sits. Proof checks look for this account.';

  @override
  String get accountsLater => 'Set the rest later';

  @override
  String accountsPick(String bucket) {
    return 'Where does $bucket live?';
  }

  @override
  String get permsTitle => 'Alarms and alerts';

  @override
  String get permsInfo =>
      'Buckets reads payment alerts on this phone only. Nothing leaves it.';

  @override
  String get permNotifications => 'Notifications';

  @override
  String get permNotificationsSub => 'Payday alarm and reminders';

  @override
  String get permAccess => 'Payment alerts';

  @override
  String get permAccessSub => 'Read MoMo, Airtel and bank alerts';

  @override
  String get permExact => 'Exact alarms';

  @override
  String get permExactSub => 'Ring on time on payday';

  @override
  String get permsDenied =>
      'Some permissions are off. Turn them on in Settings.';

  @override
  String get permsOpenSettings => 'Open settings';

  @override
  String get permsFinish => 'Finish setup';

  @override
  String get incomeNeedAccount => 'Choose where it lands first.';

  @override
  String get errNoSpending =>
      'Add a spending account first: where Living and Guilt-free money lives.';

  @override
  String get errManySpending =>
      'Only one account can be the spending account. Turn it off on the others.';
}
