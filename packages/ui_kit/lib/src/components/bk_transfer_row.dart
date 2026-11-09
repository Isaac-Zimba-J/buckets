import 'package:buckets_ui_kit/src/components/bk_badge.dart';
import 'package:buckets_ui_kit/src/components/bk_bucket_dot.dart';
import 'package:buckets_ui_kit/src/components/row_text.dart';
import 'package:buckets_ui_kit/src/foundation/bk_bucket_color.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_tone.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// Where a payday transfer stands.
enum BkTransferStatus {
  /// Not moved yet.
  pending,

  /// Proven by a message.
  proven,

  /// Part arrived; the rest is owed.
  partial,

  /// Marked as saved without proof.
  selfReported;

  BkTone get _tone => switch (this) {
    pending || partial => BkTone.warning,
    proven => BkTone.positive,
    selfReported => BkTone.neutral,
  };
}

/// One row of the payday checklist: bucket, destination, amount and a
/// status badge; tapping a row that still needs proof opens the proof.
///
/// ```dart
/// BkTransferRow(bucketLabel: 'Emergency', color: BkBucketColor.emergency,
///     amountText: 'K 770', destination: 'Bank ••4521',
///     status: BkTransferStatus.pending, statusLabel: 'Needs proof',
///     onProve: prove)
/// ```
class BkTransferRow extends StatelessWidget {
  /// Creates the row; [statusLabel] is the badge text from the app.
  const BkTransferRow({
    required this.bucketLabel,
    required this.color,
    required this.amountText,
    required this.destination,
    required this.status,
    required this.statusLabel,
    this.onProve,
    super.key,
  });

  /// The bucket name.
  final String bucketLabel;

  /// The bucket colour.
  final BkBucketColor color;

  /// The formatted amount (or what is still owed).
  final String amountText;

  /// Where the money goes.
  final String destination;

  /// Where it stands; sets the badge colour.
  final BkTransferStatus status;

  /// The badge text.
  final String statusLabel;

  /// Opens the proof screen; null when nothing is left to prove.
  final VoidCallback? onProve;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return Semantics(
      button: onProve != null,
      child: InkWell(
        onTap: onProve,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BkSpacing.s4,
              vertical: BkSpacing.s3,
            ),
            child: Row(
              children: [
                BkBucketDot(color: color),
                const BkGap(BkSpacing.s3),
                Expanded(
                  child: RowText(title: bucketLabel, subtitle: destination),
                ),
                const BkGap(BkSpacing.s3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      amountText,
                      style: bk.type.amountM.copyWith(color: bk.colors.ink),
                    ),
                    const BkGap(BkSpacing.s1),
                    BkBadge(label: statusLabel, tone: status._tone),
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
