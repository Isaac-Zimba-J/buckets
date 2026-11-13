import 'package:buckets_ui_kit/src/components/bk_progress_bar.dart';
import 'package:buckets_ui_kit/src/foundation/bk_bucket_color.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// A labelled bar for one provider on the Fees page: a colour dot, the name
/// and amount on one line, and the bar below.
///
/// ```dart
/// BkProviderBar(label: 'MTN MoMo', amountText: 'K 52', fraction: 0.6,
///     color: BkBucketColor.fun)
/// ```
class BkProviderBar extends StatelessWidget {
  /// Creates the bar; [fraction] is 0–1 of the largest provider.
  const BkProviderBar({
    required this.label,
    required this.amountText,
    required this.fraction,
    required this.color,
    super.key,
  });

  /// The provider's name.
  final String label;

  /// The formatted total.
  final String amountText;

  /// How long the bar is, 0–1.
  final double fraction;

  /// The dot and bar colour.
  final BkBucketColor color;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return Semantics(
      label: '$label, $amountText',
      excludeSemantics: true,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.resolve(context),
                ),
              ),
              const BkGap(BkSpacing.s2),
              Expanded(
                child: Text(
                  label,
                  style: bk.type.headline.copyWith(color: bk.colors.ink),
                ),
              ),
              Text(
                amountText,
                style: bk.type.headline.copyWith(color: bk.colors.ink),
              ),
            ],
          ),
          const BkGap(BkSpacing.s2),
          BkProgressBar(value: fraction, color: color),
        ],
      ),
    );
  }
}
