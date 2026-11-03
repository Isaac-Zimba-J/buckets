import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sort_alerts_controller.freezed.dart';
part 'sort_alerts_controller.g.dart';

/// The alert on top of the sort sheet (screen 18).
@freezed
abstract class AlertVm with _$AlertVm {
  /// Creates the card.
  const factory AlertVm({
    required String id,
    required Money? amount,
    required Money? fee,
    required String? counterparty,
    required DateTime receivedAt,
  }) = _AlertVm;

  /// The card for [a].
  factory AlertVm.of(PaymentAlert a) => AlertVm(
    id: a.id,
    amount: a.parsed.amount,
    fee: a.parsed.fee,
    counterparty: a.parsed.counterparty,
    receivedAt: a.receivedAt,
  );
}

/// Screen 18 sort sheet.
@freezed
sealed class SortAlertsState with _$SortAlertsState {
  /// The next alert, pre-filled from a merchant rule when there is one
  /// (R-SPEND-3). [isLast] labels the last one.
  const factory SortAlertsState.next({
    required AlertVm alert,
    required Category? category,
    required String? bucketId,
    required int remaining,
    required bool isLast,
    String? errorCode,
  }) = SortNext;

  /// Nothing left: the sheet closes with "All sorted".
  const factory SortAlertsState.none() = SortNone;
}

/// Screen 18, live over the unsorted alerts.
@riverpod
class SortAlertsController extends _$SortAlertsController {
  final _skipped = <String>{};

  @override
  Stream<SortAlertsState> build() =>
      ref.watch(watchUnsortedAlertsProvider)().asyncMap(_state);

  Future<SortAlertsState> _state(List<PaymentAlert> unsorted) async {
    final queue = unsorted.where((a) => !_skipped.contains(a.id)).toList();
    if (queue.isEmpty) return const SortAlertsState.none();
    final top = queue.first;
    final suggestion = await ref.read(suggestAlertFilingProvider)(top);
    final s = switch (suggestion) {
      Ok(:final value) => value,
      Err() => null,
    };
    return SortAlertsState.next(
      alert: AlertVm.of(top),
      category: s?.category,
      bucketId: s?.bucketId,
      remaining: queue.length,
      isLast: queue.length == 1,
    );
  }

  /// Files the top alert as [category] from [bucketId] (R-SPEND-1…4).
  Future<bool> file({
    required Category category,
    required String bucketId,
    bool alwaysFile = false,
  }) async {
    final current = state.value;
    if (current is! SortNext) return false;
    final result = await ref.read(categorizeAlertProvider)(
      alertId: current.alert.id,
      category: category,
      bucketId: bucketId,
      alwaysFile: alwaysFile,
    );
    if (result case Err(:final failure)) {
      state = AsyncData(current.copyWith(errorCode: failure.code));
      return false;
    }
    return true;
  }

  /// Leaves the top alert unsorted and shows the next one.
  Future<void> skip() async {
    final current = state.value;
    if (current is! SortNext) return;
    _skipped.add(current.alert.id);
    final unsorted = await ref.read(watchUnsortedAlertsProvider)().first;
    state = AsyncData(await _state(unsorted));
  }
}
