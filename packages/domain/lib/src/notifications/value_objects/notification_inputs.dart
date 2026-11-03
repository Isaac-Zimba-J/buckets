import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/local_date.dart';

/// An open payday with transfers still to move (N-PAYDAY).
final class PaydayAlarmInput {
  /// Creates the input.
  const new({
    required this.paydayId,
    required this.pendingTransfers,
    this.snoozedUntil,
  });

  /// The open payday.
  final String paydayId;

  /// Transfers not yet proven or self-reported.
  final int pendingTransfers;

  /// When a snooze ends (R-PAY-4), if one is running.
  final DateTime? snoozedUntil;
}

/// A payment alert not yet notified (N-ALERT, N-INCOME).
final class AlertInput {
  /// Creates the input.
  const new({
    required this.alertId,
    required this.receivedAt,
    this.isIncome = false,
  });

  /// The alert.
  final String alertId;

  /// When the phone received it, in UTC.
  final DateTime receivedAt;

  /// Incoming money that isn't salary (R-PARSE-5).
  final bool isIncome;
}

/// A bill's next due date (N-BILL).
final class BillDueInput {
  /// Creates the input.
  const new({required this.billId, required this.dueDate});

  /// The bill.
  final String billId;

  /// The local due date.
  final LocalDate dueDate;
}

/// A wish still cooling off (N-WISH).
final class WishEndInput {
  /// Creates the input.
  const new({required this.wishId, required this.endsAt});

  /// The wish.
  final String wishId;

  /// When cooling-off ends, in UTC.
  final DateTime endsAt;
}

/// Living's state this cycle (N-LOW).
final class LowLivingInput {
  /// Creates the input.
  const new({
    required this.livingBucketId,
    required this.left,
    required this.allocation,
    required this.daysLeft,
    required this.cycleStart,
    required this.alreadyNotified,
  });

  /// The Living bucket.
  final String livingBucketId;

  /// Living's left to spend.
  final Money left;

  /// Living's allocation this cycle.
  final Money allocation;

  /// Days left in the cycle.
  final int daysLeft;

  /// When the cycle started; identifies "once per cycle".
  final DateTime cycleStart;

  /// Whether N-LOW was already shown this cycle.
  final bool alreadyNotified;
}

/// Everything `NotificationPolicy` needs to decide the schedule.
final class NotificationInputs {
  /// Creates the inputs; anything absent schedules nothing.
  const new({
    this.payday,
    this.alerts = const [],
    this.bills = const [],
    this.wishes = const [],
    this.checkIn = false,
    this.low,
  });

  /// The open payday, if any.
  final PaydayAlarmInput? payday;

  /// New alerts to notify.
  final List<AlertInput> alerts;

  /// Bills with a next due date.
  final List<BillDueInput> bills;

  /// Wishes cooling off.
  final List<WishEndInput> wishes;

  /// Whether the weekly check-in is set up (after setup).
  final bool checkIn;

  /// Living's state, if a cycle is running.
  final LowLivingInput? low;
}
