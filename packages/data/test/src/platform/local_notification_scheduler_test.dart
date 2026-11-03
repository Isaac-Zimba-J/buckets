import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/platform/android_payment_alert_source.dart';
import 'package:buckets_data/src/platform/local_notification_scheduler.dart';
import 'package:buckets_data/src/platform/notifications_api.dart';
import 'package:buckets_data/src/platform/platform_permission_gateway.dart';
import 'package:buckets_data/src/platform/sent_log.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeNotificationsApi implements NotificationsApi {
  final channels = <String, bool>{};
  final shown = <NotificationRequest>[];
  final scheduled = <int, (NotificationRequest, bool)>{};
  final cancelled = <int>[];
  bool exactAllowed = true;
  bool enabled = false;
  bool fails = false;

  @override
  Future<void> initialize(void Function(String payload) onTap) async {}

  @override
  Future<void> createChannel(
    String id,
    String name, {
    required bool high,
  }) async {
    if (fails) throw Exception('plugin');
    channels[id] = high;
  }

  @override
  Future<void> show(NotificationRequest request) async => shown.add(request);

  @override
  Future<void> schedule(
    NotificationRequest request, {
    required bool exact,
  }) async => scheduled[request.id] = (request, exact);

  @override
  Future<void> cancel(int id) async {
    cancelled.add(id);
    scheduled.remove(id);
  }

  @override
  Future<List<int>> pendingIds() async => scheduled.keys.toList();

  @override
  Future<bool> canScheduleExact() async => exactAllowed;

  @override
  Future<bool> requestPermission() async => enabled = true;

  @override
  Future<bool> requestExactAlarms() async => exactAllowed = true;

  @override
  Future<bool> areEnabled() async => enabled;
}

class FixedClock implements Clock {
  @override
  DateTime now() => DateTime.utc(2026, 10, 30, 8);
}

ScheduledNotification n(
  String id,
  NotificationKind kind, {
  int minutes = 30,
  Map<String, String> args = const {},
}) => ScheduledNotification(
  id: id,
  kind: kind,
  at: DateTime.utc(2026, 10, 30, 8).add(Duration(minutes: minutes)),
  deepLink: 'buckets://$id',
  args: args,
);

void main() {
  late FakeNotificationsApi api;
  late LocalNotificationScheduler scheduler;
  setUp(() {
    api = FakeNotificationsApi();
    scheduler = LocalNotificationScheduler(
      copy: (x) => (title: 'T:${x.kind.name}', body: 'B:${x.args}'),
      channelNames: {NotificationKind.payday: 'Payday alarm'},
      clock: FixedClock(),
      api: api,
      sentLog: MemorySentLog(),
    );
  });

  test(
    'one channel per kind; only the payday alarm is high importance',
    () async {
      await scheduler.replaceAll(const []);
      expect(api.channels, hasLength(NotificationKind.values.length));
      expect(api.channels['buckets.payday'], isTrue);
      expect(api.channels['buckets.bill'], isFalse);
    },
  );

  test(
    'schedules future notifications with copy, channel and deep link',
    () async {
      await scheduler.replaceAll([
        n('payday/p', NotificationKind.payday, args: {'pending': '4'}),
      ]);
      final (request, exact) = api.scheduled.values.single;
      expect(request.title, 'T:payday');
      expect(request.body, 'B:{pending: 4}');
      expect(request.channelId, 'buckets.payday');
      expect(request.payload, 'buckets://payday/p');
      expect(request.high, isTrue);
      expect(exact, isTrue);
    },
  );

  test('falls back to inexact alarms when exact ones are refused', () async {
    api.exactAllowed = false;
    await scheduler.replaceAll([n('bill-b', NotificationKind.bill)]);
    expect(api.scheduled.values.single.$2, isFalse);
  });

  test('anything already due is shown now', () async {
    await scheduler.replaceAll([
      n('alert-a', NotificationKind.alert, minutes: 0),
    ]);
    expect(api.shown.single.payload, 'buckets://alert-a');
    expect(api.scheduled, isEmpty);
  });

  test(
    'replaceAll cancels what is no longer wanted and keeps stable IDs',
    () async {
      await scheduler.replaceAll([
        n('bill-a', NotificationKind.bill),
        n('bill-b', NotificationKind.bill),
      ]);
      await scheduler.replaceAll([n('bill-a', NotificationKind.bill)]);
      expect(api.scheduled.keys, [
        LocalNotificationScheduler.numericId('bill-a'),
      ]);
      expect(api.cancelled, [LocalNotificationScheduler.numericId('bill-b')]);
      expect(
        LocalNotificationScheduler.numericId('bill-a'),
        LocalNotificationScheduler.numericId('bill-a'),
      );
    },
  );

  test('N-LOW goes out once per ID, even if planned again', () async {
    await scheduler.replaceAll([n('low-c1', NotificationKind.low)]);
    await scheduler.replaceAll([n('low-c1', NotificationKind.low)]);
    expect(api.scheduled, hasLength(1));
    await scheduler.replaceAll([n('low-c2', NotificationKind.low)]);
    expect(
      api.scheduled.keys,
      contains(LocalNotificationScheduler.numericId('low-c2')),
    );
  });

  test('cancel by string ID', () async {
    await scheduler.replaceAll([n('wish-w', NotificationKind.wish)]);
    expect(await scheduler.cancel('wish-w'), isA<Ok<void>>());
    expect(api.scheduled, isEmpty);
  });

  test('plugin errors become a safe PlatformFailure', () async {
    api.fails = true;
    final result = await scheduler.replaceAll(const []);
    expect((result as Err).failure.code, 'notifications.failed');
  });

  group('PlatformPermissionGateway', () {
    late PlatformPermissionGateway gateway;
    setUp(
      () => gateway = PlatformPermissionGateway(
        notifications: api,
        alerts: AndroidPaymentAlertSource(),
      ),
    );

    PermissionState? state(Result<PermissionState> r) =>
        r is Ok<PermissionState> ? r.value : null;

    test('notifications and exact alarms', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      expect(
        state(await gateway.status(AppPermission.notifications)),
        PermissionState.denied,
      );
      expect(
        state(await gateway.request(AppPermission.notifications)),
        PermissionState.granted,
      );
      api.exactAllowed = false;
      expect(
        state(await gateway.status(AppPermission.exactAlarms)),
        PermissionState.denied,
      );
      expect(
        state(await gateway.request(AppPermission.exactAlarms)),
        PermissionState.granted,
      );
      expect(
        state(await gateway.status(AppPermission.camera)),
        PermissionState.granted,
      );
      expect(
        state(await gateway.status(AppPermission.notificationAccess)),
        PermissionState.denied,
      );
    });
  });
}
