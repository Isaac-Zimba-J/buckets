import 'package:buckets_ui_kit/src/components/bk_bucket_dot.dart';
import 'package:buckets_ui_kit/src/components/bk_progress_bar.dart';
import 'package:buckets_ui_kit/src/foundation/bk_bucket_color.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A bucket on Home: surface card with dot and name, the balance, an
/// optional 6px progress bar and caption.
///
/// ```dart
/// BkBucketTile(label: 'Living', color: BkBucketColor.living,
///     amountText: 'K 3,080', progress: 0.6, onTap: open)
/// ```
class BkBucketTile extends StatelessWidget {
  /// Creates the tile; [amountText] comes from `MoneyFormatter`.
  const BkBucketTile({
    required this.label,
    required this.color,
    required this.amountText,
    this.progress,
    this.caption,
    this.onTap,
    super.key,
  });

  /// The bucket name.
  final String label;

  /// The bucket colour.
  final BkBucketColor color;

  /// The formatted balance.
  final String amountText;

  /// Optional progress 0–1.
  final double? progress;

  /// Optional muted line at the bottom.
  final String? caption;

  /// Opens the bucket.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    final radius = BorderRadius.circular(bk.radius.lg);
    return Semantics(
      button: onTap != null,
      label: '$label, $amountText',
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: bk.shadows.card,
        ),
        child: Material(
          color: c.surface,
          borderRadius: radius,
          child: InkWell(
            onTap: onTap,
            borderRadius: radius,
            child: Padding(
              padding: const EdgeInsets.all(BkSpacing.s3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      BkBucketDot(color: color),
                      const BkGap(BkSpacing.s2),
                      Expanded(
                        child: Text(
                          label,
                          overflow: TextOverflow.ellipsis,
                          style: bk.type.caption.copyWith(color: c.inkMuted),
                        ),
                      ),
                    ],
                  ),
                  const BkGap(BkSpacing.s1),
                  Text(
                    amountText,
                    maxLines: 1,
                    style: bk.type.amountM.copyWith(color: c.ink),
                  ),
                  if (progress case final p?) ...[
                    const BkGap(BkSpacing.s2),
                    BkProgressBar(value: p, color: color, height: 6),
                  ],
                  if (caption case final t?) ...[
                    const BkGap(BkSpacing.s1),
                    Text(t, style: bk.type.caption.copyWith(color: c.inkMuted)),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
