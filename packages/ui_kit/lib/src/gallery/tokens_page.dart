import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// Gallery page: every colour, type style, spacing, radius and shadow.
class TokensPage extends StatelessWidget {
  /// Creates the page.
  const TokensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.bk;
    final colors = tokens.colors;
    return ColoredBox(
      color: colors.bg,
      child: Padding(
        padding: EdgeInsets.all(tokens.spacing.s5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('BUCKETS · UI KIT', style: tokens.type.overline),
            SizedBox(height: tokens.spacing.s2),
            Text(
              'Design tokens',
              style: tokens.type.title1.copyWith(color: colors.ink),
            ),
            SizedBox(height: tokens.spacing.s6),
            Text('Color', style: tokens.type.title2),
            SizedBox(height: tokens.spacing.s3),
            Wrap(
              spacing: tokens.spacing.s2,
              runSpacing: tokens.spacing.s2,
              children: [
                _Swatch('Background', colors.bg, tokens),
                _Swatch('Surface', colors.surface, tokens),
                _Swatch('Action', colors.action, tokens),
                _Swatch('Positive', colors.positive, tokens),
                _Swatch('Living', colors.bucketLiving, tokens),
                _Swatch('Guilt-free', colors.bucketFun, tokens),
              ],
            ),
            SizedBox(height: tokens.spacing.s6),
            Text('Type', style: tokens.type.title2),
            SizedBox(height: tokens.spacing.s2),
            Text(
              'Give every kwacha a job',
              style: tokens.type.display.copyWith(color: colors.ink),
            ),
            Text(
              'K 1,540',
              style: tokens.type.amountL.copyWith(color: colors.ink),
            ),
            SizedBox(height: tokens.spacing.s6),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(tokens.spacing.s4),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(tokens.radius.lg),
                boxShadow: tokens.shadows.card,
              ),
              child: Text(
                'Spacing · ${tokens.spacing.s4.toInt()} px     '
                'Radius · ${tokens.radius.lg.toInt()} px',
                style: tokens.type.callout.copyWith(color: colors.ink),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.label, this.color, this.tokens);

  final String label;
  final Color color;
  final BkThemeTokens tokens;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 164,
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(tokens.radius.sm),
          ),
        ),
        SizedBox(width: tokens.spacing.s2),
        Expanded(child: Text(label, style: tokens.type.caption)),
      ],
    ),
  );
}
