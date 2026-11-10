import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_view_models.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payday_controller.freezed.dart';
part 'payday_controller.g.dart';

/// Screen 13 Payday transfers.
@freezed
abstract class PaydayState with _$PaydayState {
  /// The checklist. [complete] navigates to screen 16; [snoozesLeft] = 0
  /// disables the snooze button. [snoozeUntil] is when a snooze now would
  /// bring the alarm back (null from 21:00); [snoozedUntil] is the snooze
  /// in force, if any. Times are UTC.
  const factory PaydayState({
    required String paydayId,
    required List<TransferRowVm> transfers,
    required int done,
    required Money left,
    required bool complete,
    required bool snoozed,
    required int snoozesLeft,
    @Default(Money.zero) Money total,
    DateTime? startedAt,
    DateTime? snoozeUntil,
    DateTime? snoozedUntil,
    String? errorCode,
  }) = _PaydayState;
}

/// Screen 13 for [paydayId], live.
@riverpod
class PaydayController extends _$PaydayController {
  @override
  Stream<PaydayState> build(String paydayId) async* {
    final limit = (await ref.watch(settingsRepositoryProvider).get())
        .orThrow()
        .snoozeLimit;
    final buckets = {
      for (final b
          in (await ref.watch(bucketRepositoryProvider).getAll()).orThrow())
        b.id: b,
    };
    final accounts = {
      for (final a
          in (await ref.watch(accountRepositoryProvider).getAll()).orThrow())
        a.id: a.name,
    };
    final clock = ref.watch(clockProvider);
    final zone = ref.watch(localTimeZoneProvider);
    yield* ref.watch(watchPaydayProvider)(paydayId).map((p) {
      final now = clock.now();
      bool isDone(Transfer t) =>
          t.status == TransferStatus.proven ||
          t.status == TransferStatus.selfReported;
      return PaydayState(
        paydayId: p.id,
        transfers: [
          for (final t in p.transfers)
            TransferRowVm(
              id: t.id,
              bucketId: t.bucketId,
              bucketName: buckets[t.bucketId]?.name ?? '',
              color: buckets[t.bucketId]?.color ?? BucketColor.goal,
              amount: t.amount,
              status: t.status,
              owed: t.status == TransferStatus.partial ? t.owedAmount : null,
              destination: accounts[t.toAccountId] ?? '',
              provenAt: t.provenAt,
            ),
        ],
        done: p.transfers.where(isDone).length,
        left: p.transfers
            .where((t) => !isDone(t))
            .fold(Money.zero, (s, t) => s + (t.owedAmount ?? t.amount)),
        complete: p.status == PaydayStatus.complete,
        snoozed: p.snoozesUsed > 0,
        snoozesLeft: (limit - p.snoozesUsed).clamp(0, limit),
        total: p.transfers.fold(Money.zero, (s, t) => s + t.amount),
        startedAt: p.startedAt,
        snoozeUntil: PaydayPlanner.snoozeAlarmAt(
          now,
          utcOffset: zone.offsetAt(now),
        ),
        snoozedUntil: p.snoozedUntil,
      );
    });
  }

  /// Snoozes the alarm (R-PAY-4); failures (none left, after 21:00) are
  /// shown as `errorCode`.
  Future<bool> snooze() async {
    final result = await ref.read(snoozePaydayAlarmProvider)(paydayId);
    if (result case Err(:final failure)) {
      final current = state.value;
      if (current != null) {
        state = AsyncData(current.copyWith(errorCode: failure.code));
      }
      return false;
    }
    return true;
  }
}
