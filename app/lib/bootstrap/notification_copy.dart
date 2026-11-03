import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_data/buckets_data.dart';
import 'package:buckets_domain/buckets_domain.dart';

/// Notification text from the app's strings (R-NOTIF-3).
NotificationCopy notificationCopy(AppLocalizations s) => (n) {
  int arg(String key) => int.tryParse(n.args[key] ?? '') ?? 1;
  return switch (n.kind) {
    NotificationKind.payday => (
      title: s.notifPaydayTitle,
      body: s.notifPaydayBody(arg('pending')),
    ),
    NotificationKind.alert => (
      title: s.notifAlertTitle(arg('count')),
      body: s.notifAlertBody,
    ),
    NotificationKind.income => (
      title: s.notifIncomeTitle,
      body: s.notifIncomeBody,
    ),
    NotificationKind.bill => (title: s.notifBillTitle, body: s.notifBillBody),
    NotificationKind.wish => (title: s.notifWishTitle, body: s.notifWishBody),
    NotificationKind.checkIn => (
      title: s.notifCheckInTitle,
      body: s.notifCheckInBody,
    ),
    NotificationKind.low => (title: s.notifLowTitle, body: s.notifLowBody),
  };
};

/// Android channel names shown in system settings.
Map<NotificationKind, String> channelNames(AppLocalizations s) => {
  NotificationKind.payday: s.channelPayday,
  NotificationKind.alert: s.channelAlert,
  NotificationKind.income: s.channelIncome,
  NotificationKind.bill: s.channelBill,
  NotificationKind.wish: s.channelWish,
  NotificationKind.checkIn: s.channelCheckIn,
  NotificationKind.low: s.channelLow,
};
