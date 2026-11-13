import 'package:buckets/bootstrap/bills_fees_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bill_history_controller.freezed.dart';
part 'bill_history_controller.g.dart';

/// Screen 35 Bill history.
@freezed
abstract class BillHistoryState with _$BillHistoryState {
  /// [occurrences] newest first; [isFirstCycle] when there is no history yet.
  const factory BillHistoryState({
    required String billName,
    required List<BillOccurrence> occurrences,
    required BillStats stats,
    required Money feesThisYear,
  }) = _BillHistoryState;

  const BillHistoryState._();

  /// The first-cycle state: nothing paid yet.
  bool get isFirstCycle => !occurrences.any((o) => o.status != BillStatus.due);
}

/// Screen 35 for [billId], live.
@riverpod
class BillHistoryController extends _$BillHistoryController {
  @override
  Stream<BillHistoryState> build(String billId) async* {
    final bill = (await ref.watch(billRepositoryProvider).getAll())
        .orThrow()
        .firstWhere((b) => b.id == billId);
    yield* ref.watch(watchBillHistoryProvider)(billId).asyncMap((list) async {
      final stats = (await ref.read(getBillStatsProvider)(billId)).orThrow();
      return BillHistoryState(
        billName: bill.name,
        occurrences: list,
        stats: stats,
        feesThisYear: (await ref.read(getBillFeesProvider)(billId)).orThrow(),
      );
    });
  }
}
