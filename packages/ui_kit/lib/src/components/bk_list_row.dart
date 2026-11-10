import 'package:buckets_ui_kit/src/components/row_text.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A row in a `BkListGroup`: 56 min height, headline and caption left,
/// optional trailing content (usually an amount) and chevron.
///
/// ```dart
/// BkListRow(title: 'Rent', subtitle: 'Due 1 Nov',
///     trailing: BkMoneyText(ngwee: 250000), onTap: openRent)
/// ```
class BkListRow extends StatelessWidget {
  /// Creates the row.
  const BkListRow({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.chevron = false,
    this.onTap,
    super.key,
  });

  /// The main line.
  final String title;

  /// The muted second line.
  final String? subtitle;

  /// Optional content on the left, e.g. a bucket dot.
  final Widget? leading;

  /// Optional content on the right, e.g. an amount.
  final Widget? trailing;

  /// Shows a chevron at the end.
  final bool chevron;

  /// Called on tap.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final muted = context.bk.colors.inkMuted;
    return Semantics(
      button: onTap != null,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BkSpacing.s4,
              vertical: BkSpacing.s2,
            ),
            child: Row(
              children: [
                if (leading case final l?) ...[l, const BkGap(BkSpacing.s3)],
                Expanded(
                  child: RowText(title: title, subtitle: subtitle),
                ),
                // Flexible so a long trailing value (an account name, at a
                // large text size) shares the row instead of overflowing.
                if (trailing case final t?) ...[
                  const BkGap(BkSpacing.s3),
                  Flexible(child: t),
                ],
                if (chevron) ...[
                  const BkGap(BkSpacing.s1),
                  BkIcon(BkIcons.chevronRight, size: 20, color: muted),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
