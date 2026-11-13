import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// The payday alarm hero (screen 13): what is left to move, of the total,
/// and how far along it is.
class PaydayHero extends StatelessWidget {
  /// Creates the hero.
  const PaydayHero({
    required this.left,
    required this.total,
    this.fees = Money.zero,
    super.key,
  });

  /// Still to move, including anything owed.
  final Money left;

  /// All transfers together.
  final Money total;

  /// The estimated transfer fees, taken from Living (R-FEE-5); K 0 hides
  /// the line.
  final Money fees;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final c = bk.colors;
    final moved = total.isPositive
        ? ((total - left).ngwee / total.ngwee).clamp(0.0, 1.0)
        : 0.0;
    return BkHeroCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              BkIcon(BkIcons.clock, size: 20, color: c.accent),
              const BkGap(BkSpacing.s2),
              Expanded(
                child: Text(
                  l.paydayAlarmRepeats,
                  style: bk.type.callout.copyWith(color: c.onHeroMuted),
                ),
              ),
            ],
          ),
          const BkGap(BkSpacing.s3),
          BkHeading(
            child: Text(
              l.paydayHeadline,
              style: bk.type.title1.copyWith(color: c.onHero),
            ),
          ),
          const BkGap(BkSpacing.s3),
          // Wraps at large text sizes instead of overflowing.
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            spacing: BkSpacing.s2,
            children: [
              BkMoneyText(
                ngwee: left.ngwee,
                size: BkAmountSize.xl,
                color: c.accent,
              ),
              Text(
                l.paydayLeftOf(money(total)),
                style: bk.type.callout.copyWith(color: c.onHeroMuted),
              ),
            ],
          ),
          const BkGap(BkSpacing.s3),
          BkProgressBar(value: moved, onHero: true),
          if (fees.isPositive) ...[
            const BkGap(BkSpacing.s3),
            Text(
              l.paydayFeesNote(money(fees)),
              style: bk.type.caption.copyWith(color: c.onHeroMuted),
            ),
          ],
        ],
      ),
    );
  }
}
