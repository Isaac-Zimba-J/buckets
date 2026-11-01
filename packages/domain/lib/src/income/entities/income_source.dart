import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// Where income comes from.
enum IncomeKind {
  /// A regular salary.
  salary,

  /// A side hustle.
  sideHustle,

  /// Anything else.
  other,
}

/// When an income source pays (DOMAIN §4 `frequency` + `payday`).
sealed class PaySchedule with Equatable {
  const PaySchedule();
}

/// Pays once a month on [dayOfMonth].
final class MonthlyPay extends PaySchedule {
  /// Creates a monthly schedule; validated by [IncomeSource.create].
  const MonthlyPay(this.dayOfMonth);

  /// Day of the month, 1–31.
  final int dayOfMonth;

  @override
  List<Object?> get props => [dayOfMonth];
}

/// Pays every two weeks counting from [anchor].
final class FortnightlyPay extends PaySchedule {
  /// Creates a fortnightly schedule; validated by [IncomeSource.create].
  const FortnightlyPay(this.anchor);

  /// A known payday, in UTC.
  final DateTime anchor;

  @override
  List<Object?> get props => [anchor];
}

/// Pays at no fixed time.
final class IrregularPay extends PaySchedule {
  /// Creates an irregular schedule.
  const IrregularPay();

  @override
  List<Object?> get props => const [];
}

/// A source of income (DOMAIN §4).
final class IncomeSource with Equatable {
  const IncomeSource._({
    required this.id,
    required this.name,
    required this.kind,
    required this.expectedAmount,
    required this.schedule,
    required this.landsInAccountId,
    required this.splitProfileId,
    required this.deductBillsFirst,
  });

  /// Validates and creates an income source. [deductBillsFirst] defaults to
  /// true for salary and false otherwise.
  static Result<IncomeSource> create({
    required String id,
    required String name,
    required IncomeKind kind,
    required PaySchedule schedule,
    required String landsInAccountId,
    required String splitProfileId,
    Money? expectedAmount,
    bool? deductBillsFirst,
  }) => validated(
    [
      requireText(name),
      requirePositive(expectedAmount, 'expectedAmount'),
      if (schedule case MonthlyPay(:final dayOfMonth))
        requireRange(dayOfMonth, 1, 31, 'payday'),
      if (schedule case FortnightlyPay(:final anchor))
        requireUtc(anchor, 'payday'),
    ],
    () => IncomeSource._(
      id: id,
      name: name.trim(),
      kind: kind,
      expectedAmount: expectedAmount,
      schedule: schedule,
      landsInAccountId: landsInAccountId,
      splitProfileId: splitProfileId,
      deductBillsFirst: deductBillsFirst ?? kind == IncomeKind.salary,
    ),
  );

  /// Unique ID.
  final String id;

  /// Display name.
  final String name;

  /// Salary, side hustle or other.
  final IncomeKind kind;

  /// The usual amount; null when irregular.
  final Money? expectedAmount;

  /// When it pays.
  final PaySchedule schedule;

  /// The account the money lands in.
  final String landsInAccountId;

  /// The split profile applied on payday.
  final String splitProfileId;

  /// Whether bill reservations come off before splitting (R-SPLIT-2).
  final bool deductBillsFirst;

  @override
  List<Object?> get props => [
    id,
    name,
    kind,
    expectedAmount,
    schedule,
    landsInAccountId,
    splitProfileId,
    deductBillsFirst,
  ];
}
