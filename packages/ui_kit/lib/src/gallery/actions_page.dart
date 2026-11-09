import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// Gallery page: Actions in light or dark, every state.
class ActionsPage extends StatelessWidget {
  /// Creates the page.
  const ActionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    void tap() {}
    return ColoredBox(
      color: context.bk.colors.bg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BkButton.primary(label: 'Check proof', onPressed: tap),
          const BkGap(BkSpacing.s2),
          const BkButton.primary(
            label: 'Saving',
            onPressed: null,
            loading: true,
          ),
          const BkGap(BkSpacing.s2),
          BkButton.secondary(
            label: 'Retake',
            icon: BkIcons.camera,
            onPressed: tap,
          ),
          const BkGap(BkSpacing.s2),
          const BkButton.secondary(
            label: 'Snooze',
            onPressed: null,
            disabledReason: 'No snoozes left',
          ),
          const BkGap(BkSpacing.s2),
          BkButton.destructive(label: 'Remove', onPressed: tap),
          BkButton.text(label: 'Skip', onPressed: tap),
          const BkGap(BkSpacing.s2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BkIconButton(
                icon: BkIcons.back,
                semanticLabel: 'Back',
                onPressed: tap,
              ),
              const BkIconButton(
                icon: BkIcons.close,
                semanticLabel: 'Close',
                onPressed: null,
              ),
              ColoredBox(
                color: context.bk.colors.hero,
                child: Padding(
                  padding: const EdgeInsets.all(BkSpacing.s2),
                  child: BkIconButton(
                    icon: BkIcons.notifications,
                    semanticLabel: 'Notifications',
                    variant: BkIconButtonVariant.onHero,
                    onPressed: tap,
                  ),
                ),
              ),
              BkFab(semanticLabel: 'Log a payment', onPressed: tap),
            ],
          ),
        ],
      ),
    );
  }
}
