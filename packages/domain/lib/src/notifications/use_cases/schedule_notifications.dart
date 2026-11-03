import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';
import 'package:buckets_domain/src/bills/ports/bill_repository.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';
import 'package:buckets_domain/src/ledger/policies/pay_cycle.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/ledger/use_cases/get_current_cycle.dart';
import 'package:buckets_domain/src/notifications/policies/notification_policy.dart';
import 'package:buckets_domain/src/notifications/ports/notification_scheduler.dart';
import 'package:buckets_domain/src/notifications/value_objects/notification_inputs.dart';
import 'package:buckets_domain/src/notifications/value_objects/scheduled_notification.dart';
import 'package:buckets_domain/src/payday/entities/transfer.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/planning/entities/wish.dart';
import 'package:buckets_domain/src/planning/ports/planning_repository.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/local_date.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';

/// Gathers the current state, asks `NotificationPolicy` for the schedule and
/// hands it to the scheduler (DOMAIN §12). Run on start, resume and after
/// anything that changes money, paydays, bills or wishes.
final class ScheduleNotifications {
  /// Creates the use case.
  const new({
    required this._scheduler,
    required this._paydays,
    required this._alerts,
    required this._bills,
    required this._planning,
    required this._settings,
    required this._ledger,
    required this._buckets,
    required this._cycle,
    required this._clock,
    required this._zone,
  });

  final NotificationScheduler _scheduler;
  final PaydayRepository _paydays;
  final AlertRepository _alerts;
  final BillRepository _bills;
  final PlanningRepository _planning;
  final SettingsRepository _settings;
  final LedgerRepository _ledger;
  final BucketRepository _buckets;
  final GetCurrentCycle _cycle;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// How far back unsorted alerts still count as new.
  static const freshAlerts = Duration(minutes: 10);

  /// The schedule that was handed to the scheduler. The adapter skips IDs
  /// it has already shown, which keeps N-LOW to once per cycle.
  Future<Result<List<ScheduledNotification>>> call() => attempt(() async {
    final now = _clock.now();
    final offset = _zone.offsetAt(now);
    final settings = unwrap(await _settings.get());
    final inputs = NotificationInputs(
      payday: await _payday(),
      alerts: await _freshAlerts(now),
      bills: unwrap(await _billDates(now, offset)),
      wishes: [
        for (final w in await _planning.watchWishes().first)
          if (w.status == WishStatus.coolingOff)
            WishEndInput(wishId: w.id, endsAt: w.endsAt),
      ],
      checkIn: settings.setupCompletedAt != null,
      low: unwrap(await _low()),
    );
    final plan = NotificationPolicy.plan(
      inputs,
      settings: settings,
      now: now,
      utcOffset: offset,
    );
    unwrap(await _scheduler.replaceAll(plan));
    return plan;
  });

  Future<PaydayAlarmInput?> _payday() async {
    final open = await _paydays.watchOpen().first;
    if (open == null) return null;
    final pending = open.transfers.where(
      (t) =>
          t.status == TransferStatus.pending ||
          (t.status == TransferStatus.partial &&
              (t.owedAmount?.isPositive ?? false)),
    );
    return PaydayAlarmInput(
      paydayId: open.id,
      pendingTransfers: pending.length,
      snoozedUntil: open.snoozedUntil,
    );
  }

  Future<List<AlertInput>> _freshAlerts(DateTime now) async => [
    for (final a in await _alerts.watchByStatus(AlertStatus.newAlert).first)
      if (a.receivedAt.isAfter(now.subtract(freshAlerts)))
        AlertInput(
          alertId: a.id,
          receivedAt: a.receivedAt,
          isIncome: a.parsed.direction == MessageDirection.incoming,
        ),
  ];

  Future<Result<List<BillDueInput>>> _billDates(
    DateTime now,
    Duration offset,
  ) => attempt(() async {
    final yesterday = LocalDate.ofInstant(now, offset).addDays(-1);
    return [
      for (final bill in unwrap(await _bills.getAll()))
        if (bill.frequency.isMonthly)
          BillDueInput(
            billId: bill.id,
            // The next due day from today, last day of short months.
            dueDate: PayCycle.nextPaydayAfter(
              MonthlyPay(bill.dueDay!),
              yesterday,
              utcOffset: offset,
            )!,
          )
        else
          BillDueInput(
            billId: bill.id,
            dueDate: LocalDate.ofInstant(bill.nextDueDate!, offset),
          ),
    ];
  });

  Future<Result<LowLivingInput?>> _low() => attempt(() async {
    final info = unwrap(await _cycle());
    final cycle = info.cycle;
    final living = unwrap(await _buckets.getAll())
        .where((b) => b.kind == BucketKind.living)
        .firstOrNull;
    if (cycle == null || living == null || !info.hadPayday) return null;
    final entries = unwrap(await _ledger.getEntries(bucketId: living.id));
    final allocation = entries
        .where(
          (e) =>
              e.kind == LedgerEntryKind.allocation &&
              e.refs.billId == null &&
              cycle.contains(e.occurredAt),
        )
        .fold(Money.zero, (s, e) => s + e.amount);
    return LowLivingInput(
      livingBucketId: living.id,
      left: BalanceCalculator.leftToSpend(entries, living.id),
      allocation: allocation,
      daysLeft: info.daysLeft!,
      cycleStart: cycle.start,
      alreadyNotified: false,
    );
  });
}
