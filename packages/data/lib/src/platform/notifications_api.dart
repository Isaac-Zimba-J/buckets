import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

/// One notification to show, already in final copy.
typedef NotificationRequest = ({
  int id,
  String channelId,
  String title,
  String body,
  String payload,
  DateTime at,
  bool high,
});

/// The parts of flutter_local_notifications the scheduler uses; a seam for
/// tests.
abstract interface class NotificationsApi {
  /// Sets up the plugin; [onTap] receives the payload of a tapped
  /// notification.
  Future<void> initialize(void Function(String payload) onTap);

  /// The payload of the notification whose tap launched the app, if any.
  Future<String?> launchPayload();

  /// Creates the Android channel [id] if missing.
  Future<void> createChannel(String id, String name, {required bool high});

  /// Shows [request] now.
  Future<void> show(NotificationRequest request);

  /// Schedules [request] at its time, exactly when [exact].
  Future<void> schedule(NotificationRequest request, {required bool exact});

  /// Cancels the notification with [id].
  Future<void> cancel(int id);

  /// IDs scheduled but not yet shown.
  Future<List<int>> pendingIds();

  /// Whether exact alarms are allowed (Android 12+ may refuse).
  Future<bool> canScheduleExact();

  /// Asks for the notification permission (Android 13+).
  Future<bool> requestPermission();

  /// Asks for exact alarms (Android 14+).
  Future<bool> requestExactAlarms();

  /// Whether notifications are allowed.
  Future<bool> areEnabled();
}

/// [NotificationsApi] over flutter_local_notifications on Android.
final class PluginNotificationsApi implements NotificationsApi {
  /// Creates the API.
  new();

  final _plugin = FlutterLocalNotificationsPlugin();

  AndroidFlutterLocalNotificationsPlugin? get _android => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  @override
  Future<void> initialize(void Function(String payload) onTap) async {
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
      onDidReceiveNotificationResponse: (r) {
        if (r.payload case final p?) onTap(p);
      },
    );
  }

  @override
  Future<String?> launchPayload() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details == null || !details.didNotificationLaunchApp) return null;
    return details.notificationResponse?.payload;
  }

  @override
  Future<void> createChannel(
    String id,
    String name, {
    required bool high,
  }) async => await _android?.createNotificationChannel(
    AndroidNotificationChannel(
      id,
      name,
      importance: high ? Importance.max : Importance.defaultImportance,
    ),
  );

  NotificationDetails _details(NotificationRequest r) => NotificationDetails(
    android: AndroidNotificationDetails(
      r.channelId,
      r.channelId,
      importance: r.high ? Importance.max : Importance.defaultImportance,
      priority: r.high ? Priority.max : Priority.defaultPriority,
      category: r.high ? AndroidNotificationCategory.alarm : null,
    ),
  );

  @override
  Future<void> show(NotificationRequest r) => _plugin.show(
    id: r.id,
    title: r.title,
    body: r.body,
    notificationDetails: _details(r),
    payload: r.payload,
  );

  @override
  Future<void> schedule(NotificationRequest r, {required bool exact}) =>
      _plugin.zonedSchedule(
        id: r.id,
        scheduledDate: tz.TZDateTime.from(r.at, tz.UTC),
        notificationDetails: _details(r),
        androidScheduleMode: exact
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle,
        title: r.title,
        body: r.body,
        payload: r.payload,
      );

  @override
  Future<void> cancel(int id) => _plugin.cancel(id: id);

  @override
  Future<List<int>> pendingIds() async => [
    for (final p in await _plugin.pendingNotificationRequests()) p.id,
  ];

  @override
  Future<bool> canScheduleExact() async =>
      await _android?.canScheduleExactNotifications() ?? false;

  @override
  Future<bool> requestPermission() async =>
      await _android?.requestNotificationsPermission() ?? false;

  @override
  Future<bool> requestExactAlarms() async =>
      await _android?.requestExactAlarmsPermission() ?? false;

  @override
  Future<bool> areEnabled() async =>
      await _android?.areNotificationsEnabled() ?? false;
}
