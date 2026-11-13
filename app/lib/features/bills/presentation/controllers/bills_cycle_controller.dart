import 'package:buckets/bootstrap/bills_fees_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bills_cycle_controller.freezed.dart';
part 'bills_cycle_controller.g.dart';

/// Screen 33 Plan · Bills this cycle.
@freezed
abstract class BillsCycleState with _$BillsCycleState {
  /// [view] is null before the first cycle; [feesTotal] feeds the link card.
  const factory BillsCycleState({
    required BillsCycleView? view,
    required Money feesTotal,
  }) = _BillsCycleState;

  const BillsCycleState._();

  /// No bills at all: the empty state that leads to adding one.
  bool get isEmpty =>
      view == null || (view!.rows.isEmpty && view!.savingUp.isEmpty);

  /// Every occurrence this cycle is paid and nothing is overdue.
  bool get allPaid =>
      view != null &&
      view!.totalCount > 0 &&
      view!.paidCount == view!.totalCount &&
      !view!.rows.any((r) => r.isOverdue);
}

/// Screen 33, live. Creates this cycle's occurrences on open (idempotent,
/// R-BILL-6) so the list is never behind payday.
@riverpod
class BillsCycleController extends _$BillsCycleController {
  @override
  Stream<BillsCycleState> build() async* {
    (await ref.watch(ensureBillOccurrencesProvider)()).orThrow();
    final fees = ref.watch(watchFeesSummaryProvider)();
    var total = Money.zero;
    final feeSub = fees.listen((f) => total = f?.total ?? Money.zero);
    ref.onDispose(feeSub.cancel);
    yield* ref
        .watch(watchBillsCycleProvider)()
        .map((v) => BillsCycleState(view: v, feesTotal: total));
  }
}
