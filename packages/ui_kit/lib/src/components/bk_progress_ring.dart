import 'dart:math' as math;

import 'package:buckets_ui_kit/src/foundation/bk_bucket_color.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/widgets.dart';

/// A ring that fills clockwise from the top, with a label in the middle
/// (a wish's cooling-off timer, a goal).
///
/// ```dart
/// BkProgressRing(value: 0.25, centerLabel: '36h', color: BkBucketColor.fun)
/// ```
class BkProgressRing extends StatelessWidget {
  /// Creates the ring; [value] is clamped to 0–1.
  const BkProgressRing({
    required this.value,
    required this.centerLabel,
    this.color,
    this.size = 64,
    super.key,
  });

  /// How full, 0–1.
  final double value;

  /// Short text in the middle.
  final String centerLabel;

  /// The fill colour.
  final BkBucketColor? color;

  /// Diameter.
  final double size;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final v = value.clamp(0.0, 1.0);
    return Semantics(
      value: '${(v * 100).round()}%',
      label: centerLabel,
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _RingPainter(
            v,
            color?.resolve(context) ?? bk.colors.action,
            bk.colors.surfaceSunken,
          ),
          child: Center(
            child: Text(
              centerLabel,
              style: bk.type.caption.copyWith(
                color: bk.colors.ink,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.value, this.fill, this.track);

  final double value;
  final Color fill;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 6.0;
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    final arc = rect.deflate(stroke / 2);
    canvas.drawArc(arc, 0, math.pi * 2, false, paint..color = track);
    if (value > 0) {
      canvas.drawArc(
        arc,
        -math.pi / 2,
        math.pi * 2 * value,
        false,
        paint..color = fill,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.value != value || old.fill != fill || old.track != track;
}
