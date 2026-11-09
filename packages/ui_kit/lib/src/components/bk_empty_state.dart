import 'package:buckets_ui_kit/src/components/bk_button.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/foundation/bk_semantics.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// What goes where a list is empty: what will be here, how it fills, and
/// one action (PATTERNS). Never a blank list.
///
/// ```dart
/// BkEmptyState(icon: BkIcons.goals, title: 'No goals yet',
///     message: 'Add one and part of every payday goes to it.',
///     actionLabel: 'Add a goal', onAction: addGoal)
/// ```
class BkEmptyState extends StatelessWidget {
  /// Creates the empty state.
  const BkEmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  /// The glyph above the title.
  final BkIcons icon;

  /// What will be here.
  final String title;

  /// One sentence on how it fills.
  final String message;

  /// The action text.
  final String? actionLabel;

  /// The action.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    final label = actionLabel;
    return Padding(
      padding: const EdgeInsets.all(BkSpacing.s6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: c.surfaceSunken,
              shape: BoxShape.circle,
            ),
            child: Center(child: BkIcon(icon, size: 28, color: c.inkMuted)),
          ),
          const BkGap(BkSpacing.s4),
          BkHeading(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: bk.type.title2.copyWith(color: c.ink),
            ),
          ),
          const BkGap(BkSpacing.s2),
          Text(
            message,
            textAlign: TextAlign.center,
            style: bk.type.body.copyWith(color: c.inkMuted),
          ),
          if (label != null) ...[
            const BkGap(BkSpacing.s5),
            BkButton.primary(label: label, onPressed: onAction),
          ],
        ],
      ),
    );
  }
}
