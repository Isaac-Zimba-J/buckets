import 'package:buckets/bootstrap/bills_fees_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fees_controller.freezed.dart';
part 'fees_controller.g.dart';

/// Screen 36 Fees.
@freezed
abstract class FeesState with _$FeesState {
  /// [summary] is null before the first cycle; [missing] are fees whose
  /// amount is unknown (R-FEE-2).
  const factory FeesState({
    required FeesSummary? summary,
    required List<Transaction> missing,
  }) = _FeesState;

  const FeesState._();

  /// No fees yet this cycle.
  bool get isEmpty =>
      summary == null || summary!.total.isZero && missing.isEmpty;
}

/// Screen 36, live.
@riverpod
class FeesController extends _$FeesController {
  @override
  Stream<FeesState> build() => ref
      .watch(watchFeesSummaryProvider)()
      .asyncMap(
        (s) async => FeesState(
          summary: s,
          missing: (await ref.read(listMissingFeesProvider)()).orThrow(),
        ),
      );
}
