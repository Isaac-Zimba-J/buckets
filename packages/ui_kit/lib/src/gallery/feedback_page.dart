import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// Gallery page: Feedback in light or dark, every state.
class FeedbackPage extends StatelessWidget {
  /// Creates the page.
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.bk.colors.bg,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final tone in BkTone.values.where((t) => t != BkTone.neutral)) ...[
          BkBanner(tone: tone, title: 'Heads up', message: 'What to do next.'),
          const BkGap(BkSpacing.s2),
        ],
        Wrap(
          spacing: BkSpacing.s2,
          children: [
            for (final tone in BkTone.values)
              BkBadge(label: tone.name, tone: tone),
          ],
        ),
        const BkGap(BkSpacing.s3),
        const BkToast(message: 'Saved', actionLabel: 'Undo'),
        const BkGap(BkSpacing.s3),
        BkBottomSheet(
          title: 'Sort payment',
          actions: [BkButton.primary(label: 'File it', onPressed: () {})],
          child: const Text('Body'),
        ),
      ],
    ),
  );
}
