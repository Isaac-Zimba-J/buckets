import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// A surface card: `surface`, `radius-lg`, `shadow-card`, `space-4`
/// padding.
///
/// ```dart
/// BkCard(child: Text('Living'))
/// ```
class BkCard extends StatelessWidget {
  /// Wraps [child].
  const BkCard({
    required this.child,
    this.padding = const EdgeInsets.all(BkSpacing.s4),
    super.key,
  });

  /// The content.
  final Widget child;

  /// Inner padding; pass `EdgeInsets.zero` for edge-to-edge rows.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bk.colors.surface,
        borderRadius: BorderRadius.circular(bk.radius.lg),
        boxShadow: bk.shadows.card,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
