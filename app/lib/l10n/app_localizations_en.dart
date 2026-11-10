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

  @override
  String get tabHome => 'Home';

  @override
  String get tabGoals => 'Goals';

  @override
  String get tabPlan => 'Plan';

  @override
  String get tabMe => 'Me';

  @override
  String get homeGreeting => 'Muli shani';

  @override
  String get homeTitleFirstRun => 'Payday is coming';

  @override
  String get homeTitle => 'Your money';

  @override
  String get homeLog => 'Log a payment';

  @override
  String homeToSort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count payments to sort',
      one: '1 payment to sort',
      zero: 'No payments to sort',
    );
    return '$_temp0';
  }

  @override
  String homePaydayIn(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Payday in $days days',
      one: 'Payday is tomorrow',
      zero: 'Payday is today',
    );
    return '$_temp0';
  }

  @override
  String get homeNoPayday => 'Your buckets fill when money comes in';

  @override
  String get homeFirstRunBody =>
      'On payday we split your money into these buckets and remind you to move the savings.';

  @override
  String homePaydayBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count transfers to move',
      one: '1 transfer to move',
    );
    return '$_temp0';
  }

  @override
  String homePaydayBannerBody(String amount) {
    return '$amount still to move. Prove it to unlock spending.';
  }

  @override
  String get homeLivingLeft => 'Living left';

  @override
  String homePerDay(String amount) {
    return 'About $amount a day until payday';
  }

  @override
  String get homeGuiltFree => 'Guilt-free';

  @override
  String get homeLocked =>
      'Living and Guilt-free unlock when your transfers are done.';

  @override
  String get homeRecent => 'Recent';

  @override
  String get homeRecentEmpty => 'No payments yet. Log one with +.';

  @override
  String get done => 'Done';

  @override
  String get sortTitle => 'What was this?';

  @override
  String get sortFile => 'File it';

  @override
  String get sortSkip => 'Skip for now';

  @override
  String get sortPickBoth => 'Pick what it was and which bucket paid.';

  @override
  String sortAlways(String who) {
    return 'Always file $who like this';
  }

  @override
  String sortRemaining(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count more to sort',
      one: '1 more to sort',
      zero: 'Last one',
    );
    return '$_temp0';
  }

  @override
  String get sortLast => 'Last one';

  @override
  String get sortDoneTitle => 'All sorted';

  @override
  String get sortDoneBody => 'Every payment is filed. New ones show up here.';

  @override
  String get logTitle => 'Log a payment';

  @override
  String get logScan => 'Scan a receipt';

  @override
  String get logCash => 'Cash';

  @override
  String get logPaste => 'Paste message';

  @override
  String get logMessage => 'Payment message';

  @override
  String get logMessageHint => 'Paste the MoMo or bank SMS';

  @override
  String get logReadAmount => 'Amount read from the message';

  @override
  String get logWishTitle => 'A big buy?';

  @override
  String get logWishBody =>
      'Add it to your wishes and wait 48 hours before you buy.';

  @override
  String get logCategory => 'What was it?';

  @override
  String get logBucket => 'Which bucket paid?';

  @override
  String get logNote => 'Note (optional)';

  @override
  String get logNoteHint => 'e.g. bus to town and back';

  @override
  String get logSaved => 'Payment saved';

  @override
  String get scanHint =>
      'Hold the receipt flat in good light, then take the photo.';

  @override
  String get scanNoText =>
      'We couldn\'t read any text. Retake it in better light.';

  @override
  String get scanNoCamera =>
      'Buckets can\'t use the camera. Allow it in Settings, or pick a photo instead.';

  @override
  String get scanGallery => 'Pick a photo';

  @override
  String get scanShutter => 'Take photo';

  @override
  String get scanRetake => 'Retake';

  @override
  String get receiptTitle => 'Check the receipt';

  @override
  String get receiptUnknownShop => 'Receipt';

  @override
  String get receiptCheckTotal =>
      'We couldn\'t read the total. Please check it.';

  @override
  String get receiptUseTotal => 'Use this total';

  @override
  String receiptItemsOff(String amount) {
    return 'The items are $amount off the total. Check them or the total.';
  }

  @override
  String get receiptItemsMatch => 'The items add up to the total.';

  @override
  String get receiptNotReady =>
      'Check the total, then pick what it was and the bucket.';

  @override
  String paydayDate(String date) {
    return 'Payday · $date';
  }

  @override
  String get paydayAlarmRepeats => 'Alarm repeats every 30 min';

  @override
  String get paydayHeadline => 'Move your savings before you spend.';

  @override
  String paydayLeftOf(String total) {
    return 'left to move of $total';
  }

  @override
  String paydayTo(String account) {
    return 'To $account';
  }

  @override
  String get paydayNeedsProof => 'Needs proof';

  @override
  String get paydayProven => 'Proven';

  @override
  String paydayProvenAt(String time) {
    return 'Proven $time';
  }

  @override
  String get paydaySelfReported => 'Self-reported';

  @override
  String paydayOwed(String amount) {
    return '$amount owed';
  }

  @override
  String get paydayLockNote =>
      'Living and Guilt-free unlock on Home once every transfer is proven or you snooze.';

  @override
  String get paydayUnlockedNote =>
      'Living and Guilt-free are unlocked on Home. The alarm keeps going until every transfer is proven.';

  @override
  String paydaySnooze(int left, String time) {
    String _temp0 = intl.Intl.pluralLogic(
      left,
      locale: localeName,
      other: 'Snooze until $time · $left left',
      one: 'Snooze until $time · 1 left',
    );
    return '$_temp0';
  }

  @override
  String get paydaySnoozeLabel => 'Snooze';

  @override
  String get paydaySnoozeNoneLeft => 'No snoozes left this payday.';

  @override
  String get paydaySnoozeTooLate =>
      'It\'s after 21:00. The alarm comes back at 07:00.';

  @override
  String paydaySnoozedUntil(String time) {
    return 'Snoozed until $time.';
  }

  @override
  String get proofTitle => 'Show me the receipt';

  @override
  String get proofBody => 'Paste the confirmation SMS for this transfer.';

  @override
  String get proofField => 'Confirmation SMS';

  @override
  String get proofPaste => 'Paste';

  @override
  String get proofHint => 'Paste the message your bank or wallet sent';

  @override
  String get proofCheck => 'Check message';

  @override
  String get proofEmpty => 'Paste the message first.';

  @override
  String get proofMarkSaved => 'Mark as saved without proof';

  @override
  String get proofSelfReportedNote =>
      'It counts as done, but not towards your streak.';

  @override
  String get proofAllPassed => 'All 4 checks passed';

  @override
  String proofSomePassed(int passed) {
    return '$passed of 4 checks passed';
  }

  @override
  String get proofCheckAmount => 'Amount matches';

  @override
  String get proofCheckAccount => 'Right account';

  @override
  String get proofCheckDate => 'Sent today or yesterday';

  @override
  String get proofCheckReference => 'New reference';

  @override
  String get proofNotFound => 'Not found';

  @override
  String proofAmountMismatch(String parsed, String due) {
    return '$parsed ≠ $due';
  }

  @override
  String get proofReferenceNew => 'Not used before';

  @override
  String get proofReferenceUsed => 'Used before';

  @override
  String get proofTryAnother => 'Paste a different message';

  @override
  String proofSavePartial(String parsed, String owed) {
    return 'Save $parsed and mark $owed as owed';
  }

  @override
  String proofPartialNote(String owed) {
    return 'The alarm keeps going for $owed until it is moved.';
  }

  @override
  String get proofFailAmountLowTitle => 'The amount doesn\'t match';

  @override
  String proofFailAmountLow(String parsed, String due) {
    return 'This SMS is for $parsed, but this transfer is $due. Paste the right message, or save what was sent and move the rest later.';
  }

  @override
  String get proofFailAmountHighTitle => 'The amount doesn\'t match';

  @override
  String proofFailAmountHigh(String parsed, String due) {
    return 'This SMS is for $parsed, but this transfer is $due. Paste the message for this transfer.';
  }

  @override
  String get proofFailAccountTitle => 'Wrong account';

  @override
  String get proofFailAccount =>
      'This money didn\'t go to this bucket\'s account. Paste the message for this transfer.';

  @override
  String get proofFailDateTitle => 'This message is too old';

  @override
  String get proofFailDate =>
      'Proof must be from today or yesterday. Paste a newer message.';

  @override
  String get proofFailBeforePaydayTitle => 'This is from before payday';

  @override
  String get proofFailBeforePayday =>
      'Paste the message for a transfer you made since payday.';

  @override
  String get proofFailReferenceTitle => 'Already used';

  @override
  String get proofFailReference =>
      'This message proved another transfer. Paste a new one.';

  @override
  String get proofFailUnknownTitle => 'Some details are missing';

  @override
  String get proofFailUnknown =>
      'Couldn\'t read every detail in this message. Paste the full SMS, or mark it as saved.';

  @override
  String doneMoved(String amount) {
    return '$amount moved to savings.';
  }

  @override
  String doneAllProven(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'All $count transfers proven.',
      one: '1 transfer proven.',
    );
    return '$_temp0';
  }

  @override
  String doneAllDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'All $count transfers done.',
      one: '1 transfer done.',
    );
    return '$_temp0';
  }

  @override
  String doneUnlockedPerDay(String living, String perDay, String fun) {
    return 'Unlocked: Living $living (about $perDay a day) and Guilt-free $fun to enjoy.';
  }

  @override
  String doneUnlocked(String living, String fun) {
    return 'Unlocked: Living $living and Guilt-free $fun to enjoy.';
  }

  @override
  String get doneStreak => 'Streak';

  @override
  String doneStreakValue(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count paydays',
      one: '1 payday',
      zero: 'Starts next payday',
    );
    return '$_temp0';
  }

  @override
  String doneGoalValue(int percent) {
    return '$percent% there';
  }

  @override
  String get doneGoHome => 'Go to Home';

  @override
  String incomeFrom(String who) {
    return 'From $who';
  }

  @override
  String get incomeSourceMtn => 'MTN MoMo';

  @override
  String get incomeSourceAirtel => 'Airtel Money';

  @override
  String get incomeSourceBank => 'Bank';

  @override
  String get incomeSourceOther => 'Money received';

  @override
  String incomeSourceAt(String source, String time) {
    return '$source · $time';
  }

  @override
  String get incomeSalaryTitle => 'Is this your salary?';

  @override
  String get incomeSalaryBody =>
      'It looks like your salary. Start payday to split it.';

  @override
  String get incomeSalaryStart => 'Start payday';

  @override
  String get incomeNotSalary => 'It\'s side hustle money';

  @override
  String get incomeAskHustle => 'Is this side hustle money?';

  @override
  String get incomeSomethingElse => 'Something else';

  @override
  String get incomeItsSplit => 'Its split';

  @override
  String incomeShare(String percent, String amount) {
    return '$percent · $amount';
  }

  @override
  String get incomeSplitIt => 'Split it';

  @override
  String get incomeHold => 'Hold until month end';

  @override
  String get incomeNotHustleBody =>
      'It stays out of your buckets. Nothing is split.';

  @override
  String get incomeNotHustle => 'Leave it out';

  @override
  String get incomeNoHustlesTitle => 'No side hustle yet';

  @override
  String get incomeNoHustlesBody =>
      'Add one in Income to split money like this.';

  @override
  String get incomeAddHustle => 'Add a side hustle';

  @override
  String get incomeAmountMissing =>
      'Couldn\'t read the amount. Enter it to split.';

  @override
  String get incomeHoldingTitle => 'Held until month end';

  @override
  String incomeHoldingBody(String date, String time) {
    return 'It\'s split with the rest on $date at $time.';
  }

  @override
  String get incomeLeftOut => 'Left out of your buckets.';
}
