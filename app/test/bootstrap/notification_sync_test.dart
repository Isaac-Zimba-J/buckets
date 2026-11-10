import 'dart:async';

import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/notification_sync.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/routing/deep_links.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/setup/screens/screen_harness.dart';

Future<void> tick() => Future<void>.delayed(const Duration(milliseconds: 5));

void main() {
  test('runs once on start and once per burst of changes', () async {
    var runs = 0;
    final a = StreamController<int>();
    final b = StreamController<int>();
    final sync = NotificationSync(
      () async => runs++,
      triggers: [a.stream, b.stream],
    );
    await tick();
    expect(runs, 1);
    a.add(1);
    b.add(1);
    a.add(2);
    await tick();
    expect(runs, 2);
    sync.refresh();
    await tick();
    expect(runs, 3);
    await sync.dispose();
    a.add(3);
    await tick();
    expect(runs, 3);
    await a.close();
    await b.close();
  });

  test('a started payday schedules N-PAYDAY linking to screen 13', () async {
    final c = fakeContainer();
    addTearDown(c.dispose);
    (await seedDemo(c)).orThrow();
    c.read(notificationSyncProvider);
    await Future<void>.delayed(const Duration(milliseconds: 50));
    final scheduler =
        c.read(notificationSchedulerProvider) as FakeNotificationScheduler;
    final payday = scheduler.scheduled.firstWhere(
      (n) => n.kind == NotificationKind.payday,
    );
    final open = (await c.read(paydayRepositoryProvider).getAll())
        .orThrow()
        .single;
    expect(locationForPayload(payday.deepLink), Routes.payday(open.id));
  });
}
