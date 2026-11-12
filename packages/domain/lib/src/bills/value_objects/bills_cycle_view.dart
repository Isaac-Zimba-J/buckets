import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/entities/bill.dart';
import 'package:buckets_domain/src/bills/entities/bill_occurrence.dart';
import 'package:buckets_domain/src/shared/local_date.dart';
import 'package:equatable/equatable.dart';

/// One bill on screen 33's "Due this cycle" list.
final class BillCycleRow with Equatable {
  /// Creates a row.
  const new({
    required this.occurrence,
    required this.bill,
    required this.isOverdue,
    this.fee,
  });

  /// The occurrence.
  final BillOccurrence occurrence;

  /// Its bill.
  final Bill bill;

  /// Still unpaid after its due date (R-BILL-8).
  final bool isOverdue;

  /// The fee recorded when it was paid, if any.
  final Money? fee;

  @override
  List<Object?> get props => [occurrence, bill, isOverdue, fee];
}

/// A non-monthly bill with no occurrence this cycle: money being saved up.
final class SavingUpRow with Equatable {
  /// Creates a row.
  const new({
    required this.bill,
    required this.putAside,
    required this.reservation,
  });

  /// The bill.
  final Bill bill;

  /// Put aside so far.
  final Money putAside;

  /// What is set aside this cycle.
  final Money reservation;

  @override
  List<Object?> get props => [bill, putAside, reservation];
}

/// Everything screen 33 shows for the current pay cycle.
final class BillsCycleView with Equatable {
  /// Creates the view.
  const new({
    required this.start,
    required this.end,
    required this.setAside,
    required this.toPay,
    required this.paidTotal,
    required this.paidCount,
    required this.totalCount,
    required this.rows,
    required this.savingUp,
  });

  /// First day of the cycle.
  final LocalDate start;

  /// Day after the cycle's last day.
  final LocalDate end;

  /// This cycle's reservations for every bill (e.g. K 4,300).
  final Money setAside;

  /// Still to pay: expected amount of every unpaid row.
  final Money toPay;

  /// Paid so far this cycle.
  final Money paidTotal;

  /// How many of this cycle's occurrences are paid.
  final int paidCount;

  /// How many occurrences this cycle has (skipped ones excluded).
  final int totalCount;

  /// This cycle's occurrences plus overdue ones from earlier cycles.
  final List<BillCycleRow> rows;

  /// Non-monthly bills being saved for.
  final List<SavingUpRow> savingUp;

  /// Money being saved up this cycle across [savingUp].
  Money get savingUpTotal =>
      savingUp.fold(Money.zero, (sum, r) => sum + r.reservation);

  @override
  List<Object?> get props => [
    start,
    end,
    setAside,
    toPay,
    paidTotal,
    paidCount,
    totalCount,
    rows,
    savingUp,
  ];
}
