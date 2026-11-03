// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

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
}
