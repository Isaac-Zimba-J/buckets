import 'dart:async';

import 'package:buckets/features/home/presentation/controllers/home_view_models.dart';
import 'package:buckets/features/home/presentation/controllers/plan_controller.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A wish on the Plan tab (screen 11): the cooling-off ring with the hours
/// left, then "Changed my mind" while it runs, or "Still want it" / "Drop
/// it" once it has ended (R-PLAN-2).
class WishCard extends ConsumerWidget {
  /// Creates the card.
  const WishCard({required this.wish, required this.bucketName, super.key});

  /// The wish.
  final WishVm wish;

  /// The bucket it would come from.
  final String bucketName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final w = wish;
    final notifier = ref.read(planControllerProvider.notifier);
    final approved = w.status == WishStatus.approved;
    final ended = !approved && w.timeLeft == Duration.zero;
    // Round up so "1h" shows until the very end.
    final hours = (w.timeLeft.inMinutes + 59) ~/ 60;
    return BkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              BkProgressRing(
                value: approved ? 1 : w.progress,
                centerLabel: approved || ended ? '' : l.planHoursLeft(hours),
                size: 48,
              ),
              const BkGap(BkSpacing.s3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      w.name,
                      style: bk.type.headline.copyWith(color: bk.colors.ink),
                    ),
                    Text(
                      l.planFrom(bucketName),
                      style: bk.type.caption.copyWith(
                        color: bk.colors.inkMuted,
                      ),
                    ),
                  ],
                ),
              ),
              BkMoneyText(ngwee: w.amount.ngwee),
            ],
          ),
          const BkGap(BkSpacing.s3),
          Text(
            approved
                ? l.planApproved
                : ended
                ? l.planTimeUp
                : l.planAskAgain(hours),
            style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
          ),
          if (!approved) ...[
            const BkGap(BkSpacing.s3),
            if (ended) ...[
              BkButton.primary(
                label: l.planStillWant,
                onPressed: () => unawaited(notifier.approve(w.id)),
              ),
              BkButton.text(
                label: l.planDrop,
                onPressed: () => unawaited(notifier.drop(w.id)),
              ),
            ] else
              BkButton.destructive(
                label: l.planChangedMind,
                onPressed: () => unawaited(notifier.drop(w.id)),
              ),
          ],
        ],
      ),
    );
  }
}
