import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/setup/presentation/controllers/setup_view_models.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'me_controller.freezed.dart';
part 'me_controller.g.dart';

/// Screen 24 Me: the profile summary and the incomes (for their splits).
@freezed
abstract class MeState with _$MeState {
  /// Creates the state.
  const factory MeState({
    required ProfileSummary summary,
    required List<IncomeVm> incomes,
  }) = _MeState;
}

/// Screen 24 Me, live.
@riverpod
class MeController extends _$MeController {
  @override
  Stream<MeState> build() =>
      ref.watch(watchProfileSummaryProvider)().asyncMap((summary) async {
        final incomes = (await ref.read(incomeRepositoryProvider).getAll())
            .orThrow();
        return MeState(
          summary: summary,
          incomes: incomes.map(IncomeVm.of).toList(),
        );
      });
}
