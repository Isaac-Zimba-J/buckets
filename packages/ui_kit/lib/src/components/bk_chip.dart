import 'package:buckets_ui_kit/src/components/bk_bucket_dot.dart';
import 'package:buckets_ui_kit/src/foundation/bk_bucket_color.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_semantics.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A 36-tall pill: `surface` with a border, or `ink` fill when selected.
/// Disabled when [onTap] is null.
///
/// ```dart
/// BkChip(label: 'Food', selected: true, onTap: pickFood)
/// ```
class BkChip extends StatelessWidget {
  /// Creates the chip.
  const BkChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.dot,
    super.key,
  });

  /// The text.
  final String label;

  /// Whether it is chosen.
  final bool selected;

  /// Called on tap; null disables it.
  final VoidCallback? onTap;

  /// An optional bucket dot before the label.
  final BkBucketColor? dot;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    final enabled = onTap != null;
    final ink = selected ? c.bg : (enabled ? c.ink : c.inkMuted);
    return Semantics(
      button: true,
      selected: selected,
      enabled: enabled,
      child: BkTapTarget(
        child: Material(
          color: selected ? c.ink : (enabled ? c.surface : c.surfaceSunken),
          shape: StadiumBorder(
            side: selected
                ? BorderSide.none
                : BorderSide(color: c.controlBorder),
          ),
          child: InkWell(
            onTap: onTap,
            customBorder: const StadiumBorder(),
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: BkSpacing.s4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (dot case final d?) ...[
                    BkBucketDot(color: d),
                    const BkGap(BkSpacing.s2),
                  ],
                  Text(
                    label,
                    style: bk.type.callout.copyWith(
                      color: ink,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
