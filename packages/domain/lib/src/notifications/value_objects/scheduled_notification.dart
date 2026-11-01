import 'package:equatable/equatable.dart';

/// The notification types in DOMAIN §12.
enum NotificationKind {
  /// N-PAYDAY: move your savings.
  payday,

  /// N-ALERT: a payment to sort.
  alert,

  /// N-INCOME: incoming non-salary money.
  income,

  /// N-BILL: a bill is due.
  bill,

  /// N-WISH: cooling-off ended.
  wish,

  /// N-CHECKIN: the weekly check-in.
  checkIn,

  /// N-LOW: Living is running low.
  low,
}

/// One notification that `NotificationPolicy` decided to show. The adapter
/// turns [kind] and [args] into copy; the domain holds no display text.
final class ScheduledNotification with Equatable {
  /// Creates a notification. Throws an [ArgumentError] unless [at] is UTC.
  ScheduledNotification({
    required this.id,
    required this.kind,
    required this.at,
    required this.deepLink,
    this.args = const {},
  }) {
    if (!at.isUtc) throw ArgumentError.value(at, 'at', 'must be UTC');
  }

  /// Stable ID; scheduling the same ID again replaces it.
  final String id;

  /// What it is about.
  final NotificationKind kind;

  /// When to show it, in UTC.
  final DateTime at;

  /// Where tapping it goes, e.g. `buckets://payday/<id>` (R-NOTIF-4).
  final String deepLink;

  /// Values for the copy, e.g. a formatted amount.
  final Map<String, String> args;

  @override
  List<Object?> get props => [id, kind, at, deepLink, args];
}
