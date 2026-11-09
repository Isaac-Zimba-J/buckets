import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/foundation/bk_tone.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// The outcome of one proof check.
enum BkCheckResult {
  /// Matched.
  passed,

  /// Did not match.
  failed,

  /// Could not be read from the message.
  unknown;

  BkTone get _tone => switch (this) {
    passed => BkTone.positive,
    failed => BkTone.danger,
    unknown => BkTone.neutral,
  };

  BkIcons get _icon => switch (this) {
    passed => BkIcons.check,
    failed => BkIcons.close,
    unknown => BkIcons.info,
  };
}

/// One proof check: an icon in its tone, what was checked, and what the
/// message said.
///
/// ```dart
/// BkProofCheckRow(label: 'Amount', value: 'K 770',
///     result: BkCheckResult.passed)
/// ```
class BkProofCheckRow extends StatelessWidget {
  /// Creates the row.
  const BkProofCheckRow({
    required this.label,
    required this.value,
    required this.result,
    super.key,
  });

  /// What was checked, e.g. "Amount".
  final String label;

  /// What the message said, e.g. "K 770".
  final String value;

  /// The outcome.
  final BkCheckResult result;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final tone = result._tone;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: tone.tint(context),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: BkIcon(
                result._icon,
                size: 16,
                color: tone.foreground(context),
              ),
            ),
          ),
          const BkGap(BkSpacing.s3),
          Expanded(
            child: Text(
              label,
              style: bk.type.body.copyWith(color: bk.colors.ink),
            ),
          ),
          Text(
            value,
            style: bk.type.body.copyWith(
              color: result == BkCheckResult.failed
                  ? bk.colors.danger
                  : bk.colors.inkMuted,
            ),
          ),
        ],
      ),
    );
  }
}
