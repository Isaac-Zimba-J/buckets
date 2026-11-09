import 'package:flutter/widgets.dart';

/// Empty space of one spacing token, in both directions, so it works in a
/// `Row` or a `Column`.
///
/// ```dart
/// Column(children: [title, const BkGap(BkSpacing.s4), body])
/// ```
class BkGap extends StatelessWidget {
  /// Creates a gap of [size]; pass a `BkSpacing` token.
  const BkGap(this.size, {super.key});

  /// The gap in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox.square(dimension: size);
}
