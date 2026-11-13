import 'package:buckets/bootstrap/bills_fees_use_cases.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fee_rates_controller.g.dart';

/// Screen 37 Fee rates, live: the saved tariffs; empty means no rates yet.
@riverpod
class FeeRatesController extends _$FeeRatesController {
  @override
  Stream<List<FeeTariff>> build() => ref.watch(watchFeeTariffsProvider)();

  /// Saves a band (R-FEE-3). Returns the failure code, or null on success.
  Future<String?> saveBand({
    required AlertSource provider,
    required FeeType feeType,
    required Money min,
    required Money max,
    required Money fee,
  }) async => _code(
    await ref.read(saveFeeBandProvider)(
      provider: provider,
      feeType: feeType,
      min: min,
      max: max,
      fee: fee,
    ),
  );

  /// Removes the band starting at [min].
  Future<String?> deleteBand({
    required AlertSource provider,
    required FeeType feeType,
    required Money min,
  }) async => _code(
    await ref.read(deleteFeeBandProvider)(
      provider: provider,
      feeType: feeType,
      min: min,
    ),
  );

  /// Accepts or declines a learned rate change (R-FEE-4).
  Future<String?> resolve({
    required AlertSource provider,
    required FeeType feeType,
    required FeeChange change,
    required bool accept,
  }) async => _code(
    await ref.read(resolveFeeChangeProvider)(
      provider: provider,
      feeType: feeType,
      change: change,
      accept: accept,
    ),
  );

  String? _code(Result<Object?> r) => switch (r) {
    Err(:final failure) => failure.code,
    Ok() => null,
  };
}
