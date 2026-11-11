import 'package:buckets/bootstrap/ports.dart';
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
    String? displayName,
    Money? income,
    Money? toMoveToSavings,
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
      ref.watch(watchHomeProvider)().asyncMap((r) => _state(r.orThrow()));

  Future<HomeState> _state(HomeData d) async {
    final shares = d.cycle.hadPayday ? null : await _firstRunPlan(d);
    final tiles = [
      for (final b in d.buckets)
        BucketTileVm(
          id: b.id,
          name: b.name,
          kind: b.kind,
          color: b.color,
          balance: d.balances[b.id] ?? Money.zero,
          sharePercent: shares?.percentByBucket[b.id],
        ),
    ];
    if (!d.cycle.hadPayday) {
      return HomeState.firstRun(
        buckets: tiles,
        nextPayday: d.cycle.nextPayday,
        daysUntilPayday: d.cycle.daysLeft,
        displayName: shares?.displayName,
        income: shares?.income,
        toMoveToSavings: shares?.toMoveToSavings,
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

  /// Before the first payday: the salary's split preview, so the hero can
  /// name real amounts and each tile its share (R-SPLIT-1…4). Null when
  /// there is no salary yet.
  Future<_FirstRunPlan?> _firstRunPlan(HomeData d) async {
    final incomes = (await ref.read(incomeRepositoryProvider).getAll())
        .orThrow();
    final salary = incomes
        .where((i) => i.kind == IncomeKind.salary)
        .firstOrNull;
    final name = (await ref.read(profileRepositoryProvider).get())
        .orThrow()
        ?.displayName;
    if (salary == null || salary.expectedAmount == null) {
      return _FirstRunPlan(
        displayName: name,
        income: salary?.expectedAmount,
        toMoveToSavings: null,
        percentByBucket: const {},
      );
    }
    final profile =
        (await ref
                .read(splitProfileRepositoryProvider)
                .get(salary.splitProfileId))
            .orThrow();
    final reservations = (await ref.read(
      getBillReservationsProvider,
    )()).orThrow().$2;
    final living = d.buckets
        .where((b) => b.kind == BucketKind.living)
        .firstOrNull;
    final preview = ref.read(previewSplitProvider)(
      income: salary.expectedAmount!,
      deductBillsFirst: salary.deductBillsFirst,
      billReservations: reservations,
      allocations: profile.allocations,
      livingBucketId: living?.id,
    );
    final shareAmount = {for (final s in preview.shares) s.bucketId: s.amount};
    final accountOf = {for (final b in d.buckets) b.id: b.accountId};
    final toSavings = shareAmount.entries
        .where((e) => accountOf[e.key] != salary.landsInAccountId)
        .fold(Money.zero, (sum, e) => sum + e.value);
    return _FirstRunPlan(
      displayName: name,
      income: salary.expectedAmount,
      toMoveToSavings: toSavings,
      percentByBucket: {
        for (final a in profile.allocations) a.bucketId: a.bp.value ~/ 100,
      },
    );
  }
}

/// The salary split preview Home needs before the first payday.
class _FirstRunPlan {
  const _FirstRunPlan({
    required this.displayName,
    required this.income,
    required this.toMoveToSavings,
    required this.percentByBucket,
  });

  final String? displayName;
  final Money? income;
  final Money? toMoveToSavings;
  final Map<String, int> percentByBucket;
}
