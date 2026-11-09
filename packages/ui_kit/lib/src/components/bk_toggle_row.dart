import 'package:buckets_ui_kit/src/components/row_text.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A list row with a switch. Disabled when [onChanged] is null.
///
/// ```dart
/// BkToggleRow(title: 'App lock', value: locked, onChanged: setLocked)
/// ```
class BkToggleRow extends StatelessWidget {
  /// Creates the row.
  const BkToggleRow({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    this.leadingIcon,
    super.key,
  });

  /// The main line.
  final String title;

  /// The muted second line.
  final String? subtitle;

  /// Whether the switch is on.
  final bool value;

  /// Called with the new value; null disables the row.
  final ValueChanged<bool>? onChanged;

  /// An optional icon on the left.
  final BkIcons? leadingIcon;

  @override
  Widget build(BuildContext context) {
    final c = context.bk.colors;
    return MergeSemantics(
      child: InkWell(
        onTap: onChanged == null ? null : () => onChanged!(!value),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BkSpacing.s4,
              vertical: BkSpacing.s2,
            ),
            child: Row(
              children: [
                if (leadingIcon case final i?) ...[
                  BkIcon(i, color: c.ink),
                  const BkGap(BkSpacing.s3),
                ],
                Expanded(
                  child: RowText(title: title, subtitle: subtitle),
                ),
                const BkGap(BkSpacing.s3),
                Switch(
                  value: value,
                  onChanged: onChanged,
                  activeThumbColor: c.onAction,
                  activeTrackColor: c.action,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
