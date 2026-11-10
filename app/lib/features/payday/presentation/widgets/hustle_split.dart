import 'package:buckets/features/setup/presentation/controllers/setup_view_models.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// "Is this side hustle money?": one choice per side hustle plus
/// "Something else", then the chosen hustle's split (screen 17).
class HustleSplit extends StatelessWidget {
  /// Creates the picker; a [selected] of null is "Something else".
  const HustleSplit({
    required this.hustles,
    required this.selected,
    required this.onSelected,
    required this.shares,
    super.key,
  });

  /// Side hustles as (id, name).
  final List<(String, String)> hustles;

  /// The chosen hustle's ID.
  final String? selected;

  /// Called with a hustle's ID, or null for "Something else".
  final ValueChanged<String?> onSelected;

  /// The chosen hustle's split of this money.
  final List<AllocationVm> shares;

  static const _other = '';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkHeading(
          child: Text(
            l.incomeAskHustle,
            style: bk.type.headline.copyWith(color: bk.colors.ink),
          ),
        ),
        const BkGap(BkSpacing.s2),
        BkSegmented<String>(
          options: [
            for (final (id, name) in hustles) BkSegment(id, name),
            BkSegment(_other, l.incomeSomethingElse),
          ],
          selected: selected ?? _other,
          onChanged: (v) => onSelected(v == _other ? null : v),
        ),
        if (selected != null && shares.isNotEmpty) ...[
          const BkGap(BkSpacing.s5),
          Text(
            l.incomeItsSplit.toUpperCase(),
            style: bk.type.overline.copyWith(color: bk.colors.inkMuted),
          ),
          const BkGap(BkSpacing.s2),
          BkSplitBar(
            segments: [for (final r in shares) (r.color.bk, r.basisPoints)],
          ),
          const BkGap(BkSpacing.s3),
          BkListGroup(
            children: [
              for (final r in shares)
                BkListRow(
                  leading: BkBucketDot(color: r.color.bk),
                  title: r.name,
                  trailing: Text(
                    l.incomeShare(
                      percent(r.basisPoints),
                      r.share == null ? '' : money(r.share!),
                    ),
                    style: bk.type.amountM.copyWith(color: bk.colors.ink),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
