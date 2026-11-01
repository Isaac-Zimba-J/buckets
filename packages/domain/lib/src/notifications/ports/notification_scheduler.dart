import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/notifications/value_objects/scheduled_notification.dart';

/// Shows and schedules local notifications. It only executes; every decision
/// comes from `NotificationPolicy` (DOMAIN §12).
abstract interface class NotificationScheduler {
  /// Makes [notifications] the whole schedule: adds new ones, replaces those
  /// with a known ID and cancels any not in the list.
  Future<Result<void>> replaceAll(List<ScheduledNotification> notifications);

  /// Cancels the notification with [id], if scheduled.
  Future<Result<void>> cancel(String id);
}
