import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_privacy_controller.freezed.dart';
part 'data_privacy_controller.g.dart';

/// Screen 27 Data & privacy: storage summary, clear-alert-history and
/// delete-all (R-PRIV-3, R-PRIV-4).
@freezed
abstract class DataPrivacyState with _$DataPrivacyState {
  /// On-device storage facts; [errorCode] is the last action that failed.
  const factory DataPrivacyState({
    required StorageSummary storage,
    String? errorCode,
  }) = _DataPrivacyState;
}

/// Screen 27 Data & privacy, live.
@riverpod
class DataPrivacyController extends _$DataPrivacyController {
  @override
  Future<DataPrivacyState> build() async {
    final storage = (await ref.read(getStorageSummaryProvider)()).orThrow();
    return DataPrivacyState(storage: storage);
  }

  Future<void> _refresh() async {
    final storage = await ref.read(getStorageSummaryProvider)();
    final current = state.value;
    if (current == null) return;
    if (storage case Ok(:final value)) {
      state = AsyncData(current.copyWith(storage: value, errorCode: null));
    }
  }

  /// Deletes stored raw alert text now (R-PRIV-3).
  Future<bool> clearAlertHistory() async {
    final result = await ref.read(clearAlertHistoryProvider)();
    if (result case Err(:final failure)) {
      final current = state.value;
      if (current != null) {
        state = AsyncData(current.copyWith(errorCode: failure.code));
      }
      return false;
    }
    await _refresh();
    return true;
  }

  /// Wipes all data after the user typed DELETE (R-PRIV-4). The screen sends
  /// the user to Welcome on success.
  Future<bool> deleteAll(String typed) async {
    final result = await ref.read(deleteAllDataProvider)(typed);
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
