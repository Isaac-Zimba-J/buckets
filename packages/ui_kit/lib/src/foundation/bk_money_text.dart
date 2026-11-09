import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/widgets.dart';

/// The three amount sizes from the type scale.
enum BkAmountSize {
  /// amount-xl: the one most important number on a screen.
  xl,

  /// amount-l: card balances.
  l,

  /// amount-m: row amounts.
  m,
}

/// An amount of money in ngwee, formatted by [MoneyFormatter] with
/// tabular figures.
///
/// ```dart
/// BkMoneyText(ngwee: 154000) // K 1,540
/// BkMoneyText(ngwee: 41250, showNgwee: true) // K 412.50
/// ```
class BkMoneyText extends StatelessWidget {
  /// Creates the text for [ngwee].
  const BkMoneyText({
    required this.ngwee,
    this.size = BkAmountSize.m,
    this.showSign = false,
    this.showNgwee = false,
    this.color,
    super.key,
  });

  /// The amount in ngwee (K 1 = 100 ngwee).
  final int ngwee;

  /// Which amount style to use.
  final BkAmountSize size;

  /// Puts `+` on positive amounts (money in); negatives always get `−`.
  final bool showSign;

  /// Shows ngwee (`K 412.50`) instead of rounding to whole kwacha.
  final bool showNgwee;

  /// Overrides the text colour; defaults to `ink`.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final style = switch (size) {
      BkAmountSize.xl => bk.type.amountXl,
      BkAmountSize.l => bk.type.amountL,
      BkAmountSize.m => bk.type.amountM,
    };
    return Text(
      MoneyFormatter.format(
        Money(ngwee),
        showNgwee: showNgwee,
        signed: showSign,
      ),
      style: style.copyWith(color: color ?? bk.colors.ink),
      maxLines: 1,
      softWrap: false,
    );
  }
}
