import 'package:buckets_ui_kit/src/components/bk_badge.dart';
import 'package:buckets_ui_kit/src/components/row_text.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/foundation/bk_tone.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// Where a bill stands on screen 33.
enum BkBillStatus {
  /// Due later this cycle.
  due,

  /// Due within a few days.
  dueSoon,

  /// Past its due date.
  overdue,

  /// Paid.
  paid;

  BkTone get _tone => switch (this) {
    due => BkTone.neutral,
    dueSoon => BkTone.warning,
    overdue => BkTone.danger,
    paid => BkTone.positive,
  };
}

/// A bill row: a tick circle, the bill, its amount and a status badge.
///
/// ```dart
/// BkBillRow(title: 'ZESCO units', subtitle: 'Due 20 Nov', amountText: 'K 400',
///     status: BkBillStatus.dueSoon, statusLabel: 'Due soon', onTick: pay)
/// ```
class BkBillRow extends StatelessWidget {
  /// Creates the row; [statusLabel] is the badge text.
  const BkBillRow({
    required this.title,
    required this.amountText,
    required this.status,
    required this.statusLabel,
    this.subtitle,
    this.onTick,
    this.onTap,
    super.key,
  });

  /// The bill's name.
  final String title;

  /// The muted second line: due date, or when and how it was paid.
  final String? subtitle;

  /// The formatted amount.
  final String amountText;

  /// Drives the tick and badge colours.
  final BkBillStatus status;

  /// The badge text, e.g. "Due soon".
  final String statusLabel;

  /// Called when the tick is tapped; null for a paid row.
  final VoidCallback? onTick;

  /// Called when the row is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final tone = status._tone;
    final paid = status == BkBillStatus.paid;
    final ring = paid || status == BkBillStatus.due
        ? bk.colors.controlBorder
        : tone.foreground(context);
    return Semantics(
      checked: paid,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 72),
          child: Padding(
            padding: const EdgeInsets.all(BkSpacing.s4),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onTick,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: paid ? bk.colors.positive : null,
                      border: paid ? null : Border.all(color: ring, width: 2),
                    ),
                    child: paid
                        ? BkIcon(
                            BkIcons.check,
                            size: 18,
                            color: bk.colors.surface,
                          )
                        : null,
                  ),
                ),
                const BkGap(BkSpacing.s3),
                Expanded(
                  child: RowText(title: title, subtitle: subtitle),
                ),
                const BkGap(BkSpacing.s3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      amountText,
                      style: bk.type.headline.copyWith(color: bk.colors.ink),
                    ),
                    const BkGap(BkSpacing.s1),
                    BkBadge(label: statusLabel, tone: tone),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
