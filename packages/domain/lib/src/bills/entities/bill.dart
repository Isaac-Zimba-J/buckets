import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// How often a bill is due, in months (DOMAIN §5).
final class BillFrequency with Equatable {
  const BillFrequency._(this.months);

  /// Every [n] months; validated by [Bill.create].
  const BillFrequency.everyNMonths(int n) : this._(n);

  /// Every month.
  static const monthly = BillFrequency._(1);

  /// Every 4 months (a school term).
  static const termly = BillFrequency._(4);

  /// Every 12 months.
  static const yearly = BillFrequency._(12);

  /// Months between due dates.
  final int months;

  /// Whether the bill is due every month.
  bool get isMonthly => months == 1;

  @override
  List<Object?> get props => [months];
}

/// A recurring bill (DOMAIN §5).
final class Bill with Equatable {
  const Bill._({
    required this.id,
    required this.name,
    required this.amount,
    required this.frequency,
    required this.dueDay,
    required this.nextDueDate,
    required this.paidFromBucketId,
    required this.payeeAccountHint,
  });

  /// Validates and creates a bill. Monthly bills need [dueDay]; others need
  /// [nextDueDate].
  static Result<Bill> create({
    required String id,
    required String name,
    required Money amount,
    required BillFrequency frequency,
    required String paidFromBucketId,
    int? dueDay,
    DateTime? nextDueDate,
    String? payeeAccountHint,
  }) => validated(
    [
      requireText(name),
      requirePositive(amount),
      requireRange(frequency.months, 1, 1200, 'frequency'),
      if (frequency.isMonthly)
        requireRange(dueDay ?? 0, 1, 31, 'dueDay')
      else if (nextDueDate == null)
        const ValidationFailure(
          'nextDueDate.missing',
          'Choose when the bill is next due.',
        ),
      requireUtc(nextDueDate, 'nextDueDate'),
    ],
    () => Bill._(
      id: id,
      name: name.trim(),
      amount: amount,
      frequency: frequency,
      dueDay: dueDay,
      nextDueDate: nextDueDate,
      paidFromBucketId: paidFromBucketId,
      payeeAccountHint: payeeAccountHint,
    ),
  );

  /// Unique ID.
  final String id;

  /// Display name.
  final String name;

  /// Amount due each time.
  final Money amount;

  /// How often it is due.
  final BillFrequency frequency;

  /// Day of the month for monthly bills.
  final int? dueDay;

  /// Next due date for non-monthly bills, in UTC.
  final DateTime? nextDueDate;

  /// The bucket that pays it (Living by default).
  final String paidFromBucketId;

  /// Optional hint to recognise the payee in alerts.
  final String? payeeAccountHint;

  @override
  List<Object?> get props => [
    id,
    name,
    amount,
    frequency,
    dueDay,
    nextDueDate,
    paidFromBucketId,
    payeeAccountHint,
  ];
}
