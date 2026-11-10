import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/home/presentation/controllers/goals_controller.dart';
import 'package:buckets/features/home/presentation/controllers/home_view_models.dart';
import 'package:buckets/features/home/presentation/widgets/goal_sheet.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/tab_scaffold.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 10 Goals: savings stats and a card per goal with its progress
/// and ETA (R-GOAL-1…4); a reached goal is celebrated once.
class GoalsScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  final _celebrated = <String>{};

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final value = ref.watch(goalsControllerProvider);
    _celebrate(value.value);
    return TabScaffold(
      tab: AppTab.goals,
      body: ListView(
        padding: const EdgeInsets.all(BkSpacing.s4),
        children: [
          Row(
            children: [
              Expanded(
                child: BkHeading(
                  child: Text(
                    l.goalsTitle,
                    style: bk.type.title1.copyWith(color: bk.colors.ink),
                  ),
                ),
              ),
              BkIconButton(
                icon: BkIcons.plus,
                semanticLabel: l.goalsNew,
                onPressed: () => openGoalSheet(context),
              ),
            ],
          ),
          const BkGap(BkSpacing.s4),
          AsyncBody(
            value: value,
            onRetry: () => ref.invalidate(goalsControllerProvider),
            data: (s) => switch (s) {
              GoalsEmpty() => BkEmptyState(
                icon: BkIcons.goals,
                title: l.goalsEmptyTitle,
                message: l.goalsEmptyBody,
                actionLabel: l.goalsAdd,
                onAction: () => openGoalSheet(context),
              ),
              GoalsReady() => _Ready(state: s),
            },
          ),
        ],
      ),
    );
  }

  /// Shows the toast for a goal that just reached its target, once
  /// (R-GOAL-4): the controller records it, so the next state is quiet.
  void _celebrate(GoalsState? state) {
    if (state is! GoalsReady) return;
    final card = state.goals
        .where((g) => g.celebrate && !_celebrated.contains(g.bucketId))
        .firstOrNull;
    if (card == null) return;
    _celebrated.add(card.bucketId);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(goalsControllerProvider.notifier)
          .celebrated(card.bucketId);
      if (mounted) {
        showBkToast(
          context,
          message: AppLocalizations.of(context).goalsCelebrate(card.name),
        );
      }
    });
  }
}

class _Ready extends StatelessWidget {
  const _Ready({required this.state});

  final GoalsReady state;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: _Stat(l.goalsSavedSoFar, state.totalSaved)),
            const BkGap(BkSpacing.s3),
            Expanded(child: _Stat(l.goalsSavedThisMonth, state.savedThisCycle)),
          ],
        ),
        for (final g in state.goals) ...[
          const BkGap(BkSpacing.s3),
          _GoalCard(goal: g),
        ],
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.amount);

  final String label;
  final Money amount;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return BkCard(
      child: MergeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
            ),
            const BkGap(BkSpacing.s1),
            BkMoneyText(ngwee: amount.ngwee),
          ],
        ),
      ),
    );
  }
}

class _GoalCard extends ConsumerWidget {
  const _GoalCard({required this.goal});

  final GoalCardVm goal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final g = goal;
    final progress = g.target.isPositive
        ? (g.balance.ngwee / g.target.ngwee).clamp(0.0, 1.0)
        : 0.0;
    final perMonth = money(g.monthlyContribution);
    final today = wallTime(
      ref.watch(clockProvider).now(),
      ref.watch(localTimeZoneProvider),
    );
    final caption = switch (g.eta) {
      GoalEtaKind.reached => l.goalsReached,
      GoalEtaKind.notInSplit => l.goalsNotInSplit,
      GoalEtaKind.inMonths => switch (g.etaDate) {
        final d? => l.goalsEtaDate(
          perMonth,
          DateFormatter.month(DateTime(d.year, d.month, d.day), today: today),
        ),
        null => l.goalsEtaMonths(perMonth, g.etaMonths ?? 0),
      },
    };
    return BkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const BkBucketDot(color: BkBucketColor.goal),
              const BkGap(BkSpacing.s2),
              Expanded(
                child: Text(
                  g.name,
                  style: bk.type.headline.copyWith(color: bk.colors.ink),
                ),
              ),
            ],
          ),
          const BkGap(BkSpacing.s2),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: BkSpacing.s2,
            children: [
              BkMoneyText(ngwee: g.balance.ngwee, size: BkAmountSize.l),
              Text(
                l.goalsOf(money(g.target)),
                style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
              ),
            ],
          ),
          const BkGap(BkSpacing.s2),
          BkProgressBar(value: progress, color: BkBucketColor.goal),
          const BkGap(BkSpacing.s2),
          Text(
            caption,
            style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
          ),
          if (g.eta == GoalEtaKind.notInSplit)
            BkButton.text(
              label: l.goalsGivePercent,
              onPressed: () => context.go(Routes.meIncome),
            ),
        ],
      ),
    );
  }
}
