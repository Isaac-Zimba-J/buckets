import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/entities/bill.dart';
import 'package:buckets_domain/src/bills/entities/bill_occurrence.dart';
import 'package:buckets_domain/src/bills/value_objects/bill_stats.dart';
import 'package:buckets_domain/src/shared/local_date.dart';

/// Bill occurrence rules (DOMAIN R-BILL-6, R-BILL-8…10). Pure: cycles are
/// given as `[start, end)` in local dates.
abstract final class BillOccurrences {
  /// When [bill] falls due in `[start, end)`, or null. A monthly bill is due
  /// on its `dueDay` (clamped to short months); any other bill only in the
  /// cycle holding its `nextDueDate`.
  static LocalDate? dueIn(
    Bill bill,
    LocalDate start,
    LocalDate end, {
    required Duration utcOffset,
  }) {
    bool inCycle(LocalDate d) =>
        d.compareTo(start) >= 0 && d.compareTo(end) < 0;
    if (bill.frequency.isMonthly) {
      final day = bill.dueDay ?? 1;
      var month = DateTime.utc(start.year, start.month);
      while (LocalDate(month.year, month.month, 1).compareTo(end) < 0) {
        final due = LocalDate(
          month.year,
          month.month,
          day.clamp(1, LocalDate.daysInMonth(month.year, month.month)),
        );
        if (inCycle(due)) return due;
        month = DateTime.utc(month.year, month.month + 1);
      }
      return null;
    }
    final next = bill.nextDueDate;
    if (next == null) return null;
    final due = LocalDate.ofInstant(next, utcOffset);
    return inCycle(due) ? due : null;
  }

  /// The occurrences to add for the cycle `[start, end)`: one fresh, unpaid
  /// occurrence for every bill due in it that has none yet. Safe to call on
  /// every start, so it never duplicates.
  static List<BillOccurrence> forCycle({
    required List<Bill> bills,
    required List<BillOccurrence> existing,
    required LocalDate start,
    required LocalDate end,
    required IdGenerator ids,
    required Duration utcOffset,
  }) => [
    for (final bill in bills)
      if (!existing.any((o) => o.billId == bill.id && o.cycleStart == start))
        if (dueIn(bill, start, end, utcOffset: utcOffset) case final due?)
          if (BillOccurrence.create(
                id: ids.newId(),
                billId: bill.id,
                cycleStart: start,
                dueDate: due,
                expectedAmount: bill.amount,
              )
              case Ok(:final value))
            value,
  ];

  /// A non-monthly bill's `nextDueDate` once it has been paid: the same day
  /// [BillFrequency.months] later, clamped to short months. Null for monthly
  /// bills, which follow their `dueDay`.
  static DateTime? advanceDue(Bill bill) {
    final due = bill.nextDueDate;
    if (due == null || bill.frequency.isMonthly) return null;
    final month = DateTime.utc(due.year, due.month + bill.frequency.months);
    final day = due.day.clamp(
      1,
      LocalDate.daysInMonth(month.year, month.month),
    );
    return DateTime.utc(month.year, month.month, day, due.hour, due.minute);
  }

  /// Still `due` after its due date (R-BILL-8).
  static bool isOverdue(BillOccurrence o, LocalDate today) =>
      o.status == BillStatus.due && today.compareTo(o.dueDate) > 0;

  /// Paid after its due date (R-BILL-8).
  static bool isLate(BillOccurrence o, {required Duration utcOffset}) {
    final at = o.paidAt;
    return o.status == BillStatus.paid &&
        at != null &&
        LocalDate.ofInstant(at, utcOffset).compareTo(o.dueDate) > 0;
  }

  /// The unpaid occurrence a payment to [counterparty] of [amount] probably
  /// settles (R-BILL-9): the bill's payee hint appears in the counterparty
  /// and the amount is within ±25% of what is expected. Only a suggestion.
  static BillOccurrence? suggest({
    required String counterparty,
    required Money amount,
    required List<Bill> bills,
    required List<BillOccurrence> occurrences,
  }) {
    final who = counterparty.toLowerCase();
    for (final o in occurrences) {
      if (o.status != BillStatus.due) continue;
      final hint = bills
          .where((b) => b.id == o.billId)
          .map((b) => b.payeeAccountHint?.trim().toLowerCase())
          .firstOrNull;
      if (hint == null || hint.isEmpty || !who.contains(hint)) continue;
      final gap = (amount.ngwee - o.expectedAmount.ngwee).abs();
      if (gap * 4 <= o.expectedAmount.ngwee) return o;
    }
    return null;
  }

  /// Average of the last 6 paid amounts and on-time count of the last 5
  /// paid (R-BILL-10).
  static BillStats stats(
    List<BillOccurrence> occurrences, {
    required Duration utcOffset,
  }) {
    final paid = [
      for (final o in occurrences)
        if (o.status == BillStatus.paid) o,
    ]..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    final six = paid.reversed.take(6).toList();
    final five = paid.reversed.take(5).toList();
    return BillStats(
      averagePaid: six.isEmpty
          ? null
          : Money(six.fold(0, (s, o) => s + o.paidAmount!.ngwee) ~/ six.length),
      onTimeOfLastFive: five
          .where((o) => !isLate(o, utcOffset: utcOffset))
          .length,
      lastFiveCount: five.length,
    );
  }
}
