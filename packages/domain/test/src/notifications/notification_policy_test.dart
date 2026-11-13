import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

const lusaka = Duration(hours: 2);

/// Lusaka wall-clock time on [day] Oct/Nov 2026 as UTC.
DateTime local(int day, int hour, [int minute = 0, int month = 10]) =>
    DateTime.utc(2026, month, day, hour, minute).subtract(lusaka);

List<ScheduledNotification> plan(
  NotificationInputs inputs, {
  DateTime? now,
  Settings? settings,
}) => NotificationPolicy.plan(
  inputs,
  settings: settings ?? Settings.defaults,
  now: now ?? local(30, 10),
  utcOffset: lusaka,
);

List<ScheduledNotification> ofKind(
  List<ScheduledNotification> all,
  NotificationKind kind,
) => all.where((n) => n.kind == kind).toList();

void main() {
  group('N-PAYDAY', () {
    PaydayAlarmInput alarm({DateTime? snoozedUntil, int pending = 4}) =>
        PaydayAlarmInput(
          paydayId: 'p1',
          pendingTransfers: pending,
          snoozedUntil: snoozedUntil,
        );

    test('immediately, then every 30 min while transfers are pending', () {
      final n = ofKind(
        plan(NotificationInputs(payday: alarm()), now: local(30, 19)),
        NotificationKind.payday,
      );
      expect(n.take(4).map((x) => x.at), [
        local(30, 19),
        local(30, 19, 30),
        local(30, 20),
        local(30, 20, 30),
      ]);
      expect(n.first.deepLink, 'buckets://payday/p1');
      expect(n.first.args, {'pending': '4'});
      expect(n.map((x) => x.id).toSet(), hasLength(n.length));
    });

    test('R-NOTIF-1 skips quiet hours and resumes at 07:00 (R-PAY-4)', () {
      final n = ofKind(
        plan(NotificationInputs(payday: alarm()), now: local(30, 20, 15)),
        NotificationKind.payday,
      );
      expect(n.take(3).map((x) => x.at), [
        local(30, 20, 15),
        local(30, 20, 45),
        local(31, 7),
      ]);
      expect(n.last.at.isBefore(local(31, 20, 15)), isTrue);
    });

    test('a snooze starts the alarm at the snooze time', () {
      final n = ofKind(
        plan(
          NotificationInputs(payday: alarm(snoozedUntil: local(30, 20))),
          now: local(30, 10),
        ),
        NotificationKind.payday,
      );
      expect(n.first.at, local(30, 20));
      expect(n[1].at, local(30, 20, 30));
    });

    test('nothing once no transfers are pending', () {
      expect(plan(NotificationInputs(payday: alarm(pending: 0))), isEmpty);
    });
  });

  group('N-ALERT and N-INCOME', () {
    test('new alerts fire now, grouped when within 5 minutes', () {
      final n = plan(
        NotificationInputs(
          alerts: [
            AlertInput(alertId: 'a1', receivedAt: local(30, 9, 50)),
            AlertInput(alertId: 'a2', receivedAt: local(30, 9, 54)),
          ],
        ),
      );
      final alert = n.single;
      expect(alert.kind, NotificationKind.alert);
      expect(alert.at, local(30, 10));
      expect(alert.args, {'count': '2'});
      expect(alert.deepLink, 'buckets://alert/a1');
    });

    test('incoming non-salary money gets its own notification', () {
      final n = plan(
        NotificationInputs(
          alerts: [
            AlertInput(
              alertId: 'in1',
              receivedAt: local(30, 9, 59),
              isIncome: true,
            ),
          ],
        ),
      );
      expect(n.single.kind, NotificationKind.income);
      expect(n.single.deepLink, 'buckets://alert/in1');
    });
  });

  group('N-BILL-DUE-TODAY and N-BILL-OVERDUE', () {
    List<ScheduledNotification> unpaid() => plan(
      NotificationInputs(
        unpaidBills: [
          BillDueInput(billId: 'zesco', dueDate: LocalDate(2026, 11, 5)),
        ],
      ),
    );

    test('due today at 09:00 opens the pay sheet', () {
      final n = unpaid().where((x) => x.kind == NotificationKind.billDueToday);
      expect(n.single.at, local(5, 9, 0, 11));
      expect(n.single.deepLink, 'buckets://plan/bills/zesco/pay');
    });

    test('overdue: the day after, then every 3 days, three times', () {
      final n = unpaid().where((x) => x.kind == NotificationKind.billOverdue);
      expect(n.map((x) => x.at), [
        local(6, 9, 0, 11),
        local(9, 9, 0, 11),
        local(12, 9, 0, 11),
      ]);
      expect(n.first.deepLink, 'buckets://plan/bills');
    });

    test('nothing for a bill that is not unpaid', () {
      expect(plan(const NotificationInputs()), isEmpty);
    });
  });

  group('N-BILL', () {
    test('2 days before the due date at 09:00', () {
      final n = plan(
        NotificationInputs(
          bills: [
            BillDueInput(billId: 'zesco', dueDate: LocalDate(2026, 11, 5)),
          ],
        ),
      );
      expect(n.single.kind, NotificationKind.bill);
      expect(n.single.at, local(3, 9, 0, 11));
      expect(n.single.deepLink, 'buckets://plan/bills');
    });

    test('a reminder time already past is dropped', () {
      expect(
        plan(
          NotificationInputs(
            bills: [BillDueInput(billId: 'b', dueDate: LocalDate(2026, 11, 1))],
          ),
        ),
        isEmpty,
      );
    });
  });

  group('N-WISH', () {
    test('at the end time, moved out of quiet hours', () {
      final n = plan(
        NotificationInputs(
          wishes: [
            WishEndInput(wishId: 'w1', endsAt: local(30, 15)),
            WishEndInput(wishId: 'w2', endsAt: local(30, 23, 30)),
          ],
        ),
        now: local(30, 9),
      );
      expect(n.map((x) => (x.id, x.at)), [
        ('wish-w1', local(30, 15)),
        ('wish-w2', local(31, 7)),
      ]);
      expect(n.first.deepLink, 'buckets://plan/wish/w1');
    });

    test('an end time already past fires now', () {
      final n = plan(
        NotificationInputs(
          wishes: [WishEndInput(wishId: 'w', endsAt: local(29, 15))],
        ),
      );
      expect(n.single.at, local(30, 10));
    });
  });

  group('N-CHECKIN', () {
    test('the next check-in day at the check-in time', () {
      // 30 Oct 2026 is a Friday; the next Sunday is 1 Nov.
      final n = plan(const NotificationInputs(checkIn: true));
      expect(n.single.kind, NotificationKind.checkIn);
      expect(n.single.at, local(1, 18, 0, 11));
      expect(n.single.deepLink, 'buckets://checkin');
    });

    test('on Sunday after 18:00 it is next week', () {
      final n = plan(
        const NotificationInputs(checkIn: true),
        now: local(1, 18, 0, 11),
      );
      expect(n.single.at, local(8, 18, 0, 11));
    });
  });

  group('N-LOW', () {
    LowLivingInput low({int left = 410, int days = 9, bool sent = false}) =>
        LowLivingInput(
          livingBucketId: 'living',
          left: Money.kwacha(left),
          allocation: const Money.kwacha(3080),
          daysLeft: days,
          cycleStart: local(25, 8),
          alreadyNotified: sent,
        );

    test('Living under 20% with over a week left: 12:00 once per cycle', () {
      final n = plan(NotificationInputs(low: low()), now: local(30, 9));
      expect(n.single.kind, NotificationKind.low);
      expect(n.single.at, local(30, 12));
      expect(n.single.deepLink, 'buckets://bucket/living');
      expect(n.single.id, 'low-${local(25, 8).toIso8601String()}');
    });

    test('after 12:00 it waits for tomorrow', () {
      expect(
        plan(NotificationInputs(low: low()), now: local(30, 13)).single.at,
        local(31, 12),
      );
    });

    test(
      'not at 20% or more, with a week or less left, or if already sent',
      () {
        expect(plan(NotificationInputs(low: low(left: 616))), isEmpty);
        expect(plan(NotificationInputs(low: low(days: 7))), isEmpty);
        expect(plan(NotificationInputs(low: low(sent: true))), isEmpty);
      },
    );
  });

  group('R-NOTIF-2 at most one non-alarm an hour', () {
    test('a second notification within the hour moves an hour later', () {
      final n = plan(
        NotificationInputs(
          alerts: [
            AlertInput(alertId: 'in', receivedAt: local(30, 9), isIncome: true),
          ],
          wishes: [WishEndInput(wishId: 'w', endsAt: local(30, 10, 20))],
        ),
      );
      expect(n.map((x) => (x.kind, x.at)), [
        (NotificationKind.income, local(30, 10)),
        (NotificationKind.wish, local(30, 11)),
      ]);
    });

    test('alert notifications within the hour merge their counts', () {
      final n = plan(
        NotificationInputs(
          alerts: [
            AlertInput(alertId: 'a1', receivedAt: local(30, 9, 30)),
            AlertInput(alertId: 'a2', receivedAt: local(30, 9, 40)),
          ],
        ),
      );
      expect(n.single.args, {'count': '2'});
    });

    test('the payday alarm is not limited', () {
      final n = plan(
        NotificationInputs(
          payday: const PaydayAlarmInput(paydayId: 'p', pendingTransfers: 1),
          wishes: [WishEndInput(wishId: 'w', endsAt: local(30, 10))],
        ),
      );
      expect(ofKind(n, NotificationKind.wish).single.at, local(30, 10));
      expect(ofKind(n, NotificationKind.payday).first.at, local(30, 10));
    });

    test('pushing past 21:00 moves to 07:00', () {
      final n = plan(
        NotificationInputs(
          wishes: [
            WishEndInput(wishId: 'w1', endsAt: local(30, 20, 30)),
            WishEndInput(wishId: 'w2', endsAt: local(30, 20, 40)),
          ],
        ),
      );
      expect(n.map((x) => x.at), [local(30, 20, 30), local(31, 7)]);
    });
  });

  test('deterministic and sorted by time', () {
    final inputs = NotificationInputs(
      checkIn: true,
      wishes: [WishEndInput(wishId: 'w', endsAt: local(30, 15))],
      payday: const PaydayAlarmInput(paydayId: 'p', pendingTransfers: 2),
    );
    final a = plan(inputs);
    expect(a, plan(inputs));
    final times = a.map((n) => n.at).toList();
    expect(times, [...times]..sort());
  });

  test('custom quiet hours that do not wrap midnight', () {
    final settings = switch (Settings.create(
      quietHours: QuietHours(LocalTime(13, 0), LocalTime(14, 0)),
    )) {
      Ok(:final value) => value,
      Err() => throw StateError('bad settings'),
    };
    final n = plan(
      NotificationInputs(
        wishes: [WishEndInput(wishId: 'w', endsAt: local(30, 13, 30))],
      ),
      settings: settings,
    );
    expect(n.single.at, local(30, 14));
  });
}
