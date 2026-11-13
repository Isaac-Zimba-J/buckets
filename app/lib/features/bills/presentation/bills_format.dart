import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';

/// A [LocalDate] as a wall-clock date for `DateFormatter`.
DateTime wallDate(LocalDate d) => DateTime.utc(d.year, d.month, d.day);

/// Labels and colours for mobile-money providers and fee types.
extension AlertSourceBills on AlertSource {
  /// The provider's name.
  String label(AppLocalizations l) => switch (this) {
    AlertSource.mtnMomo => l.accountKindMtn,
    AlertSource.airtelMoney => l.accountKindAirtel,
    AlertSource.bank => l.accountKindBank,
    AlertSource.unknown => l.accountKindOther,
  };

  /// The bar colour on the Fees page.
  BkBucketColor get color => switch (this) {
    AlertSource.mtnMomo => BkBucketColor.fun,
    AlertSource.airtelMoney => BkBucketColor.emergency,
    AlertSource.bank => BkBucketColor.long,
    AlertSource.unknown => BkBucketColor.short,
  };
}

/// What a fee was for.
extension FeeTypeLabel on FeeType {
  /// The label on screens 36 and 37.
  String label(AppLocalizations l) => switch (this) {
    FeeType.send => l.feeTypeSend,
    FeeType.cashOut => l.feeTypeCashOut,
    FeeType.billPay => l.feeTypeBillPay,
    FeeType.merchantPay => l.feeTypeMerchantPay,
    FeeType.other => l.feeTypeOther,
  };
}
