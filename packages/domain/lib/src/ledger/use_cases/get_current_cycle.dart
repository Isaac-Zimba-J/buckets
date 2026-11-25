import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/ledger/policies/pay_cycle.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/settings/ports/settings_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/date_window.dart';
import 'package:buckets_domain/src/shared/local_date.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';
import 'package:equatable/equatable.dart';

/// The current pay cycle and the next expected salary payday.
final class CycleInfo with Equatable {
  /// Creates the info.
  const new({
    required this.cycle,
    required this.nextPayday,
    required this.daysLeft,
    required this.hadPayday,
    this.billsFrom,
  });

  /// The current cycle, or null without a regular salary (R-TIME-3).
  final DateWindow? cycle;

  /// The next expected salary payday, local.
  final LocalDate? nextPayday;

  /// Days left in the cycle, at least 1; null without a cycle.
  final int? daysLeft;

  /// Whether any salary payday has started yet (Home variants 07/08).
  final bool hadPayday;

  /// Start date for bill occurrences this cycle. After the first payday this
  /// equals the local cycle start. Before the first payday it may reach back
  /// to the previous payday so bills due before setup are included. Null when
  /// there is no cycle.
  final LocalDate? billsFrom;

  @override
  List<Object?> get props => [
    cycle,
    nextPayday,
    daysLeft,
    hadPayday,
    billsFrom,
  ];
}

/// Works out the current pay cycle (R-TIME-3); shared by Home, check-in
/// and notifications.
final class GetCurrentCycle {
  /// Creates the use case.
  const new(
    this._incomes,
    this._paydays,
    this._settings,
    this._clock,
    this._zone,
  );

  final IncomeRepository _incomes;
  final PaydayRepository _paydays;
  final SettingsRepository _settings;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// The cycle at now.
  Future<Result<CycleInfo>> call() => attempt(() async {
    final now = _clock.now();
    final offset = _zone.offsetAt(now);
    final salary = unwrap(await _incomes.getAll())
        .where((i) => i.kind == IncomeKind.salary)
        .firstOrNull;
    final lastSalary = salary == null
        ? null
        : unwrap(await _paydays.getAll())
              .where((p) => p.incomeSourceId == salary.id)
              .firstOrNull;
    final setupAt = unwrap(await _settings.get()).setupCompletedAt ?? now;
    final cycle = salary == null
        ? null
        : PayCycle.current(
            lastSalaryStartedAt: lastSalary?.startedAt,
            setupAt: setupAt,
            salary: salary.schedule,
            now: now,
            utcOffset: offset,
          );
    LocalDate? billsFrom;
    if (cycle != null && salary != null) {
      final localStart = LocalDate.ofInstant(cycle.start, offset);
      if (lastSalary != null) {
        billsFrom = localStart;
      } else {
        final cycleEnd = LocalDate.ofInstant(cycle.end, offset);
        final prev = PayCycle.previousPaydayBefore(
          salary.schedule,
          cycleEnd,
          utcOffset: offset,
        );
        billsFrom = (prev != null && prev.compareTo(localStart) < 0)
            ? prev
            : localStart;
      }
    }
    return CycleInfo(
      cycle: cycle,
      nextPayday: cycle == null ? null : LocalDate.ofInstant(cycle.end, offset),
      daysLeft: cycle == null
          ? null
          : PayCycle.daysLeft(cycle, now: now, utcOffset: offset),
      hadPayday: lastSalary != null,
      billsFrom: billsFrom,
    );
  });
}
