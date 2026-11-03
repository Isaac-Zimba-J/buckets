import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/setup/presentation/controllers/setup_view_models.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'income_setup_controller.freezed.dart';
part 'income_setup_controller.g.dart';

/// Screen 02 Income.
@freezed
abstract class IncomeSetupState with _$IncomeSetupState {
  /// [errorCode] is the validation failure of the last save (amount ≤ 0,
  /// payday out of range); the form keeps its input.
  const factory IncomeSetupState({
    required List<IncomeVm> incomes,
    @Default(false) bool saving,
    String? errorCode,
  }) = _IncomeSetupState;
}

/// Screen 02 Income: list and add income sources.
@riverpod
class IncomeSetupController extends _$IncomeSetupController {
  @override
  Future<IncomeSetupState> build() async => IncomeSetupState(
    incomes: [
      for (final i in (await ref.watch(listIncomeSourcesProvider)()).orThrow())
        IncomeVm.of(i),
    ],
  );

  /// Saves an income source; side hustles default to irregular.
  Future<bool> save({
    required String name,
    required IncomeKind kind,
    required String landsInAccountId,
    Money? expected,
    int? paydayOfMonth,
    String? id,
  }) async {
    final current = await future;
    state = AsyncData(current.copyWith(saving: true, errorCode: null));
    final result = await ref.read(saveIncomeSourceProvider)(
      id: id,
      name: name,
      kind: kind,
      landsInAccountId: landsInAccountId,
      expectedAmount: expected,
      schedule: paydayOfMonth == null ? null : MonthlyPay(paydayOfMonth),
    );
    switch (result) {
      case Ok():
        ref.invalidateSelf();
        await future;
        return true;
      case Err(:final failure):
        state = AsyncData(current.copyWith(errorCode: failure.code));
        return false;
    }
  }
}
