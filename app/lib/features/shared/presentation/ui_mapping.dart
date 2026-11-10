import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';

/// Domain → ui_kit values for screens. No rules here, only lookups.
extension BucketColorBk on BucketColor {
  /// The ui_kit colour for this bucket colour.
  BkBucketColor get bk => switch (this) {
    BucketColor.living => BkBucketColor.living,
    BucketColor.fun => BkBucketColor.fun,
    BucketColor.emergency => BkBucketColor.emergency,
    BucketColor.short => BkBucketColor.short,
    BucketColor.long => BkBucketColor.long,
    BucketColor.goal => BkBucketColor.goal,
    BucketColor.family => BkBucketColor.family,
    BucketColor.business => BkBucketColor.business,
  };
}

/// `K 1,540` (WRITING.md money format).
String money(Money amount, {bool showNgwee = false, bool signed = false}) =>
    MoneyFormatter.format(amount, showNgwee: showNgwee, signed: signed);

/// Labels for account kinds.
extension AccountKindLabel on AccountKind {
  /// The label shown in pickers.
  String label(AppLocalizations l) => switch (this) {
    AccountKind.bank => l.accountKindBank,
    AccountKind.mtnMomo => l.accountKindMtn,
    AccountKind.airtelMoney => l.accountKindAirtel,
    AccountKind.cash => l.accountKindCash,
    AccountKind.investment => l.accountKindInvestment,
    AccountKind.other => l.accountKindOther,
  };
}

/// A validation code from a controller as a sentence; unknown codes get
/// the generic message.
String errorText(AppLocalizations l, String code) => switch (code) {
  'amount.notPositive' || 'expectedAmount.notPositive' => l.errAmount,
  'payday.outOfRange' || 'dueDay.outOfRange' => l.errDay,
  'name.blank' => l.errName,
  'matchKey.tooShort' => l.errMatchKey,
  'setup.noIncome' => l.errNoIncome,
  'accounts.noSpending' => l.errNoSpending,
  'accounts.manySpending' => l.errManySpending,
  'split.tooMuch' || 'split.tooLittle' => l.errSplitTotal,
  'nextDueDate.missing' => l.errNextDue,
  'snooze.noneLeft' => l.paydaySnoozeNoneLeft,
  'snooze.tooLate' => l.paydaySnoozeTooLate,
  _ => l.errGeneric,
};

/// The wall-clock time in the user's zone for a UTC instant (R-TIME-1),
/// for `DateFormatter`.
DateTime wallTime(DateTime utc, LocalTimeZone zone) =>
    utc.toUtc().add(zone.offsetAt(utc));
