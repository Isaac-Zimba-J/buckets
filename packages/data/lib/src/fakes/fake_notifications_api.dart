import 'package:buckets_data/src/platform/notifications_api.dart';

/// A [NotificationsApi] that shows nothing; tests [tap] notifications and
/// set the [launch] payload.
class FakeNotificationsApi implements NotificationsApi {
  /// Creates the fake with an optional [launch] payload.
  FakeNotificationsApi({this.launch});

  /// The payload of the notification that "launched" the app.
  String? launch;

  void Function(String payload)? _onTap;

  /// Simulates the user tapping a notification carrying [payload].
  void tap(String payload) => _onTap?.call(payload);

  @override
  Future<void> initialize(void Function(String payload) onTap) async =>
      _onTap = onTap;

  @override
  Future<String?> launchPayload() async => launch;

  @override
  Future<void> createChannel(String id, String name, {required bool high}) =>
      Future.value();

  @override
  Future<void> show(NotificationRequest request) => Future.value();

  @override
  Future<void> schedule(NotificationRequest request, {required bool exact}) =>
      Future.value();

  @override
  Future<void> cancel(int id) => Future.value();

  @override
  Future<List<int>> pendingIds() async => const [];

  @override
  Future<bool> canScheduleExact() async => true;

  @override
  Future<bool> requestPermission() async => true;

  @override
  Future<bool> requestExactAlarms() async => true;

  @override
  Future<bool> areEnabled() async => true;
}
