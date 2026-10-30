import 'package:buckets_core/src/money/money.dart';

/// Formats [Money] for display as defined in `docs/design/WRITING.md`.
abstract final class MoneyFormatter {
  static const _nbsp = ' ';
  static const _minus = '−';

  /// Formats [amount] as `K 1,540`, `−K 320` or, with [showNgwee],
  /// `K 412.50`.
  ///
  /// Whole kwacha round half up on the magnitude: K 412.50 → `K 413`.
  /// Negative amounts always get a true minus; [signed] also puts `+` on
  /// positive amounts (money in). An amount that shows as zero gets no sign.
  static String format(
    Money amount, {
    bool showNgwee = false,
    bool signed = false,
  }) {
    final ngwee = amount.ngwee.abs();
    final String body;
    final bool shownIsZero;
    if (showNgwee) {
      final cents = (ngwee % 100).toString().padLeft(2, '0');
      body = '${_group(ngwee ~/ 100)}.$cents';
      shownIsZero = ngwee == 0;
    } else {
      final kwacha = (ngwee + 50) ~/ 100;
      body = _group(kwacha);
      shownIsZero = kwacha == 0;
    }
    final sign = shownIsZero
        ? ''
        : amount.isNegative
        ? _minus
        : signed
        ? '+'
        : '';
    return '${sign}K$_nbsp$body';
  }

  static String _group(int value) {
    final digits = value.toString();
    final out = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) out.write(',');
      out.write(digits[i]);
    }
    return out.toString();
  }
}
