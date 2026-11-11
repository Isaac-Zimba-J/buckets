import 'package:buckets_ui_kit/src/components/row_text.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A compact settings row (52 min height): an optional leading icon, a
/// title and caption, an optional value, and a chevron. Used by Settings,
/// Security, Data & privacy and About.
///
/// ```dart
/// BkSettingsRow(title: 'Security', value: 'Lock on',
///     leadingIcon: BkIcons.lock, onTap: openSecurity)
/// ```
class BkSettingsRow extends StatelessWidget {
  /// Creates the row.
  const BkSettingsRow({
    required this.title,
    this.subtitle,
    this.value,
    this.leadingIcon,
    this.onTap,
    this.destructive = false,
    super.key,
  });

  /// The main line.
  final String title;

  /// The muted second line.
  final String? subtitle;

  /// Optional value shown at the end, before the chevron.
  final String? value;

  /// Optional icon in a tinted square on the left.
  final BkIcons? leadingIcon;

  /// Called on tap; a chevron shows when set.
  final VoidCallback? onTap;

  /// Draws the title in `danger` (e.g. Delete all data).
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return Semantics(
      button: onTap != null,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 52),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BkSpacing.s4,
              vertical: BkSpacing.s2,
            ),
            child: Row(
              children: [
                if (leadingIcon case final icon?) ...[
                  Container(
                    width: 36,
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: bk.colors.surfaceSunken,
                      borderRadius: BorderRadius.circular(bk.radius.sm),
                    ),
                    child: BkIcon(icon, size: 20, color: bk.colors.ink),
                  ),
                  const BkGap(BkSpacing.s3),
                ],
                Expanded(
                  child: destructive
                      ? Text(
                          title,
                          style: bk.type.headline.copyWith(
                            color: bk.colors.danger,
                          ),
                        )
                      : RowText(title: title, subtitle: subtitle),
                ),
                if (value case final v?) ...[
                  const BkGap(BkSpacing.s2),
                  Text(
                    v,
                    style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
                  ),
                ],
                if (onTap != null) ...[
                  const BkGap(BkSpacing.s1),
                  BkIcon(
                    BkIcons.chevronRight,
                    size: 20,
                    color: bk.colors.inkMuted,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
