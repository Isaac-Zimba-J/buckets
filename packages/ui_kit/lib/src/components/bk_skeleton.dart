import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/widgets.dart';

/// A static loading block in the shape of the content it stands for
/// (no shimmer, to save battery).
///
/// ```dart
/// BkSkeleton(width: 120, height: 28)
/// ```
class BkSkeleton extends StatelessWidget {
  /// Creates the block; [radius] defaults to `radius-sm`.
  const BkSkeleton({required this.height, this.width, this.radius, super.key});

  /// Width; null fills the available width.
  final double? width;

  /// Height.
  final double height;

  /// Corner radius.
  final double? radius;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: context.bk.colors.surfaceSunken,
        borderRadius: BorderRadius.circular(radius ?? context.bk.radius.sm),
      ),
    ),
  );
}
