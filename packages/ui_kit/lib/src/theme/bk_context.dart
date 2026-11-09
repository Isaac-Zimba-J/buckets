import 'package:buckets_ui_kit/src/theme/bk_theme_extensions.dart';
import 'package:buckets_ui_kit/src/tokens/bk_colors.g.dart';
import 'package:flutter/material.dart';

/// The Buckets token extensions active in a [BuildContext].
class BkThemeTokens {
  /// Creates a token accessor from [theme].
  BkThemeTokens(ThemeData theme)
    : colors = _required<BkColors>(theme),
      type = _required<BkTypeStyles>(theme),
      spacing = _required<BkSpacingScale>(theme),
      radius = _required<BkRadiusScale>(theme),
      shadows = _required<BkShadowSet>(theme);

  /// Active color tokens.
  final BkColors colors;

  /// Active typography styles.
  final BkTypeStyles type;

  /// Active spacing values.
  final BkSpacingScale spacing;

  /// Active corner radii.
  final BkRadiusScale radius;

  /// Active elevation shadows.
  final BkShadowSet shadows;

  static T _required<T extends ThemeExtension<T>>(ThemeData theme) {
    final value = theme.extension<T>();
    assert(value != null, 'Use BucketsTheme.light or BucketsTheme.dark.');
    return value!;
  }
}

/// Convenience access to Buckets design tokens from a widget context.
extension BkThemeContext on BuildContext {
  /// Active Buckets design tokens, for example `context.bk.colors.ink`.
  BkThemeTokens get bk => BkThemeTokens(Theme.of(this));
}
