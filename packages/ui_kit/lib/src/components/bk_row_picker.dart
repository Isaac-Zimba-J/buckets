import 'package:buckets_ui_kit/src/foundation/bk_bucket_color.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A list row that opens a picker: label left, value right, chevron.
///
/// ```dart
/// BkRowPicker(label: 'Bucket', value: 'Living',
///     dot: BkBucketColor.living, onTap: pickBucket)
/// ```
class BkRowPicker extends StatelessWidget {
  /// Creates the row.
  const BkRowPicker({
    required this.label,
    required this.value,
    required this.onTap,
    this.dot,
    super.key,
  });

  /// What is being picked.
  final String label;

  /// The current choice.
  final String value;

  /// Opens the picker.
  final VoidCallback onTap;

  /// An optional bucket dot before the value.
  final BkBucketColor? dot;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: BkSpacing.s4),
            child: Row(
              children: [
                Text(label, style: bk.type.headline.copyWith(color: c.ink)),
                const BkGap(BkSpacing.s3),
                const Spacer(),
                if (dot case final d?) ...[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: d.resolve(context),
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox.square(dimension: 10),
                  ),
                  const BkGap(BkSpacing.s2),
                ],
                Flexible(
                  flex: 3,
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: bk.type.body.copyWith(color: c.inkMuted),
                  ),
                ),
                const BkGap(BkSpacing.s1),
                BkIcon(BkIcons.chevronRight, size: 20, color: c.inkMuted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
