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
  String get profileTitle => 'What should we call you?';

  @override
  String get profileIntro =>
      'Just for greetings. Your name stays on this phone.';

  @override
  String get profileName => 'First name';

  @override
  String get profileNameHint => 'Your first name';

  @override
  String get profileGreeting => 'How should we greet you?';

  @override
  String get greetingMuliShani => 'Muli shani';

  @override
  String get greetingMwaiseni => 'Mwaiseni';

  @override
  String get greetingHello => 'Hello';

  @override
  String get profileTimeZone => 'Time zone';

  @override
  String get profileTimeZoneCaption => 'Used for payday alarms and quiet hours';

  @override
  String get profileCurrency => 'Currency';

  @override
  String get profileCurrencyValue => 'Kwacha (K)';

  @override
  String get profileInfo =>
      'No account, no email, no password. Buckets works fully offline. You can turn on app lock later in Settings.';

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
  String get homeTitleFirstRun => 'You\'re all set';

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
      'On payday we\'ll split your pay into these buckets, then remind you to move the savings.';

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

  @override
  String get bucketLeft => 'Left to spend';

  @override
  String get bucketBalance => 'Balance';

  @override
  String bucketOver(String amount) {
    return '$amount over';
  }

  @override
  String get bucketThisCycle => 'This cycle';

  @override
  String get bucketEmpty => 'Nothing in this bucket yet this cycle.';

  @override
  String get bucketEntryPayday => 'From payday';

  @override
  String get bucketEntrySpend => 'Spent';

  @override
  String get bucketEntryMoveIn => 'Moved in';

  @override
  String get bucketEntryMoveOut => 'Moved out';

  @override
  String get bucketEntryAdjustment => 'Adjustment';

  @override
  String get bucketEntryReversal => 'Reversed';

  @override
  String bucketCoverFrom(String amount) {
    return 'Cover the $amount from';
  }

  @override
  String bucketCoverChange(String before, String after) {
    return '$before → $after';
  }

  @override
  String bucketNextCycle(String bucket) {
    return 'Next month\'s $bucket';
  }

  @override
  String bucketNextCycleNote(String bucket) {
    return 'It comes off next month\'s $bucket.';
  }

  @override
  String get bucketLockNote =>
      'Emergency and Long-term aren\'t offered here. Taking from them is a separate, deliberate step.';

  @override
  String bucketMove(String amount) {
    return 'Move $amount';
  }

  @override
  String bucketCovered(String amount, String from) {
    return 'Covered $amount from $from.';
  }

  @override
  String get bucketTightTitle => 'Your split may be too tight';

  @override
  String bucketTightBody(String bucket) {
    return '$bucket ran over in 2 of the last 3 months.';
  }

  @override
  String get bucketChangeSplit => 'Change the split';

  @override
  String get bucketNoCover =>
      'Nothing can cover this right now. It comes off next month.';

  @override
  String get goalsTitle => 'Goals';

  @override
  String get goalsNew => 'New goal';

  @override
  String get goalsSavedSoFar => 'Saved so far';

  @override
  String get goalsSavedThisMonth => 'Saved this month';

  @override
  String get goalsEmptyTitle => 'Pick something to save for';

  @override
  String get goalsEmptyBody =>
      'A laptop, a plot, school fees. It gets a share of every payday.';

  @override
  String get goalsAdd => 'Add a goal';

  @override
  String goalsOf(String target) {
    return 'of $target';
  }

  @override
  String goalsPerMonth(String amount) {
    return '$amount a month';
  }

  @override
  String goalsEtaMonths(String amount, int months) {
    String _temp0 = intl.Intl.pluralLogic(
      months,
      locale: localeName,
      other: '$months months',
      one: '1 month',
    );
    return '$amount a month · about $_temp0';
  }

  @override
  String goalsEtaDate(String amount, String date) {
    return '$amount a month · on track for $date';
  }

  @override
  String get goalsReached => 'Reached. Its share can go to another bucket now.';

  @override
  String get goalsNotInSplit => 'Not in any split yet';

  @override
  String get goalsGivePercent => 'Give it a percentage';

  @override
  String goalsCelebrate(String name) {
    return '$name reached. Nice.';
  }

  @override
  String get goalName => 'Name';

  @override
  String get goalNameHint => 'e.g. Laptop';

  @override
  String get goalTarget => 'Target';

  @override
  String get goalAccount => 'Where it lives';

  @override
  String get goalPickAccount => 'Pick an account';

  @override
  String get goalSaved => 'Goal added.';

  @override
  String get planTitle => 'Plan';

  @override
  String get planToBuy => 'To buy';

  @override
  String get planWishes => 'Wishes';

  @override
  String get planAddBuy => 'Add a planned buy';

  @override
  String get planAddWish => 'Add a wish';

  @override
  String get planBuyEmptyTitle => 'Nothing planned';

  @override
  String get planBuyEmptyBody =>
      'Add the things you know you\'ll buy this month.';

  @override
  String get planWishEmptyTitle => 'No wishes cooling off';

  @override
  String get planWishEmptyBody =>
      'Want something unplanned? Add it here and decide in a couple of days.';

  @override
  String get planCoolingOff => 'Cooling off';

  @override
  String planHoursLeft(int hours) {
    return '${hours}h';
  }

  @override
  String planFrom(String bucket) {
    return 'From $bucket';
  }

  @override
  String planAskAgain(int hours) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hours hours',
      one: '1 hour',
    );
    return 'We\'ll ask again in $_temp0. Still want it then? Buy it guilt-free.';
  }

  @override
  String get planChangedMind => 'Changed my mind';

  @override
  String get planTimeUp => 'Time\'s up. Still want it?';

  @override
  String get planStillWant => 'Still want it';

  @override
  String get planDrop => 'Drop it';

  @override
  String get planApproved => 'Go ahead, buy it guilt-free.';

  @override
  String get planItemName => 'What';

  @override
  String get planItemNameHint => 'e.g. Gas refill';

  @override
  String get planAdded => 'Added.';

  @override
  String get checkInTitle => 'Sunday check-in';

  @override
  String get checkInStepSort => 'Sort payments';

  @override
  String get checkInStepCount => 'Count your cash';

  @override
  String get checkInStepSummary => 'Your week';

  @override
  String get checkInNow => 'Now';

  @override
  String get checkInMinute => '1 minute';

  @override
  String checkInToSort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count to sort',
      one: '1 to sort',
      zero: 'All sorted',
    );
    return '$_temp0';
  }

  @override
  String checkInSortBody(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count payments are waiting for a bucket.',
      one: '1 payment is waiting for a bucket.',
    );
    return '$_temp0';
  }

  @override
  String get checkInAllSorted => 'Every payment is in a bucket.';

  @override
  String get checkInSortNow => 'Sort them now';

  @override
  String get checkInNext => 'Next';

  @override
  String get checkInShouldHave => 'You should have';

  @override
  String get checkInWallet => 'What\'s in your wallet?';

  @override
  String get checkInCount => 'Check';

  @override
  String checkInMissingTitle(String amount) {
    return '$amount not logged';
  }

  @override
  String get checkInMissingBody =>
      'Small things add up: snacks, tips, a minibus fare.';

  @override
  String get checkInLogNow => 'Log it now';

  @override
  String get checkInMarkUntracked => 'Mark untracked';

  @override
  String checkInReceivedTitle(String amount) {
    return '$amount more than expected';
  }

  @override
  String get checkInReceivedBody =>
      'Did you receive cash? Put it where it belongs.';

  @override
  String get checkInIntoLiving => 'Into Living';

  @override
  String get checkInKeepCash => 'Keep as cash';

  @override
  String get checkInSpotOn => 'Spot on. Your cash matches.';

  @override
  String get checkInRecorded => 'Recorded.';

  @override
  String get checkInSpent => 'Spent this week';

  @override
  String get checkInNothingSpent => 'Nothing spent this week.';

  @override
  String get checkInSaved => 'Saved this cycle';

  @override
  String get checkInUntracked => 'Untracked';

  @override
  String get checkInDone => 'Done';

  @override
  String get meTitle => 'Me';

  @override
  String get meMoney => 'Money';

  @override
  String get meIncomeSources => 'Income sources';

  @override
  String get meBills => 'Bills';

  @override
  String meSplitOf(String income) {
    return 'Split for $income';
  }

  @override
  String get meBucketsAccounts => 'Buckets & accounts';

  @override
  String get meAlerts => 'Alerts';

  @override
  String get meNotifications => 'Notifications & alarm';

  @override
  String get meSecurity => 'Security';

  @override
  String get meAppLock => 'App lock';

  @override
  String get meAppLockBody =>
      'Ask for your fingerprint or PIN when Buckets opens';

  @override
  String get meHabits => 'Payday & spending';

  @override
  String get meSnoozes => 'Payday snoozes';

  @override
  String get meSnoozesBody => 'How many times you can snooze the payday alarm';

  @override
  String get meCoolingOff => 'Wish cooling-off';

  @override
  String meHours(int hours) {
    return '${hours}h';
  }

  @override
  String get meThreshold => 'Suggest a wish above';

  @override
  String get meAutoFile => 'Auto-file known shops';

  @override
  String get meAutoFileBody => 'File payments that match a rule without asking';

  @override
  String get meEditProfile => 'Edit profile';

  @override
  String get meRules => 'Auto-filing rules';

  @override
  String get meSettings => 'Settings';

  @override
  String get meSettingsSection => 'App';

  @override
  String get meSupport => 'Support';

  @override
  String get meHelp => 'Help';

  @override
  String get meReport => 'Report a problem';

  @override
  String get helpSearch => 'Search help';

  @override
  String get helpReportCta => 'Still stuck? Report a problem';

  @override
  String get helpNoResultsTitle => 'No results';

  @override
  String get helpNoResults => 'Try other words, or report a problem.';

  @override
  String get helpDidThisHelp => 'Did this help?';

  @override
  String get helpYes => 'Yes';

  @override
  String get helpNo => 'No';

  @override
  String get helpThanks => 'Thanks for the note.';

  @override
  String get helpOpenSettings => 'Open notification settings';

  @override
  String get reportWhat => 'What\'s it about?';

  @override
  String get reportCatBroke => 'Something broke';

  @override
  String get reportCatIdea => 'Idea';

  @override
  String get reportCatQuestion => 'Question';

  @override
  String get reportCatOther => 'Other';

  @override
  String get reportWhatHappened => 'What happened?';

  @override
  String get reportHint =>
      'e.g. I pasted my MoMo SMS and it said the amount didn\'t match';

  @override
  String get reportCaption =>
      'Please don\'t include account numbers or full messages.';

  @override
  String get reportAttach => 'Attach app info';

  @override
  String get reportAttachBody =>
      'App version, Android version, phone model. No money data or messages';

  @override
  String get reportInfo =>
      'This opens your email app with the report filled in. Buckets doesn\'t send anything itself.';

  @override
  String reportNoEmail(String address) {
    return 'No email app found. Email us at $address.';
  }

  @override
  String get reportOpenEmail => 'Open email app';

  @override
  String get reportSent => 'Opened your email app.';

  @override
  String get reportNeedsText => 'Tell us what happened first.';

  @override
  String aboutVersion(String version, String build) {
    return 'Version $version · build $build';
  }

  @override
  String get aboutTagline => 'Give every kwacha a job.';

  @override
  String get aboutPrivacy => 'Our privacy promise';

  @override
  String get aboutPrivacyBody => 'Offline, no ads, no selling data';

  @override
  String get aboutHow => 'How Buckets works';

  @override
  String get aboutHowBody => 'Buckets, splits, payday proof';

  @override
  String get aboutRate => 'Rate on Google Play';

  @override
  String get aboutLicences => 'Open-source licences';

  @override
  String get aboutDisclaimer =>
      'Buckets doesn\'t give financial advice. It helps you follow the plan you set.';

  @override
  String get meAboutApp => 'About';

  @override
  String get settingsReminders => 'Payday & reminders';

  @override
  String get settingsQuietHours => 'Quiet hours';

  @override
  String get settingsCheckIn => 'Sunday check-in';

  @override
  String get settingsBillReminders => 'Bill reminders';

  @override
  String get settingsBillRemindersBody => 'A couple of days before each bill';

  @override
  String get settingsPrivacy => 'Privacy & security';

  @override
  String get settingsData => 'Data & privacy';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsAppearanceBody => 'Dark theme';

  @override
  String get settingsComingSoon => 'Coming in 1.1';

  @override
  String get lockImmediately => 'Immediately';

  @override
  String get lockOneMinute => '1 min';

  @override
  String get lockFiveMinutes => '5 min';

  @override
  String get securityNoLock => 'Set a screen lock on your phone first';

  @override
  String get securityHideAmounts => 'Hide amounts on Home';

  @override
  String get securityHideAmountsBody => 'Show K •••• until you tap a balance';

  @override
  String get securityInfo =>
      'Buckets uses your phone\'s own screen lock, so there\'s no extra PIN to remember.';

  @override
  String get dataPositive =>
      'Everything stays on this phone. No account, no internet.';

  @override
  String get dataStorageAlerts => 'Stored alerts';

  @override
  String get dataStorageReceipts => 'Saved receipts';

  @override
  String get dataStorageSize => 'Database size';

  @override
  String get dataClearAlerts => 'Clear alert history';

  @override
  String get dataClearAlertsBody =>
      'Delete stored message text now; your sorted payments stay';

  @override
  String get dataClearConfirm =>
      'Delete the stored raw message text now? Your sorted payments are kept.';

  @override
  String get dataDeleteAll => 'Delete all data';

  @override
  String get dataDeleteAllBody =>
      'Wipes the database, receipts and settings on this phone';

  @override
  String get dataDeleteConfirm =>
      'This permanently deletes everything on this phone and cannot be undone. Type DELETE to confirm.';

  @override
  String get dataDeleteKeyword => 'DELETE';

  @override
  String get rulesCategories => 'Categories';

  @override
  String get rulesAdd => 'Add';

  @override
  String get rulesAddCategory => 'Add a category';

  @override
  String get rulesCategoryName => 'Name';

  @override
  String get rulesDuplicate => 'You already have a category with that name.';

  @override
  String get rulesEmpty =>
      'Rules appear here when you tick \"Always file\" while sorting a payment.';

  @override
  String get rulesSaved => 'Saved rules';

  @override
  String get rulesDelete => 'Remove rule';

  @override
  String get meAbout => 'About & privacy';

  @override
  String get meAboutBody =>
      'Buckets keeps everything on this phone. No account, no internet, no ads. Your messages and receipts never leave the device.';

  @override
  String get meSaved => 'Saved.';

  @override
  String get errAppLockUnavailable => 'Set a screen lock on your phone first.';

  @override
  String get errAppLockCancelled => 'Unlock to change this.';

  @override
  String get errCoolingOffHours => 'Pick 24, 48 or 72 hours.';

  @override
  String get lockTitle => 'Buckets is locked';

  @override
  String get lockBody => 'Unlock with your fingerprint or PIN.';

  @override
  String get lockUnlock => 'Unlock';

  @override
  String get manageBucket => 'Manage bucket';

  @override
  String get moveMoney => 'Move money';

  @override
  String get moneyAlreadyIn => 'Money already in it';

  @override
  String get removeBucket => 'Remove bucket';

  @override
  String get moveTitle => 'Move money';

  @override
  String get moveTo => 'Move to';

  @override
  String moveMost(String amount) {
    return 'You can move up to $amount.';
  }

  @override
  String get moveAction => 'Move';

  @override
  String get movePickDestination => 'Choose a bucket';

  @override
  String moveDone(String amount, String bucket) {
    return '$amount moved to $bucket';
  }

  @override
  String get moveConfirmProtectedTitle => 'Move from your savings?';

  @override
  String moveConfirmProtectedBody(String bucket) {
    return '$bucket is money you set aside to protect. Move it only if you mean to.';
  }

  @override
  String get moveConfirmBelowTitle => 'Dip into this cycle\'s savings?';

  @override
  String moveConfirmBelowBody(String bucket) {
    return 'This drops $bucket below what it held at your last payday.';
  }

  @override
  String get moveConfirmYes => 'Yes, move it';

  @override
  String get errExceedsAvailable => 'That\'s more than this bucket can move.';

  @override
  String get startingTitle => 'Money already in it';

  @override
  String startingBody(String bucket) {
    return 'Add money you already had in $bucket before Buckets. It counts in the balance, not as saved this cycle.';
  }

  @override
  String get startingAction => 'Save';

  @override
  String get startingSaved => 'Starting balance saved';

  @override
  String get homeStartingCard => 'Already have some savings?';

  @override
  String get homeStartingCardBody =>
      'Add starting balances so goals are accurate.';

  @override
  String get homeStartingPick => 'Which bucket?';

  @override
  String removeTitle(String bucket) {
    return 'Remove $bucket?';
  }

  @override
  String get removeBodyEmpty =>
      'This bucket will be removed. Its history stays.';

  @override
  String removeBodyMoney(String amount, String dest) {
    return 'Its $amount moves to $dest first, then the bucket is removed.';
  }

  @override
  String get removeMoveWhere => 'Move its money to';

  @override
  String get removeConfirm => 'Remove';

  @override
  String removeDone(String bucket) {
    return '$bucket removed';
  }

  @override
  String get errTransferOpen =>
      'Finish this payday before removing the bucket.';

  @override
  String get errBucketOverspent =>
      'Cover what this bucket owes before removing it.';

  @override
  String homeGreetingNamed(String greeting, String name) {
    return '$greeting, $name';
  }

  @override
  String get homeFirstPayday => 'First payday';

  @override
  String homeDaysValue(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days days',
      one: '1 day',
      zero: 'Today',
    );
    return '$_temp0';
  }

  @override
  String get homeYourBuckets => 'Your buckets';

  @override
  String get homeAllZero => 'All at K 0';

  @override
  String homeFirstRunBodyAmounts(String income, String toSavings) {
    return 'On payday we\'ll split $income, then remind you to move $toSavings to savings.';
  }
}
