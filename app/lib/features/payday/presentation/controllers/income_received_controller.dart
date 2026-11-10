import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/setup/presentation/controllers/setup_view_models.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'income_received_controller.freezed.dart';
part 'income_received_controller.g.dart';

/// Screen 17 Side hustle received.
@freezed
sealed class IncomeReceivedState with _$IncomeReceivedState {
  /// The incoming money with the R-PARSE-5 suggestion and the side hustles
  /// it could belong to.
  const factory IncomeReceivedState.ready({
    required Money? amount,
    required String? from,
    required IncomeSuggestion suggestion,
    required List<IncomeVm> sideHustles,
    String? salaryId,
    AlertSource? source,
    DateTime? receivedAt,
    String? errorCode,
  }) = IncomeReady;

  /// Held until month end; split at [releaseAt] (R-PAY-6).
  const factory IncomeReceivedState.holding({required DateTime releaseAt}) =
      IncomeHolding;

  /// Split now; go to the payday it started.
  const factory IncomeReceivedState.split({required String paydayId}) =
      IncomeSplit;

  /// "Not a hustle": dismissed.
  const factory IncomeReceivedState.dismissed() = IncomeDismissed;
}

/// Screen 17 for the incoming alert [alertId].
@riverpod
class IncomeReceivedController extends _$IncomeReceivedController {
  final Map<String, IncomeSource> _incomes = {};
  final Map<String, SplitProfile> _profiles = {};
  final Map<String, Bucket> _buckets = {};
  Money _bills = Money.zero;

  @override
  Future<IncomeReceivedState> build(String alertId) async {
    final alert = (await ref.watch(alertRepositoryProvider).get(alertId))
        .orThrow();
    await _loadSplits();
    final suggestion = (await ref.watch(classifyIncomingAlertProvider)(alertId))
        .orThrow();
    final incomes = (await ref.watch(incomeRepositoryProvider).getAll())
        .orThrow();
    return IncomeReceivedState.ready(
      amount: alert.parsed.amount,
      from: alert.parsed.counterparty,
      suggestion: suggestion,
      sideHustles: [
        for (final i in incomes)
          if (i.kind == IncomeKind.sideHustle) IncomeVm.of(i),
      ],
      salaryId: incomes
          .where((i) => i.kind == IncomeKind.salary)
          .firstOrNull
          ?.id,
      source: alert.source,
      receivedAt: alert.receivedAt,
    );
  }

  Future<void> _loadSplits() async {
    for (final i
        in (await ref.read(incomeRepositoryProvider).getAll()).orThrow()) {
      _incomes[i.id] = i;
      _profiles[i.id] =
          (await ref.read(splitProfileRepositoryProvider).get(i.splitProfileId))
              .orThrow();
    }
    for (final b
        in (await ref.read(bucketRepositoryProvider).getAll()).orThrow()) {
      _buckets[b.id] = b;
    }
    _bills = (await ref.read(getBillReservationsProvider)()).orThrow().$2;
  }

  /// [amount] split by [incomeSourceId]'s profile (R-SPLIT-5), for the rows
  /// under the choice; empty when that income or its split is unknown.
  List<AllocationVm> sharesFor(String incomeSourceId, Money amount) {
    final income = _incomes[incomeSourceId];
    final profile = _profiles[incomeSourceId];
    if (income == null || profile == null) return const [];
    final preview = ref.read(previewSplitProvider)(
      income: amount,
      deductBillsFirst: income.deductBillsFirst,
      billReservations: _bills,
      allocations: profile.allocations,
      livingBucketId: _buckets.values
          .where((b) => b.kind == BucketKind.living)
          .firstOrNull
          ?.id,
    );
    final byBucket = {for (final s in preview.shares) s.bucketId: s.amount};
    return [
      for (final a in profile.allocations)
        AllocationVm(
          bucketId: a.bucketId,
          name: _buckets[a.bucketId]?.name ?? '',
          color: _buckets[a.bucketId]?.color ?? BucketColor.goal,
          basisPoints: a.bp.value,
          share: byBucket[a.bucketId],
        ),
    ];
  }

  Future<void> _fail(Failure failure) async {
    final current = await future;
    if (current is IncomeReady) {
      state = AsyncData(current.copyWith(errorCode: failure.code));
    }
  }

  /// "Split it now" with [incomeSourceId]'s split; [amount] corrects a
  /// missing or wrong amount.
  Future<bool> splitNow(String incomeSourceId, {Money? amount}) async {
    final result = await ref.read(splitSideHustleIncomeProvider)(
      alertId: alertId,
      incomeSourceId: incomeSourceId,
      amount: amount,
    );
    switch (result) {
      case Ok(:final value):
        state = AsyncData(IncomeReceivedState.split(paydayId: value.id));
        return true;
      case Err(:final failure):
        await _fail(failure);
        return false;
    }
  }

  /// "Salary landed": a confirmed salary alert starts the salary payday
  /// (DOMAIN §5 (a)); false when no salary is set up.
  Future<bool> salaryLanded({Money? amount}) async {
    final current = await future;
    final salaryId = current is IncomeReady ? current.salaryId : null;
    if (salaryId == null) return false;
    return await splitNow(salaryId, amount: amount);
  }

  /// "Hold until month end".
  Future<bool> hold(String incomeSourceId, {Money? amount}) async {
    final result = await ref.read(holdSideHustleIncomeProvider)(
      alertId: alertId,
      incomeSourceId: incomeSourceId,
      amount: amount,
    );
    switch (result) {
      case Ok(value: (_, final releaseAt)):
        state = AsyncData(IncomeReceivedState.holding(releaseAt: releaseAt));
        return true;
      case Err(:final failure):
        await _fail(failure);
        return false;
    }
  }

  /// "Not a hustle".
  Future<bool> dismiss() async {
    final result = await ref.read(ignoreAlertProvider)(alertId);
    if (result is Ok) state = const AsyncData(IncomeReceivedState.dismissed());
    return result is Ok;
  }
}
