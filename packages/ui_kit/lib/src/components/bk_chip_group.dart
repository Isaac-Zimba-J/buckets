import 'package:buckets_ui_kit/src/components/bk_chip.dart';
import 'package:buckets_ui_kit/src/foundation/bk_bucket_color.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// One option of a [BkChipGroup].
class BkChipOption<T> {
  /// Creates the option.
  const BkChipOption(this.value, this.label, {this.dot});

  /// What selecting it reports.
  final T value;

  /// The text.
  final String label;

  /// An optional bucket dot.
  final BkBucketColor? dot;
}

/// Single-choice chips that wrap onto new lines.
///
/// ```dart
/// BkChipGroup(
///   options: [BkChipOption(Category.food, 'Food')],
///   selected: category,
///   onChanged: setCategory,
/// )
/// ```
class BkChipGroup<T> extends StatelessWidget {
  /// Creates the group; a null [onChanged] disables every chip.
  const BkChipGroup({
    required this.options,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  /// The options, in order.
  final List<BkChipOption<T>> options;

  /// The selected value, if any.
  final T? selected;

  /// Called with the tapped option's value.
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: BkSpacing.s2,
    children: [
      for (final o in options)
        BkChip(
          label: o.label,
          dot: o.dot,
          selected: o.value == selected,
          onTap: onChanged == null ? null : () => onChanged!(o.value),
        ),
    ],
  );
}
