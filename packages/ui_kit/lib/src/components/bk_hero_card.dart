import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// The one hero card per screen: `hero` fill, `radius-xl`, `space-5`
/// padding. Text and icons inside default to `on-hero`.
///
/// ```dart
/// BkHeroCard(child: BkMoneyText(ngwee: 308000, size: BkAmountSize.xl,
///     color: context.bk.colors.onHero))
/// ```
class BkHeroCard extends StatelessWidget {
  /// Wraps [child].
  const BkHeroCard({required this.child, super.key});

  /// The content.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final onHero = bk.colors.onHero;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bk.colors.hero,
        borderRadius: BorderRadius.circular(bk.radius.xl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(BkSpacing.s5),
        child: IconTheme.merge(
          data: IconThemeData(color: onHero),
          child: DefaultTextStyle.merge(
            style: bk.type.body.copyWith(color: onHero),
            child: child,
          ),
        ),
      ),
    );
  }
}
