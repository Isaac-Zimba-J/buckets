import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/platform/notifications_api.dart';
import 'package:buckets_data/src/platform/sent_log.dart';
import 'package:buckets_domain/buckets_domain.dart';

/// Title and body for a notification, from the app's strings (ARB).
typedef NotificationCopy = ({String title, String body}) Function(
  ScheduledNotification notification,
);

/// [NotificationScheduler] on Android local notifications (ARCHITECTURE §7).
/// Executes what `NotificationPolicy` decided; decides nothing itself.
final class LocalNotificationScheduler implements NotificationScheduler {
  /// Creates the scheduler. [copy] and [channelNames] come from the app's
  /// strings; [_clock] decides what is already due.
  new({
    required this.copy,
    required this.channelNames,
    required this._clock,
    NotificationsApi? api,
    SentLog? sentLog,
  }) : _api = api ?? PluginNotificationsApi(),
       _sent = sentLog ?? PrefsSentLog();

  /// Builds each notification's text.
  final NotificationCopy copy;

  /// The user-visible channel name per kind (Android settings).
  final Map<NotificationKind, String> channelNames;

  final Clock _clock;
  final NotificationsApi _api;
  final SentLog _sent;
  bool _channelsReady = false;

  /// Kinds shown at most once per ID, even across restarts.
  static const Set<NotificationKind> onceOnly = {NotificationKind.low};

  /// The Android channel of [kind]: one per notification type, so each can
  /// be muted except the payday alarm (PATTERNS.md).
  static String channelOf(NotificationKind kind) => 'buckets.${kind.name}';

  /// A stable 31-bit ID for [id] (FNV-1a), so replacing works across runs.
  static int numericId(String id) {
    var hash = 0x811c9dc5;
    for (final unit in id.codeUnits) {
      hash = ((hash ^ unit) * 0x01000193) & 0x7fffffff;
    }
    return hash;
  }

  Future<void> _ensureChannels() async {
    if (_channelsReady) return;
    for (final kind in NotificationKind.values) {
      await _api.createChannel(
        channelOf(kind),
        channelNames[kind] ?? kind.name,
        high: kind == NotificationKind.payday,
      );
    }
    _channelsReady = true;
  }

  @override
  Future<Result<void>> replaceAll(
    List<ScheduledNotification> notifications,
  ) async {
    try {
      await _ensureChannels();
      final now = _clock.now();
      final exact = await _api.canScheduleExact();
      final wanted = <int>{};
      for (final n in notifications) {
        final request = _request(n);
        wanted.add(request.id);
        // Already handed over once: leave it scheduled, don't repeat it.
        if (onceOnly.contains(n.kind) && await _sent.wasSent(n.id)) continue;
        if (n.at.isAfter(now)) {
          await _api.schedule(request, exact: exact);
        } else {
          await _api.show(request);
        }
        if (onceOnly.contains(n.kind)) await _sent.markSent(n.id);
      }
      for (final id in await _api.pendingIds()) {
        if (!wanted.contains(id)) await _api.cancel(id);
      }
      return const Ok(null);
    } on Exception {
      return const Err(
        PlatformFailure('notifications.failed', "Couldn't set reminders."),
      );
    }
  }

  NotificationRequest _request(ScheduledNotification n) {
    final text = copy(n);
    return (
      id: numericId(n.id),
      channelId: channelOf(n.kind),
      title: text.title,
      body: text.body,
      payload: n.deepLink,
      at: n.at,
      high: n.kind == NotificationKind.payday,
    );
  }

  @override
  Future<Result<void>> cancel(String id) async {
    try {
      await _api.cancel(numericId(id));
      return const Ok(null);
    } on Exception {
      return const Err(
        PlatformFailure('notifications.failed', "Couldn't cancel a reminder."),
      );
    }
  }
}
