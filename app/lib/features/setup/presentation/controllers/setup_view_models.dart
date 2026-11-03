import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'setup_view_models.freezed.dart';

/// An income row (screen 02).
@freezed
abstract class IncomeVm with _$IncomeVm {
  /// Creates the row.
  const factory IncomeVm({
    required String id,
    required String name,
    required IncomeKind kind,
    required Money? expected,
    required int? paydayOfMonth,
  }) = _IncomeVm;

  /// The row for [source].
  factory IncomeVm.of(IncomeSource source) => IncomeVm(
    id: source.id,
    name: source.name,
    kind: source.kind,
    expected: source.expectedAmount,
    paydayOfMonth: switch (source.schedule) {
      MonthlyPay(:final dayOfMonth) => dayOfMonth,
      _ => null,
    },
  );
}

/// A bill row with this cycle's reservation (screen 03).
@freezed
abstract class BillVm with _$BillVm {
  /// Creates the row.
  const factory BillVm({
    required String id,
    required String name,
    required Money amount,
    required int everyMonths,
    required Money reservation,
    required Money putAside,
  }) = _BillVm;

  /// The row for [line].
  factory BillVm.of(BillReservationLine line) => BillVm(
    id: line.bill.id,
    name: line.bill.name,
    amount: line.bill.amount,
    everyMonths: line.bill.frequency.months,
    reservation: line.reservation.amount,
    putAside: line.putAside,
  );
}

/// A bucket's share in the split editor (screen 04).
@freezed
abstract class AllocationVm with _$AllocationVm {
  /// Creates the row.
  const factory AllocationVm({
    required String bucketId,
    required String name,
    required BucketColor color,
    required int basisPoints,
    required Money? share,
  }) = _AllocationVm;
}

/// A bucket and where its money lives (screen 05).
@freezed
abstract class BucketAccountVm with _$BucketAccountVm {
  /// Creates the row.
  const factory BucketAccountVm({
    required String bucketId,
    required String name,
    required BucketColor color,
    required String? accountId,
    required String? accountName,
    required bool warning,
  }) = _BucketAccountVm;

  /// The row for [row].
  factory BucketAccountVm.of(BucketWithAccount row) => BucketAccountVm(
    bucketId: row.bucket.id,
    name: row.bucket.name,
    color: row.bucket.color,
    accountId: row.account?.id,
    accountName: row.account?.name,
    warning: row.warning,
  );
}

/// An account choice (screen 05).
@freezed
abstract class AccountVm with _$AccountVm {
  /// Creates the row.
  const factory AccountVm({
    required String id,
    required String name,
    required AccountKind kind,
    required bool isSpending,
  }) = _AccountVm;

  /// The row for [account].
  factory AccountVm.of(Account account) => AccountVm(
    id: account.id,
    name: account.name,
    kind: account.kind,
    isSpending: account.isSpending,
  );
}
