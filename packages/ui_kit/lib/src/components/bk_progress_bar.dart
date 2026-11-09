import 'package:buckets_ui_kit/src/foundation/bk_bucket_color.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/widgets.dart';

/// A horizontal progress bar: `surface-sunken` track filled in the bucket
/// colour; on the hero card, `accent` on a faint `on-hero` track.
///
/// ```dart
/// BkProgressBar(value: 0.4, color: BkBucketColor.goal)
/// ```
class BkProgressBar extends StatelessWidget {
  /// Creates the bar; [value] is clamped to 0–1.
  const BkProgressBar({
    required this.value,
    this.color,
    this.onHero = false,
    this.height = 8,
    super.key,
  });

  /// How full, 0–1.
  final double value;

  /// The fill colour; ignored on the hero card.
  final BkBucketColor? color;

  /// Draws for the dark hero card.
  final bool onHero;

  /// Thickness; 8 by default, 6 inside a bucket tile.
  final double height;

  @override
  Widget build(BuildContext context) {
    final c = context.bk.colors;
    final v = value.clamp(0.0, 1.0);
    final fill = onHero ? c.accent : (color?.resolve(context) ?? c.action);
    final track = onHero ? c.onHero.withValues(alpha: 0.2) : c.surfaceSunken;
    final radius = BorderRadius.circular(height / 2);
    return Semantics(
      value: '${(v * 100).round()}%',
      child: Container(
        height: height,
        decoration: BoxDecoration(color: track, borderRadius: radius),
        alignment: AlignmentDirectional.centerStart,
        child: FractionallySizedBox(
          widthFactor: v,
          heightFactor: 1,
          child: DecoratedBox(
            decoration: BoxDecoration(color: fill, borderRadius: radius),
          ),
        ),
      ),
    );
  }
}
