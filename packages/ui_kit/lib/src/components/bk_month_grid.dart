import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/foundation/bk_tone.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// How a month on screen 35 went.
enum BkMonthState {
  /// Paid on time.
  paid,

  /// Paid late.
  late,

  /// Not paid yet.
  due,

  /// Skipped.
  skipped,
}

/// One month tile: its label and a caption such as "K 420 · 18th".
typedef BkMonth = ({String label, BkMonthState state, String caption});

/// A 3-column grid of month tiles (a bill's history).
///
/// ```dart
/// BkMonthGrid(months: [(label: 'Jun', state: BkMonthState.paid,
///     caption: 'K 420 · 18th')])
/// ```
class BkMonthGrid extends StatelessWidget {
  /// Creates the grid.
  const BkMonthGrid({required this.months, super.key});

  /// The tiles, in reading order.
  final List<BkMonth> months;

  static const _columns = 3;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      for (var i = 0; i < months.length; i += _columns) ...[
        if (i > 0) const BkGap(BkSpacing.s2),
        Row(
          children: [
            for (var j = i; j < i + _columns; j++) ...[
              if (j > i) const BkGap(BkSpacing.s2),
              Expanded(
                child: j < months.length
                    ? _Tile(months[j])
                    : const SizedBox.shrink(),
              ),
            ],
          ],
        ),
      ],
    ],
  );
}

class _Tile extends StatelessWidget {
  const _Tile(this.month);

  final BkMonth month;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final (tone, icon) = switch (month.state) {
      BkMonthState.paid => (BkTone.positive, BkIcons.check),
      BkMonthState.late => (BkTone.warning, BkIcons.clock),
      BkMonthState.due => (BkTone.neutral, null),
      BkMonthState.skipped => (BkTone.neutral, null),
    };
    final open = month.state == BkMonthState.due;
    final color = open ? bk.colors.ink : tone.foreground(context);
    return Semantics(
      label: '${month.label}, ${month.caption}',
      excludeSemantics: true,
      child: Container(
        padding: const EdgeInsets.all(BkSpacing.s3),
        decoration: BoxDecoration(
          color: open ? null : tone.tint(context),
          borderRadius: BorderRadius.circular(bk.radius.md),
          border: open ? Border.all(color: bk.colors.controlBorder) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    month.label,
                    style: bk.type.headline.copyWith(color: bk.colors.ink),
                  ),
                ),
                if (icon != null) BkIcon(icon, size: 18, color: color),
              ],
            ),
            const BkGap(BkSpacing.s1),
            Text(month.caption, style: bk.type.caption.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
