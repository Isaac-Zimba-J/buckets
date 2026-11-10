import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/home/presentation/controllers/home_controller.dart';
import 'package:buckets/features/home/presentation/controllers/home_view_models.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/tab_scaffold.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screens 07 (before the first payday) and 08 (mid-cycle) Home.
class HomeScreen extends ConsumerWidget {
  /// Creates the screen.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(homeControllerProvider);
    final unsorted = switch (value.value) {
      HomeActive(:final unsortedCount) => unsortedCount,
      _ => 0,
    };
    return TabScaffold(
      tab: AppTab.home,
      fab: BkFab(
        semanticLabel: l.homeLog,
        onPressed: () => context.go(Routes.log),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: BkSpacing.s8 * 3),
        children: [
          BkGreetingHeader(
            greeting: l.homeGreeting,
            title: value.value is HomeFirstRun
                ? l.homeTitleFirstRun
                : l.homeTitle,
            notificationsLabel: l.homeToSort(unsorted),
            hasUnread: unsorted > 0,
            onNotifications: () => context.go(Routes.sort),
          ),
          AsyncBody(
            value: value,
            onRetry: () => ref.invalidate(homeControllerProvider),
            data: (s) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: BkSpacing.s4),
              child: switch (s) {
                HomeFirstRun() => _FirstRun(state: s),
                HomeActive() => _Active(state: s),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FirstRun extends ConsumerWidget {
  const _FirstRun({required this.state});

  final HomeFirstRun state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final next = state.nextPayday;
    final days = state.daysUntilPayday;
    final today = wallTime(
      ref.watch(clockProvider).now(),
      ref.watch(localTimeZoneProvider),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkHeroCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                days == null ? l.homeNoPayday : l.homePaydayIn(days),
                style: bk.type.title2.copyWith(color: bk.colors.onHero),
              ),
              if (next != null)
                Text(
                  DateFormatter.date(
                    DateTime.utc(next.year, next.month, next.day),
                    today: today,
                  ),
                  style: bk.type.callout.copyWith(color: bk.colors.onHeroMuted),
                ),
              const BkGap(BkSpacing.s3),
              Text(
                l.homeFirstRunBody,
                style: bk.type.callout.copyWith(color: bk.colors.onHero),
              ),
            ],
          ),
        ),
        const BkGap(BkSpacing.s5),
        _Tiles(buckets: state.buckets),
      ],
    );
  }
}

class _Active extends ConsumerWidget {
  const _Active({required this.state});

  final HomeActive state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final banner = state.banner;
    final perDay = state.perDay;
    final today = wallTime(
      ref.watch(clockProvider).now(),
      ref.watch(localTimeZoneProvider),
    );
    final zone = ref.watch(localTimeZoneProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (banner != null) ...[
          GestureDetector(
            onTap: () => context.go(Routes.payday(banner.paydayId)),
            child: BkBanner(
              tone: BkTone.warning,
              title: l.homePaydayBanner(banner.pending),
              message: l.homePaydayBannerBody(money(banner.pendingAmount)),
            ),
          ),
          const BkGap(BkSpacing.s3),
        ],
        BkHeroCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.homeLivingLeft,
                style: bk.type.callout.copyWith(color: bk.colors.onHeroMuted),
              ),
              BkMoneyText(
                ngwee: state.livingLeft.ngwee,
                size: BkAmountSize.xl,
                color: bk.colors.onHero,
              ),
              if (perDay != null)
                Text(
                  l.homePerDay(money(perDay)),
                  style: bk.type.callout.copyWith(color: bk.colors.onHero),
                ),
              const BkGap(BkSpacing.s3),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l.homeGuiltFree,
                      style: bk.type.callout.copyWith(
                        color: bk.colors.onHeroMuted,
                      ),
                    ),
                  ),
                  BkMoneyText(
                    ngwee: state.guiltFreeLeft.ngwee,
                    color: bk.colors.accent,
                  ),
                ],
              ),
              if (!state.unlocked) ...[
                const BkGap(BkSpacing.s2),
                Row(
                  children: [
                    BkIcon(BkIcons.lock, size: 16, color: bk.colors.onHero),
                    const BkGap(BkSpacing.s1),
                    Expanded(
                      child: Text(
                        l.homeLocked,
                        style: bk.type.caption.copyWith(
                          color: bk.colors.onHero,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        if (state.unsortedCount > 0) ...[
          const BkGap(BkSpacing.s3),
          BkListGroup(
            children: [
              BkListRow(
                leading: BkIcon(BkIcons.warning, color: bk.colors.warning),
                title: l.homeToSort(state.unsortedCount),
                chevron: true,
                onTap: () => context.go(Routes.sort),
              ),
            ],
          ),
        ],
        const BkGap(BkSpacing.s5),
        _Tiles(buckets: state.buckets),
        const BkGap(BkSpacing.s5),
        BkHeading(
          child: Text(
            l.homeRecent,
            style: bk.type.title2.copyWith(color: bk.colors.ink),
          ),
        ),
        const BkGap(BkSpacing.s2),
        if (state.recent.isEmpty)
          Text(
            l.homeRecentEmpty,
            style: bk.type.body.copyWith(color: bk.colors.inkMuted),
          )
        else
          BkListGroup(
            children: [
              for (final t in state.recent)
                BkListRow(
                  title: t.category,
                  subtitle: DateFormatter.relativeDay(
                    wallTime(t.occurredAt, zone),
                    today: today,
                  ),
                  trailing: BkMoneyText(ngwee: -t.amount.ngwee),
                ),
            ],
          ),
      ],
    );
  }
}

class _Tiles extends StatelessWidget {
  const _Tiles({required this.buckets});

  final List<BucketTileVm> buckets;

  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 3,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    mainAxisSpacing: BkSpacing.s2,
    crossAxisSpacing: BkSpacing.s2,
    childAspectRatio: 1.1,
    children: [
      for (final b in buckets)
        BkBucketTile(
          label: b.name,
          color: b.color.bk,
          amountText: money(b.balance),
          onTap: () => context.go(Routes.bucket(b.id)),
        ),
    ],
  );
}
