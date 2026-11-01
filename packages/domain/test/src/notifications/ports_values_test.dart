import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

void main() {
  test('platform values only take UTC times', () {
    final local = DateTime(2026, 10, 30, 9);
    expect(
      () => ScheduledNotification(
        id: 'n',
        kind: NotificationKind.checkIn,
        at: local,
        deepLink: 'buckets://checkin',
      ),
      throwsArgumentError,
    );
    expect(
      () => IncomingAlertText(packageName: 'p', text: 't', receivedAt: local),
      throwsArgumentError,
    );
  });
}
