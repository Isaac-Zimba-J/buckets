import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/entities/bill.dart';
import 'package:buckets_domain/src/bills/entities/bill_occurrence.dart';
import 'package:buckets_domain/src/bills/policies/bill_occurrences.dart';
import 'package:buckets_domain/src/bills/ports/bill_occurrence_repository.dart';
import 'package:buckets_domain/src/bills/use_cases/get_bill_reservations.dart';
import 'package:buckets_domain/src/bills/value_objects/bills_cycle_view.dart';
import 'package:buckets_domain/src/ledger/use_cases/get_current_cycle.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/local_date.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';

/// What Plan > Bills shows for the current cycle (SCREENS 33).
final class GetBillsCycle {
  /// Creates the use case.
  const new(
    this._occurrences,
    this._reservations,
    this._cycle,
    this._transactions,
    this._clock,
    this._zone,
  );

  final BillOccurrenceRepository _occurrences;
  final GetBillReservations _reservations;
  final GetCurrentCycle _cycle;
  final TransactionRepository _transactions;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// The view, or null before the first cycle exists.
  Future<Result<BillsCycleView?>> call() => attempt(() async {
    final window = unwrap(await _cycle()).cycle;
    if (window == null) return null;
    final now = _clock.now();
    final offset = _zone.offsetAt(now);
    final today = LocalDate.ofInstant(now, offset);
    final start = LocalDate.ofInstant(window.start, offset);
    final all = unwrap(await _occurrences.getAll());
    final (lines, setAside) = unwrap(await _reservations());
    final bills = {for (final l in lines) l.bill.id: l.bill};

    final thisCycle = all.where((o) => o.cycleStart == start).toList();
    final overdue = all.where(
      (o) => o.cycleStart != start && BillOccurrences.isOverdue(o, today),
    );
    final shown = [...overdue, ...thisCycle]
      ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    final rows = <BillCycleRow>[
      for (final o in shown)
        if (bills[o.billId] case final Bill bill)
          BillCycleRow(
            occurrence: o,
            bill: bill,
            isOverdue: BillOccurrences.isOverdue(o, today),
            fee: await _feeOf(o),
          ),
    ];
    final counted = thisCycle.where((o) => o.status != BillStatus.skipped);
    final paid = counted.where((o) => o.status == BillStatus.paid);
    final dueNow = {for (final o in thisCycle) o.billId};
    return BillsCycleView(
      start: start,
      end: LocalDate.ofInstant(window.end, offset),
      setAside: setAside,
      toPay: rows
          .where((r) => r.occurrence.status == BillStatus.due)
          .fold(Money.zero, (s, r) => s + r.occurrence.expectedAmount),
      paidTotal: paid.fold(Money.zero, (s, o) => s + o.paidAmount!),
      paidCount: paid.length,
      totalCount: counted.length,
      rows: rows,
      savingUp: [
        for (final l in lines)
          if (!l.bill.frequency.isMonthly && !dueNow.contains(l.bill.id))
            SavingUpRow(
              bill: l.bill,
              putAside: l.putAside,
              reservation: l.reservation.amount,
            ),
      ],
    );
  });

  Future<Money?> _feeOf(BillOccurrence o) async {
    final id = o.feeTransactionId;
    if (id == null) return null;
    return switch (await _transactions.get(id)) {
      Ok(:final value) => value.amount,
      Err() => null,
    };
  }
}
