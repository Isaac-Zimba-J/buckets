import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/setup/presentation/controllers/setup_view_models.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bills_controller.freezed.dart';
part 'bills_controller.g.dart';

/// Screen 03 Fixed bills.
@freezed
sealed class BillsState with _$BillsState {
  /// "No bills yet" + add.
  const factory BillsState.empty({String? errorCode}) = BillsEmpty;

  /// Bills with this cycle's reservations and their total (R-BILL-3).
  const factory BillsState.ready({
    required List<BillVm> bills,
    required Money total,
    String? errorCode,
  }) = BillsReady;
}

/// Screen 03 Fixed bills.
@riverpod
class BillsController extends _$BillsController {
  @override
  Future<BillsState> build() async {
    final (lines, total) = (await ref.watch(
      getBillReservationsProvider,
    )()).orThrow();
    return lines.isEmpty
        ? const BillsState.empty()
        : BillsState.ready(bills: lines.map(BillVm.of).toList(), total: total);
  }

  /// Adds or edits a bill; a validation failure keeps the list and sets
  /// `errorCode`.
  Future<bool> save({
    required String name,
    required Money amount,
    required BillFrequency frequency,
    int? dueDay,
    DateTime? nextDueDate,
    String? id,
  }) async {
    final result = await ref.read(saveBillProvider)(
      id: id,
      name: name,
      amount: amount,
      frequency: frequency,
      dueDay: dueDay,
      nextDueDate: nextDueDate,
    );
    return await _after(result);
  }

  /// Removes a bill.
  Future<bool> delete(String id) async =>
      await _after(await ref.read(deleteBillProvider)(id));

  Future<bool> _after(Result<Object?> result) async {
    final current = await future;
    switch (result) {
      case Ok():
        ref.invalidateSelf();
        await future;
        return true;
      case Err(:final failure):
        state = AsyncData(switch (current) {
          BillsEmpty() => BillsState.empty(errorCode: failure.code),
          BillsReady(:final bills, :final total) => BillsState.ready(
            bills: bills,
            total: total,
            errorCode: failure.code,
          ),
        });
        return false;
    }
  }
}
