import 'dart:async';

import 'package:buckets/features/home/presentation/controllers/plan_controller.dart';
import 'package:buckets/features/home/presentation/widgets/plan_item_sheet.dart';
import 'package:buckets/features/home/presentation/widgets/wish_card.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/tab_scaffold.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The two Plan tabs.
enum PlanTab {
  /// Planned buys this month.
  toBuy,

  /// Bills this cycle: opens screen 33.
  bills,

  /// Wishes cooling off (R-PLAN-2).
  wishes,
}

/// Screen 11 Plan: planned buys to tick off, and wishes with their
/// cooling-off timers (R-PLAN-1…3).
class PlanScreen extends ConsumerStatefulWidget {
  /// Creates the screen; [initialTab] comes from `?tab=wishes`.
  const PlanScreen({this.initialTab = PlanTab.toBuy, super.key});

  /// The tab to open on.
  final PlanTab initialTab;

  @override
  ConsumerState<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends ConsumerState<PlanScreen> {
  late PlanTab _tab = widget.initialTab;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final value = ref.watch(planControllerProvider);
    final wishes = _tab == PlanTab.wishes;
    return TabScaffold(
      tab: AppTab.plan,
      body: ListView(
        padding: const EdgeInsets.all(BkSpacing.s4),
        children: [
          Row(
            children: [
              Expanded(
                child: BkHeading(
                  child: Text(
                    l.planTitle,
                    style: bk.type.title1.copyWith(color: bk.colors.ink),
                  ),
                ),
              ),
              BkIconButton(
                icon: BkIcons.plus,
                semanticLabel: wishes ? l.planAddWish : l.planAddBuy,
                onPressed: () => openPlanItemSheet(context, wish: wishes),
              ),
            ],
          ),
          const BkGap(BkSpacing.s4),
          BkSegmented<PlanTab>(
            options: [
              BkSegment(PlanTab.toBuy, l.planToBuy),
              BkSegment(PlanTab.bills, l.planBills),
              BkSegment(PlanTab.wishes, l.planWishes),
            ],
            selected: _tab,
            onChanged: (t) => t == PlanTab.bills
                ? context.go(Routes.planBills)
                : setState(() => _tab = t),
          ),
          const BkGap(BkSpacing.s4),
          AsyncBody(
            value: value,
            onRetry: () => ref.invalidate(planControllerProvider),
            data: (s) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (s.errorCode case final code?) ...[
                  BkBanner(tone: BkTone.danger, message: errorText(l, code)),
                  const BkGap(BkSpacing.s3),
                ],
                if (wishes) _wishes(context, s) else _toBuy(context, s),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _toBuy(BuildContext context, PlanState s) {
    final l = AppLocalizations.of(context);
    if (s.planned.isEmpty) {
      return BkEmptyState(
        icon: BkIcons.plan,
        title: l.planBuyEmptyTitle,
        message: l.planBuyEmptyBody,
        actionLabel: l.planAddBuy,
        onAction: () => openPlanItemSheet(context, wish: false),
      );
    }
    final notifier = ref.read(planControllerProvider.notifier);
    return BkListGroup(
      children: [
        for (final p in s.planned)
          BkCheckRow(
            title: p.name,
            subtitle: s.bucketNames[p.bucketId],
            checked: p.done,
            onChanged: (_) => unawaited(notifier.toggle(p.id)),
            trailing: BkMoneyText(ngwee: p.amount.ngwee),
          ),
      ],
    );
  }

  Widget _wishes(BuildContext context, PlanState s) {
    final l = AppLocalizations.of(context);
    if (s.wishes.isEmpty) {
      return BkEmptyState(
        icon: BkIcons.clock,
        title: l.planWishEmptyTitle,
        message: l.planWishEmptyBody,
        actionLabel: l.planAddWish,
        onAction: () => openPlanItemSheet(context, wish: true),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final w in s.wishes) ...[
          WishCard(wish: w, bucketName: s.bucketNames[w.bucketId] ?? ''),
          const BkGap(BkSpacing.s3),
        ],
      ],
    );
  }
}
