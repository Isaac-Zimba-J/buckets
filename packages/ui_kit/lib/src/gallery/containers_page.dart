import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// Gallery page: Containers in light or dark, every state.
class ContainersPage extends StatelessWidget {
  /// Creates the page.
  const ContainersPage({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.bk.colors.bg,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BkHeroCard(
          child: BkMoneyText(
            ngwee: 308000,
            size: BkAmountSize.xl,
            color: context.bk.colors.onHero,
          ),
        ),
        const BkGap(BkSpacing.s3),
        const BkCard(child: Text('Surface card')),
        const BkGap(BkSpacing.s3),
        BkListGroup(
          children: [
            BkListRow(
              title: 'Rent',
              subtitle: 'Due 1 Nov',
              trailing: const BkMoneyText(ngwee: 250000),
              chevron: true,
              onTap: () {},
            ),
            const BkListRow(
              title: 'ZESCO',
              trailing: BkMoneyText(ngwee: 40000),
            ),
          ],
        ),
        const BkGap(BkSpacing.s3),
        const BkSkeleton(height: 28, width: 160),
        const BkGap(BkSpacing.s2),
        const BkSkeleton(height: 16),
        BkEmptyState(
          icon: BkIcons.goals,
          title: 'No goals yet',
          message: 'Add one and part of every payday goes to it.',
          actionLabel: 'Add a goal',
          onAction: () {},
        ),
      ],
    ),
  );
}
