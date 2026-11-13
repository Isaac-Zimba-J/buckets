import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'spend_history_controller.g.dart';

/// Spend history screen, live.
@riverpod
class SpendHistoryController extends _$SpendHistoryController {
  @override
  Stream<SpendHistory> build() => ref.watch(watchSpendHistoryProvider)();
}
