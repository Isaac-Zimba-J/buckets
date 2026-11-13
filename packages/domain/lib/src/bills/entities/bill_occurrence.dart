import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/local_date.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// Where a [BillOccurrence] stands (R-BILL-6).
enum BillStatus {
  /// Not paid yet; past its due date this is "overdue" (R-BILL-8).
  due,

  /// Paid.
  paid,

  /// The user chose not to pay this one.
  skipped,
}

/// One bill falling due in one pay cycle (DOMAIN R-BILL-6). A fresh,
/// unticked occurrence is created for every bill due in each cycle.
final class BillOccurrence with Equatable {
  const new _({
    required this.id,
    required this.billId,
    required this.cycleStart,
    required this.dueDate,
    required this.expectedAmount,
    required this.status,
    required this.paidAmount,
    required this.paidAt,
    required this.accountId,
    required this.feeTransactionId,
    required this.proofRef,
  });

  /// Validates and creates an occurrence. Only a `paid` occurrence has a
  /// [paidAmount] and [paidAt].
  static Result<BillOccurrence> create({
    required String id,
    required String billId,
    required LocalDate cycleStart,
    required LocalDate dueDate,
    required Money expectedAmount,
    BillStatus status = BillStatus.due,
    Money? paidAmount,
    DateTime? paidAt,
    String? accountId,
    String? feeTransactionId,
    String? proofRef,
  }) {
    final paid = status == BillStatus.paid;
    return validated(
      [
        requireText(id, 'id'),
        requireText(billId, 'billId'),
        requirePositive(expectedAmount, 'expectedAmount'),
        requireUtc(paidAt, 'paidAt'),
        if (dueDate.compareTo(cycleStart) < 0)
          const ValidationFailure(
            'dueDate.beforeCycle',
            'The due date is before the cycle starts.',
          ),
        if (paid && (paidAmount == null || !paidAmount.isPositive))
          const ValidationFailure(
            'paidAmount.required',
            'A paid bill needs the amount paid.',
          ),
        if (paid && paidAt == null)
          const ValidationFailure(
            'paidAt.required',
            'A paid bill needs the time it was paid.',
          ),
        if (!paid && (paidAmount != null || paidAt != null))
          const ValidationFailure(
            'paid.notPaid',
            'Only a paid bill has a paid amount or time.',
          ),
      ],
      () => BillOccurrence._(
        id: id.trim(),
        billId: billId.trim(),
        cycleStart: cycleStart,
        dueDate: dueDate,
        expectedAmount: expectedAmount,
        status: status,
        paidAmount: paidAmount,
        paidAt: paidAt,
        accountId: accountId,
        feeTransactionId: feeTransactionId,
        proofRef: proofRef,
      ),
    );
  }

  /// Unique ID.
  final String id;

  /// The bill this is an occurrence of.
  final String billId;

  /// First day of the pay cycle it belongs to.
  final LocalDate cycleStart;

  /// When it is due.
  final LocalDate dueDate;

  /// What the bill normally costs.
  final Money expectedAmount;

  /// Due, paid or skipped.
  final BillStatus status;

  /// What was actually paid; null unless paid.
  final Money? paidAmount;

  /// When it was paid, in UTC; null unless paid.
  final DateTime? paidAt;

  /// The account it was paid from, if known.
  final String? accountId;

  /// The fee transaction recorded with the payment (R-BILL-7).
  final String? feeTransactionId;

  /// Reference from the payment message, if one was pasted.
  final String? proofRef;

  @override
  List<Object?> get props => [
    id,
    billId,
    cycleStart,
    dueDate,
    expectedAmount,
    status,
    paidAmount,
    paidAt,
    accountId,
    feeTransactionId,
    proofRef,
  ];
}
