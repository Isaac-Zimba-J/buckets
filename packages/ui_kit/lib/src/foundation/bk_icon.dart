import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/widgets.dart';

/// One icon from [BkIcons], coloured like the text beside it.
///
/// Decorative by default; give icon-only buttons a label on the button
/// (`BkIconButton.semanticLabel`), not here.
///
/// ```dart
/// BkIcon(BkIcons.home, filled: true) // active tab
/// ```
class BkIcon extends StatelessWidget {
  /// Draws [icon].
  const BkIcon(
    this.icon, {
    this.size = 24,
    this.color,
    this.filled = false,
    super.key,
  });

  /// Which glyph.
  final BkIcons icon;

  /// Edge length in logical pixels; 24 is the grid, 20 in banners.
  final double size;

  /// Overrides the colour; defaults to the ambient text colour.
  final Color? color;

  /// Fills the glyph too: only for the tab icons (home, goals, plan, me)
  /// on the active tab.
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final resolved =
        color ??
        IconTheme.of(context).color ??
        DefaultTextStyle.of(context).style.color ??
        context.bk.colors.ink;
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _IconPainter(icon, resolved, filled: filled),
        ),
      ),
    );
  }
}

class _IconPainter extends CustomPainter {
  _IconPainter(this.icon, this.color, {required this.filled});

  final BkIcons icon;
  final Color color;
  final bool filled;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 24);
    final paint = Paint()
      ..color = color
      ..isAntiAlias = true
      ..strokeWidth = 1.75
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = icon.path;
    if (filled) canvas.drawPath(path, paint..style = PaintingStyle.fill);
    canvas.drawPath(path, paint..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(_IconPainter old) =>
      old.icon != icon || old.color != color || old.filled != filled;
}
