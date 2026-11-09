import 'package:buckets_ui_kit/src/foundation/bk_tone.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// A 24-tall tinted pill: "Proven", "Needs proof", "Over".
///
/// ```dart
/// BkBadge(label: 'Proven', tone: BkTone.positive)
/// ```
class BkBadge extends StatelessWidget {
  /// Creates the badge.
  const BkBadge({required this.label, required this.tone, super.key});

  /// The text.
  final String label;

  /// Its meaning and colours.
  final BkTone tone;

  @override
  Widget build(BuildContext context) => Container(
    height: 24,
    padding: const EdgeInsets.symmetric(horizontal: BkSpacing.s2),
    decoration: BoxDecoration(
      color: tone.tint(context),
      borderRadius: BorderRadius.circular(context.bk.radius.full),
    ),
    child: Center(
      widthFactor: 1,
      child: Text(
        label,
        style: context.bk.type.caption.copyWith(
          color: tone.foreground(context),
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
