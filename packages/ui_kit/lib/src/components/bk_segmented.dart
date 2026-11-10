import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// One option of a [BkSegmented].
class BkSegment<T> {
  /// Creates the option.
  const BkSegment(this.value, this.label, {this.icon});

  /// What selecting it reports.
  final T value;

  /// The text.
  final String label;

  /// An optional icon before the text.
  final BkIcons? icon;
}

/// A segmented control: `surface-sunken` track, the selected segment on
/// `surface` with `shadow-card` and 600 weight.
///
/// ```dart
/// BkSegmented(
///   options: const [BkSegment(LogTab.cash, 'Cash'),
///       BkSegment(LogTab.paste, 'Paste')],
///   selected: tab,
///   onChanged: setTab,
/// )
/// ```
class BkSegmented<T> extends StatelessWidget {
  /// Creates the control.
  const BkSegmented({
    required this.options,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  /// The options, in order.
  final List<BkSegment<T>> options;

  /// The selected value.
  final T selected;

  /// Called with the tapped option's value.
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    final inner = BorderRadius.circular(bk.radius.md - BkSpacing.s1);
    return Container(
      padding: const EdgeInsets.all(BkSpacing.s1),
      decoration: BoxDecoration(
        color: c.surfaceSunken,
        borderRadius: BorderRadius.circular(bk.radius.md),
      ),
      child: Row(
        children: [
          for (final o in options)
            Expanded(
              child: Semantics(
                button: true,
                selected: o.value == selected,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onChanged(o.value),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 44),
                    decoration: o.value == selected
                        ? BoxDecoration(
                            color: c.surface,
                            borderRadius: inner,
                            boxShadow: bk.shadows.card,
                          )
                        : null,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (o.icon case final i?) ...[
                          BkIcon(i, size: 18, color: c.ink),
                          const BkGap(BkSpacing.s1),
                        ],
                        Flexible(
                          child: Text(
                            o.label,
                            overflow: TextOverflow.ellipsis,
                            style: bk.type.callout.copyWith(
                              color: c.ink,
                              fontWeight: o.value == selected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
