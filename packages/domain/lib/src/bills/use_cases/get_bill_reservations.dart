import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/entities/bill.dart';
import 'package:buckets_domain/src/bills/policies/bill_reservations.dart';
import 'package:buckets_domain/src/bills/ports/bill_repository.dart';
import 'package:buckets_domain/src/bills/value_objects/bill_reservation.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';
import 'package:buckets_domain/src/ledger/policies/pay_cycle.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/local_date.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';
import 'package:equatable/equatable.dart';

/// One bill's reservation this cycle and what is put aside so far.
final class BillReservationLine with Equatable {
  /// Creates a line.
  const BillReservationLine(this.bill, this.reservation, this.putAside);

  /// The bill.
  final Bill bill;

  /// This cycle's reservation (R-BILL-1).
  final BillReservation reservation;

  /// Money put aside and not yet paid (R-BILL-2).
  final Money putAside;

  @override
  List<Object?> get props => [bill, reservation, putAside];
}

/// This cycle's bill reservations and their total (R-BILL-1…3, screen 03).
final class GetBillReservations {
  /// Creates the use case.
  const GetBillReservations(
    this._bills,
    this._ledger,
    this._incomes,
    this._clock,
    this._zone,
  );

  final BillRepository _bills;
  final LedgerRepository _ledger;
  final IncomeRepository _incomes;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// The lines and their total (R-BILL-3).
  Future<Result<(List<BillReservationLine>, Money)>> call() =>
      attempt(() async {
        final now = _clock.now();
        final offset = _zone.offsetAt(now);
        final today = LocalDate.ofInstant(now, offset);
        final salary = unwrap(
          await _incomes.getAll(),
        ).where((i) => i.kind == IncomeKind.salary).firstOrNull;
        final entries = unwrap(await _ledger.getEntries());
        final lines = [
          for (final bill in unwrap(await _bills.getAll()))
            _line(bill, entries, salary, today, offset),
        ];
        return (
          lines,
          BillReservations.total(lines.map((l) => l.reservation.amount)),
        );
      });

  static BillReservationLine _line(
    Bill bill,
    List<LedgerEntry> entries,
    IncomeSource? salary,
    LocalDate today,
    Duration offset,
  ) {
    final putAside = BalanceCalculator.putAsideForBill(entries, bill.id);
    final due = bill.nextDueDate;
    final cycles = due == null || salary == null
        ? 1
        : PayCycle.paydaysBetween(
            salary.schedule,
            today,
            LocalDate.ofInstant(due, offset),
            utcOffset: offset,
          );
    final amount = BillReservations.monthly(
      bill,
      putAside: putAside,
      cyclesUntilDue: cycles,
    );
    return BillReservationLine(
      bill,
      BillReservation(
        billId: bill.id,
        bucketId: bill.paidFromBucketId,
        amount: amount,
      ),
      putAside,
    );
  }
}
