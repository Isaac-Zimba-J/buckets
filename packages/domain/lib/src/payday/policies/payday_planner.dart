import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/policies/bill_reservations.dart';
import 'package:buckets_domain/src/bills/value_objects/bill_reservation.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/value_objects/ledger_refs.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/payday/entities/transfer.dart';
import 'package:buckets_domain/src/payday/value_objects/started_payday.dart';
import 'package:buckets_domain/src/shared/local_date.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:buckets_domain/src/split/entities/split_profile.dart';
import 'package:buckets_domain/src/split/policies/split_calculator.dart';

/// The payday lifecycle (DOMAIN §7).
abstract final class PaydayPlanner {
  /// Starts a payday (R-PAY-1): splits what's left after [bills] (salary
  /// only, R-SPLIT-2), writes an allocation per share and per bill
  /// reservation (bill money sits in its paying bucket), and creates a
  /// transfer per bucket whose account isn't the landing account (R-PAY-2).
  static Result<StartedPayday> start({
    required IdGenerator ids,
    required IncomeSource income,
    required Money amount,
    required SplitProfile profile,
    required List<Bucket> buckets,
    required List<BillReservation> bills,
    required DateTime now,
  }) {
    final billsUsed = income.deductBillsFirst ? bills : <BillReservation>[];
    final toSplit = SplitCalculator.amountToSplit(
      income: amount,
      deductBillsFirst: income.deductBillsFirst,
      billReservations: BillReservations.total(billsUsed.map((b) => b.amount)),
    );
    if (toSplit case Err(:final failure)) return Err(failure);
    final byId = {for (final b in buckets) b.id: b};
    final living = buckets.where((b) => b.kind == BucketKind.living);
    final shares = SplitCalculator.split(
      (toSplit as Ok<Money>).value,
      profile,
      livingBucketId: living.firstOrNull?.id,
    );
    final allocations = [
      for (final s in shares) (s.bucketId, s.amount, null),
      for (final b in billsUsed)
        if (b.amount.isPositive) (b.bucketId, b.amount, b.billId),
    ];
    if (allocations.any((a) => !byId.containsKey(a.$1))) {
      return const Err(NotFoundFailure('bucket.notFound', 'A bucket is gone.'));
    }
    final paydayId = ids.newId();
    final entries = collect([
      for (final (bucketId, money, billId) in allocations)
        LedgerEntry.create(
          id: ids.newId(),
          occurredAt: now,
          kind: LedgerEntryKind.allocation,
          bucketId: bucketId,
          amount: money,
          refs: LedgerRefs(paydayId: paydayId, billId: billId),
        ),
    ]);
    return switch (entries) {
      Err(:final failure) => Err(failure),
      Ok(value: final list) => _withPayday(
        ids,
        income,
        amount,
        now,
        paydayId,
        list,
        byId,
      ),
    };
  }

  static Result<StartedPayday> _withPayday(
    IdGenerator ids,
    IncomeSource income,
    Money amount,
    DateTime now,
    String paydayId,
    List<LedgerEntry> entries,
    Map<String, Bucket> byId,
  ) {
    final perBucket = <String, Money>{};
    for (final e in entries) {
      if (byId[e.bucketId]!.accountId == income.landsInAccountId) continue;
      perBucket.update(
        e.bucketId,
        (m) => m + e.amount,
        ifAbsent: () => e.amount,
      );
    }
    final transfers = collect([
      for (final MapEntry(key: bucketId, value: money) in perBucket.entries)
        if (money.isPositive)
          Transfer.create(
            id: ids.newId(),
            bucketId: bucketId,
            toAccountId: byId[bucketId]!.accountId,
            amount: money,
          ),
    ]);
    if (transfers case Err(:final failure)) return Err(failure);
    final payday = Payday.create(
      id: paydayId,
      incomeSourceId: income.id,
      amount: amount,
      startedAt: now,
      transfers: (transfers as Ok<List<Transfer>>).value,
    );
    return switch (payday) {
      Ok(:final value) => Ok(StartedPayday(value, entries)),
      Err(:final failure) => Err(failure),
    };
  }

  /// Whether every transfer is done: proven, self-reported, or partial with
  /// nothing owed (R-PAY-3).
  static bool isComplete(Payday payday) => payday.transfers.every(
    (t) => switch (t.status) {
      TransferStatus.proven || TransferStatus.selfReported => true,
      TransferStatus.partial => !(t.owedAmount?.isPositive ?? false),
      TransferStatus.pending => false,
    },
  );

  /// [payday] with its status set from [isComplete].
  static Payday refreshStatus(Payday payday) => switch (payday.copyWith(
    status: isComplete(payday) ? PaydayStatus.complete : PaydayStatus.open,
  )) {
    Ok(:final value) => value,
    Err() => payday,
  };

  /// Uses a snooze (R-PAY-4) and returns the payday and the next alarm
  /// time: 20:00 local today, or 2 hours from now from 18:00. Not allowed
  /// from 21:00, past [snoozeLimit], or once the payday is complete.
  static Result<(Payday, DateTime)> snooze(
    Payday payday, {
    required DateTime now,
    required Duration utcOffset,
    required int snoozeLimit,
  }) {
    if (payday.status == PaydayStatus.complete) {
      return const Err(
        ValidationFailure('snooze.notNeeded', 'This payday is done.'),
      );
    }
    if (payday.snoozesUsed >= snoozeLimit) {
      return const Err(
        ValidationFailure('snooze.noneLeft', 'No snoozes left this payday.'),
      );
    }
    final wall = now.add(utcOffset);
    final minutes = wall.hour * 60 + wall.minute;
    if (minutes >= 21 * 60) {
      return const Err(
        ValidationFailure(
          'snooze.tooLate',
          "It's after 21:00. The alarm comes back at 07:00.",
        ),
      );
    }
    final alarmAt = minutes >= 18 * 60
        ? now.add(const Duration(hours: 2))
        : LocalDate.ofInstant(
            now,
            utcOffset,
          ).startUtc(utcOffset).add(const Duration(hours: 20));
    return switch (payday.copyWith(snoozesUsed: payday.snoozesUsed + 1)) {
      Ok(:final value) => Ok((value, alarmAt)),
      Err(:final failure) => Err(failure),
    };
  }

  /// Whether Living and Guilt-free show as unlocked: no open payday, or
  /// it is complete, or a snooze was used (R-PAY-5). Display only.
  static bool isUnlocked(Payday? payday) =>
      payday == null ||
      payday.status == PaydayStatus.complete ||
      isComplete(payday) ||
      payday.snoozesUsed > 0;

  /// When held side-hustle money is split: the last day of the local
  /// calendar month at 18:00, or next month's if that has passed (R-PAY-6).
  static DateTime holdReleaseAt(DateTime now, {required Duration utcOffset}) {
    DateTime releaseIn(int year, int month) => LocalDate(
      year,
      month,
      LocalDate.daysInMonth(year, month),
    ).startUtc(utcOffset).add(const Duration(hours: 18));
    final today = LocalDate.ofInstant(now, utcOffset);
    final thisMonth = releaseIn(today.year, today.month);
    if (now.isBefore(thisMonth)) return thisMonth;
    final next = DateTime.utc(today.year, today.month + 1);
    return releaseIn(next.year, next.month);
  }
}
