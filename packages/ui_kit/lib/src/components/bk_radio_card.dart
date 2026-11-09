import 'package:buckets_ui_kit/src/components/row_text.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A card choice in a single-choice list; the selected one gets a 2px
/// `ink` border and a filled radio.
///
/// ```dart
/// BkRadioCard(title: 'Hold until month end', selected: hold,
///     onTap: pickHold)
/// ```
class BkRadioCard extends StatelessWidget {
  /// Creates the card.
  const BkRadioCard({
    required this.title,
    required this.selected,
    required this.onTap,
    this.subtitle,
    super.key,
  });

  /// The main line.
  final String title;

  /// The muted second line.
  final String? subtitle;

  /// Whether it is the chosen one.
  final bool selected;

  /// Called on tap.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    final radius = BorderRadius.circular(bk.radius.lg);
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      child: Material(
        color: c.surface,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: selected
              ? BorderSide(color: c.ink, width: 2)
              : BorderSide(color: c.controlBorder),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: const EdgeInsets.all(BkSpacing.s4),
            child: Row(
              children: [
                Expanded(
                  child: RowText(title: title, subtitle: subtitle),
                ),
                const BkGap(BkSpacing.s3),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected ? c.ink : c.controlBorder,
                      width: selected ? 7 : 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
