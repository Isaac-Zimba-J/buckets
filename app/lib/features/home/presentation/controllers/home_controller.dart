import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/home/presentation/controllers/home_view_models.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.freezed.dart';
part 'home_controller.g.dart';

/// Screens 07–08 Home.
@freezed
sealed class HomeState with _$HomeState {
  /// Before the first payday: countdown and empty tiles (screen 07).
  const factory HomeState.firstRun({
    required List<BucketTileVm> buckets,
    required LocalDate? nextPayday,
    required int? daysUntilPayday,
  }) = HomeFirstRun;

  /// Mid-cycle (screen 08). [banner] shows while a payday is open;
  /// [unlocked] hides the lock note (R-PAY-5).
  const factory HomeState.active({
    required Money livingLeft,
    required Money? perDay,
    required Money guiltFreeLeft,
    required List<BucketTileVm> buckets,
    required int unsortedCount,
    required List<TransactionRowVm> recent,
    required PaydayBannerVm? banner,
    required bool unlocked,
  }) = HomeActive;
}

/// Screens 07–08 Home, live.
@riverpod
class HomeController extends _$HomeController {
  @override
  Stream<HomeState> build() =>
      ref.watch(watchHomeProvider)().map((r) => _state(r.orThrow()));

  static HomeState _state(HomeData d) {
    final tiles = [
      for (final b in d.buckets)
        BucketTileVm(
          id: b.id,
          name: b.name,
          kind: b.kind,
          color: b.color,
          balance: d.balances[b.id] ?? Money.zero,
        ),
    ];
    if (!d.cycle.hadPayday) {
      return HomeState.firstRun(
        buckets: tiles,
        nextPayday: d.cycle.nextPayday,
        daysUntilPayday: d.cycle.daysLeft,
      );
    }
    final open = d.openPayday;
    final pending = open?.transfers
        .where((t) => t.status == TransferStatus.pending)
        .toList();
    return HomeState.active(
      livingLeft: d.livingLeft,
      perDay: d.perDay,
      guiltFreeLeft: d.guiltFreeLeft,
      buckets: tiles,
      unsortedCount: d.unsortedCount,
      recent: d.recent.map(TransactionRowVm.of).toList(),
      banner: open == null || pending!.isEmpty
          ? null
          : PaydayBannerVm(
              paydayId: open.id,
              pending: pending.length,
              pendingAmount: pending.fold(Money.zero, (s, t) => s + t.amount),
            ),
      unlocked: d.unlocked,
    );
  }
}
