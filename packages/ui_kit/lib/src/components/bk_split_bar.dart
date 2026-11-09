import 'package:buckets_ui_kit/src/foundation/bk_bucket_color.dart';
import 'package:flutter/widgets.dart';

/// How one income is split: a 12-tall rounded bar of bucket-coloured
/// segments, widths by basis points (10000 = 100%), 3px gaps.
///
/// ```dart
/// BkSplitBar(segments: [(BkBucketColor.living, 4000),
///     (BkBucketColor.fun, 1000)])
/// ```
class BkSplitBar extends StatelessWidget {
  /// Creates the bar.
  const BkSplitBar({required this.segments, this.height = 12, super.key});

  /// Bucket colour and share in basis points, in order.
  final List<(BkBucketColor, int)> segments;

  /// Thickness.
  final double height;

  @override
  Widget build(BuildContext context) {
    final shown = segments.where((s) => s.$2 > 0).toList();
    return ExcludeSemantics(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(height / 2),
        child: SizedBox(
          height: height,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (i, (color, bp)) in shown.indexed) ...[
                if (i > 0) const SizedBox(width: 3),
                Expanded(
                  flex: bp,
                  child: ColoredBox(color: color.resolve(context)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
