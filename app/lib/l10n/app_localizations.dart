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
