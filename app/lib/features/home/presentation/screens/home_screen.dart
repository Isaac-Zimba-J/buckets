import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/home/presentation/controllers/home_controller.dart';
import 'package:buckets/features/home/presentation/controllers/home_view_models.dart';
import 'package:buckets/features/home/presentation/widgets/bucket_action_sheets.dart';
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
    final name = switch (value.value) {
      HomeFirstRun(:final displayName) => displayName,
      _ => null,
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
            greeting: name == null || name.isEmpty
                ? l.homeGreeting
                : l.homeGreetingNamed(l.homeGreeting, name),
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
              // 16 below the greeting, 16 at the sides.
              padding: const EdgeInsets.fromLTRB(
                BkSpacing.s4,
                BkSpacing.s4,
                BkSpacing.s4,
                0,
              ),
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
    final dateText = next == null
        ? null
        : DateFormatter.date(
            DateTime.utc(next.year, next.month, next.day),
            today: today,
          );
    final allZero = state.buckets.every((b) => b.balance == Money.zero);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkHeroCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.homeFirstPayday,
                style: bk.type.callout.copyWith(color: bk.colors.onHeroMuted),
              ),
              const BkGap(BkSpacing.s1),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: BkSpacing.s2,
                children: [
                  Text(
                    days == null ? l.homeNoPayday : l.homeDaysValue(days),
                    style: bk.type.display.copyWith(color: bk.colors.onHero),
                  ),
                  if (dateText != null)
                    Text(
                      '· $dateText',
                      style: bk.type.callout.copyWith(
                        color: bk.colors.onHeroMuted,
                      ),
                    ),
                ],
              ),
              const BkGap(BkSpacing.s3),
              Text(
                state.income != null && state.toMoveToSavings != null
                    ? l.homeFirstRunBodyAmounts(
                        money(state.income!),
                        money(state.toMoveToSavings!),
                      )
                    : l.homeFirstRunBody,
                style: bk.type.callout.copyWith(color: bk.colors.onHero),
              ),
            ],
          ),
        ),
        const BkGap(BkSpacing.s6),
        _SectionLabel(
          label: l.homeYourBuckets,
          trailing: allZero ? l.homeAllZero : null,
        ),
        const BkGap(BkSpacing.s2),
        _Tiles(buckets: state.buckets),
        const BkGap(BkSpacing.s5),
        _StartingCard(onTap: () => _addStartingBalance(context, ref)),
      ],
    );
  }

  Future<void> _addStartingBalance(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    final bucket = await showBkSheet<BucketTileVm>(
      context,
      title: l.homeStartingPick,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final b in state.buckets) ...[
              BkRadioCard(
                title: b.name,
                selected: false,
                onTap: () => Navigator.of(context).pop(b),
              ),
              const BkGap(BkSpacing.s2),
            ],
          ],
        ),
      ),
    );
    if (bucket == null || !context.mounted) return;
    await openStartingBalanceSheet(
      context,
      bucketName: bucket.name,
      onSave: (amount) async => await ref.read(setStartingBalanceProvider)(
        bucketId: bucket.id,
        amount: amount,
      ) is Ok,
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
          // One button for screen readers, read as the banner's text.
          MergeSemantics(
            child: Semantics(
              button: true,
              child: GestureDetector(
                onTap: () => context.go(Routes.payday(banner.paydayId)),
                child: BkBanner(
                  tone: BkTone.warning,
                  title: l.homePaydayBanner(banner.pending),
                  message: l.homePaydayBannerBody(money(banner.pendingAmount)),
                ),
              ),
            ),
          ),
          const BkGap(BkSpacing.s4),
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
          const BkGap(BkSpacing.s4),
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
        const BkGap(BkSpacing.s6),
        _Tiles(buckets: state.buckets),
        const BkGap(BkSpacing.s6),
        BkHeading(
          child: Text(
            l.homeRecent,
            style: bk.type.title2.copyWith(color: bk.colors.ink),
          ),
        ),
        const BkGap(BkSpacing.s3),
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
        const BkGap(BkSpacing.s4),
        BkListGroup(
          children: [
            BkListRow(
              title: l.spendHistoryLink,
              chevron: true,
              onTap: () => context.go(Routes.spendHistory),
            ),
          ],
        ),
      ],
    );
  }
}

/// An uppercase section label with an optional muted value on the right
/// (e.g. "YOUR BUCKETS … All at K 0"), matching the Settings screens.
class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, this.trailing});

  final String label;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return Row(
      children: [
        Expanded(
          child: BkHeading(
            child: Text(
              label.toUpperCase(),
              style: bk.type.overline.copyWith(color: bk.colors.inkMuted),
            ),
          ),
        ),
        if (trailing case final t?)
          Text(t, style: bk.type.caption.copyWith(color: bk.colors.inkMuted)),
      ],
    );
  }
}

/// The compact "Already have some savings?" card (R-LEDGER-6): icon chip,
/// title and one line, the whole card tappable.
class _StartingCard extends StatelessWidget {
  const _StartingCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return BkCard(
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(bk.radius.lg),
        child: Padding(
          padding: const EdgeInsets.all(BkSpacing.s4),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: bk.colors.infoTint,
                  borderRadius: BorderRadius.circular(bk.radius.md),
                ),
                child: BkIcon(BkIcons.plus, size: 22, color: bk.colors.info),
              ),
              const BkGap(BkSpacing.s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BkHeading(
                      child: Text(
                        l.homeStartingCard,
                        style: bk.type.headline.copyWith(color: bk.colors.ink),
                      ),
                    ),
                    const BkGap(BkSpacing.s1),
                    Text(
                      l.homeStartingCardBody,
                      style: bk.type.caption.copyWith(
                        color: bk.colors.inkMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
    childAspectRatio: 1.35,
    children: [
      for (final b in buckets)
        BkBucketTile(
          label: b.name,
          color: b.color.bk,
          amountText: money(b.balance),
          caption: b.sharePercent == null ? null : '${b.sharePercent}%',
          onTap: () => context.go(Routes.bucket(b.id)),
        ),
    ],
  );
}
