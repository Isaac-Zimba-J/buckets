import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/payday/entities/transfer.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:equatable/equatable.dart';

/// Whether a payday still has work to do (DOMAIN §7).
enum PaydayStatus {
  /// Transfers are still pending.
  open,

  /// Every transfer is done (R-PAY-3).
  complete,
}

/// One income arriving and being split (DOMAIN §7).
final class Payday with Equatable {
  const new _({
    required this.id,
    required this.incomeSourceId,
    required this.amount,
    required this.startedAt,
    required this.transfers,
    required this.snoozesUsed,
    required this.status,
    required this.snoozedUntil,
  });

  /// Validates and creates a payday.
  static Result<Payday> create({
    required String id,
    required String incomeSourceId,
    required Money amount,
    required DateTime startedAt,
    required List<Transfer> transfers,
    int snoozesUsed = 0,
    PaydayStatus status = PaydayStatus.open,
    DateTime? snoozedUntil,
  }) => validated(
    [
      requirePositive(amount),
      requireUtc(startedAt, 'startedAt'),
      requireUtc(snoozedUntil, 'snoozedUntil'),
      // Snooze limit setting is 0–3 (R-PAY-4).
      requireRange(snoozesUsed, 0, 3, 'snoozesUsed'),
    ],
    () => Payday._(
      id: id,
      incomeSourceId: incomeSourceId,
      amount: amount,
      startedAt: startedAt,
      transfers: List.unmodifiable(transfers),
      snoozesUsed: snoozesUsed,
      status: status,
      snoozedUntil: snoozedUntil,
    ),
  );

  /// A validated copy with the given fields replaced.
  Result<Payday> copyWith({
    List<Transfer>? transfers,
    int? snoozesUsed,
    PaydayStatus? status,
    DateTime? snoozedUntil,
  }) => Payday.create(
    id: id,
    incomeSourceId: incomeSourceId,
    amount: amount,
    startedAt: startedAt,
    transfers: transfers ?? this.transfers,
    snoozesUsed: snoozesUsed ?? this.snoozesUsed,
    status: status ?? this.status,
    snoozedUntil: snoozedUntil ?? this.snoozedUntil,
  );

  /// Unique ID.
  final String id;

  /// The income that arrived.
  final String incomeSourceId;

  /// The amount that arrived.
  final Money amount;

  /// When the payday was started, in UTC.
  final DateTime startedAt;

  /// Money to move to other accounts.
  final List<Transfer> transfers;

  /// Snoozes used so far.
  final int snoozesUsed;

  /// Open or complete.
  final PaydayStatus status;

  /// When the current snooze ends and the alarm resumes (R-PAY-4).
  final DateTime? snoozedUntil;

  @override
  List<Object?> get props => [
    id,
    incomeSourceId,
    amount,
    startedAt,
    transfers,
    snoozesUsed,
    status,
    snoozedUntil,
  ];
}
