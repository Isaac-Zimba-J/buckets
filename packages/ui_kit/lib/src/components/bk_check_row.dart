import 'package:buckets_ui_kit/src/components/row_text.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A list row with a checkbox, e.g. a planned buy or a permission.
///
/// ```dart
/// BkCheckRow(title: 'Gas', checked: done, onChanged: toggle,
///     trailing: BkMoneyText(ngwee: 35000))
/// ```
class BkCheckRow extends StatelessWidget {
  /// Creates the row.
  const BkCheckRow({
    required this.title,
    required this.checked,
    required this.onChanged,
    this.subtitle,
    this.trailing,
    super.key,
  });

  /// The main line.
  final String title;

  /// The muted second line.
  final String? subtitle;

  /// Whether it is ticked.
  final bool checked;

  /// Called with the new value; null disables the row.
  final ValueChanged<bool>? onChanged;

  /// Optional content on the right, e.g. an amount.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    return Semantics(
      checked: checked,
      enabled: onChanged != null,
      child: InkWell(
        onTap: onChanged == null ? null : () => onChanged!(!checked),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BkSpacing.s4,
              vertical: BkSpacing.s2,
            ),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: checked ? c.action : c.surface,
                    borderRadius: BorderRadius.circular(bk.radius.sm / 2),
                    border: checked
                        ? null
                        : Border.all(color: c.controlBorder, width: 1.5),
                  ),
                  child: checked
                      ? BkIcon(BkIcons.check, size: 18, color: c.onAction)
                      : null,
                ),
                const BkGap(BkSpacing.s3),
                Expanded(
                  child: RowText(title: title, subtitle: subtitle),
                ),
                if (trailing case final t?) ...[const BkGap(BkSpacing.s3), t],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
