import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// Gallery page: Money widgets in light or dark, every state.
class MoneyWidgetsPage extends StatelessWidget {
  /// Creates the page.
  const MoneyWidgetsPage({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.bk.colors.bg,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BkSplitBar(
          segments: [
            (BkBucketColor.living, 4000),
            (BkBucketColor.fun, 1000),
            (BkBucketColor.emergency, 1000),
            (BkBucketColor.short, 1000),
            (BkBucketColor.long, 2000),
            (BkBucketColor.goal, 1000),
          ],
        ),
        const BkGap(BkSpacing.s4),
        Row(
          children: [
            for (final (label, color, p) in const [
              ('Living', BkBucketColor.living, 0.6),
              ('Guilt-free', BkBucketColor.fun, 0.2),
              ('Laptop', BkBucketColor.goal, 0.9),
            ]) ...[
              Expanded(
                child: BkBucketTile(
                  label: label,
                  color: color,
                  amountText: 'K 770',
                  progress: p,
                ),
              ),
              const BkGap(BkSpacing.s2),
            ],
          ],
        ),
        const BkGap(BkSpacing.s4),
        const BkHeroCard(
          child: Column(
            children: [
              BkProgressBar(value: 0.5, onHero: true),
              BkGap(BkSpacing.s2),
              BkProgressBar(value: 0.3, color: BkBucketColor.short),
            ],
          ),
        ),
        const BkGap(BkSpacing.s4),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BkProgressRing(value: 0.25, centerLabel: '36h'),
            BkProgressRing(value: 1, centerLabel: '0h'),
            BkBucketDot(color: BkBucketColor.family, size: 16),
          ],
        ),
        BkListGroup(
          children: [
            for (final (status, label) in const [
              (BkTransferStatus.pending, 'Needs proof'),
              (BkTransferStatus.proven, 'Proven'),
              (BkTransferStatus.partial, 'K 70 owed'),
              (BkTransferStatus.selfReported, 'Marked saved'),
            ])
              BkTransferRow(
                bucketLabel: 'Emergency',
                color: BkBucketColor.emergency,
                amountText: 'K 770',
                destination: 'Bank ••4521',
                status: status,
                statusLabel: label,
              ),
          ],
        ),
        const BkGap(BkSpacing.s3),
        for (final r in BkCheckResult.values)
          BkProofCheckRow(label: 'Amount', value: 'K 770', result: r),
        const BkStepList(
          steps: [
            BkStep('Sort payments', BkStepState.done),
            BkStep('Count cash', BkStepState.active, subtitle: '2 of 3'),
            BkStep('Your week', BkStepState.todo),
          ],
        ),
      ],
    ),
  );
}
