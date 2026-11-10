import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A stat tile on a `hero` ground (payday complete): a faint `on-hero`
/// fill, `radius-lg`, an `accent` icon with a muted caption, then the
/// value in title-2. Read as one sentence by screen readers.
///
/// ```dart
/// BkHeroStat(icon: BkIcons.streak, label: 'Streak', value: '5 paydays')
/// ```
class BkHeroStat extends StatelessWidget {
  /// Creates the tile.
  const BkHeroStat({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });

  /// The glyph beside the caption.
  final BkIcons icon;

  /// What the number is.
  final String label;

  /// The number, as text.
  final String value;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    return MergeSemantics(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: c.onHero.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(bk.radius.lg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(BkSpacing.s4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  BkIcon(icon, size: 16, color: c.accent),
                  const BkGap(BkSpacing.s2),
                  Flexible(
                    child: Text(
                      label,
                      style: bk.type.caption.copyWith(color: c.onHeroMuted),
                    ),
                  ),
                ],
              ),
              const BkGap(BkSpacing.s2),
              Text(value, style: bk.type.title2.copyWith(color: c.onHero)),
            ],
          ),
        ),
      ),
    );
  }
}
