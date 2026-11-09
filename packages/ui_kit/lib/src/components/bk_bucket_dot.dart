import 'package:buckets_ui_kit/src/foundation/bk_bucket_color.dart';
import 'package:flutter/widgets.dart';

/// A round dot in a bucket's colour, left of the bucket name.
///
/// ```dart
/// BkBucketDot(color: BkBucketColor.living)
/// ```
class BkBucketDot extends StatelessWidget {
  /// Creates the dot.
  const BkBucketDot({required this.color, this.size = 10, super.key});

  /// The bucket colour.
  final BkBucketColor color;

  /// Diameter in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: color.resolve(context),
      shape: BoxShape.circle,
    ),
    child: SizedBox.square(dimension: size),
  );
}
