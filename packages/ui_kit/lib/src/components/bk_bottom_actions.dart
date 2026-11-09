import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// The pinned area for a screen's buttons, with a 32 px bottom inset
/// above the system bar.
///
/// ```dart
/// BkBottomActions(children: [BkButton.primary(label: 'Continue',
///     onPressed: next)])
/// ```
class BkBottomActions extends StatelessWidget {
  /// Stacks [children] with small gaps.
  const BkBottomActions({required this.children, super.key});

  /// Usually one primary button, optionally a secondary or text one.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final inset = MediaQuery.paddingOf(context).bottom;
    return ColoredBox(
      color: context.bk.colors.bg,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          BkSpacing.s4,
          BkSpacing.s3,
          BkSpacing.s4,
          BkSpacing.s8 + inset,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (i, c) in children.indexed) ...[
              if (i > 0) const BkGap(BkSpacing.s2),
              c,
            ],
          ],
        ),
      ),
    );
  }
}
