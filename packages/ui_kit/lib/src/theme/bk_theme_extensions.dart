import 'package:buckets_ui_kit/src/tokens/bk_radius.g.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:buckets_ui_kit/src/tokens/bk_typography.g.dart';
import 'package:flutter/material.dart';

export 'bk_shadow_set.dart';

/// Typography styles supplied by the active Buckets theme.
class BkTypeStyles extends ThemeExtension<BkTypeStyles> {
  /// Creates the typography style set.
  const BkTypeStyles({
    required this.display,
    required this.title1,
    required this.title2,
    required this.headline,
    required this.body,
    required this.callout,
    required this.caption,
    required this.overline,
    required this.amountXl,
    required this.amountL,
    required this.amountM,
    required this.reference,
  });

  /// The standard Buckets typography styles.
  static const standard = BkTypeStyles(
    display: BkTypography.display,
    title1: BkTypography.title1,
    title2: BkTypography.title2,
    headline: BkTypography.headline,
    body: BkTypography.body,
    callout: BkTypography.callout,
    caption: BkTypography.caption,
    overline: BkTypography.overline,
    amountXl: BkTypography.amountXl,
    amountL: BkTypography.amountL,
    amountM: BkTypography.amountM,
    reference: BkTypography.reference,
  );

  /// Welcome and celebration title style.
  final TextStyle display;

  /// Screen title style.
  final TextStyle title1;

  /// Section and sheet title style.
  final TextStyle title2;

  /// Card and row title style.
  final TextStyle headline;

  /// Standard paragraph and input style.
  final TextStyle body;

  /// Button, chip, and banner style.
  final TextStyle callout;

  /// Metadata and helper style.
  final TextStyle caption;

  /// Uppercase group label style.
  final TextStyle overline;

  /// Largest amount style.
  final TextStyle amountXl;

  /// Large amount style.
  final TextStyle amountL;

  /// Row amount style.
  final TextStyle amountM;

  /// Monospaced transaction reference style.
  final TextStyle reference;

  @override
  BkTypeStyles copyWith({
    TextStyle? display,
    TextStyle? title1,
    TextStyle? title2,
    TextStyle? headline,
    TextStyle? body,
    TextStyle? callout,
    TextStyle? caption,
    TextStyle? overline,
    TextStyle? amountXl,
    TextStyle? amountL,
    TextStyle? amountM,
    TextStyle? reference,
  }) => BkTypeStyles(
    display: display ?? this.display,
    title1: title1 ?? this.title1,
    title2: title2 ?? this.title2,
    headline: headline ?? this.headline,
    body: body ?? this.body,
    callout: callout ?? this.callout,
    caption: caption ?? this.caption,
    overline: overline ?? this.overline,
    amountXl: amountXl ?? this.amountXl,
    amountL: amountL ?? this.amountL,
    amountM: amountM ?? this.amountM,
    reference: reference ?? this.reference,
  );

  @override
  BkTypeStyles lerp(BkTypeStyles? other, double t) {
    if (other == null) return this;
    return BkTypeStyles(
      display: TextStyle.lerp(display, other.display, t)!,
      title1: TextStyle.lerp(title1, other.title1, t)!,
      title2: TextStyle.lerp(title2, other.title2, t)!,
      headline: TextStyle.lerp(headline, other.headline, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      callout: TextStyle.lerp(callout, other.callout, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      overline: TextStyle.lerp(overline, other.overline, t)!,
      amountXl: TextStyle.lerp(amountXl, other.amountXl, t)!,
      amountL: TextStyle.lerp(amountL, other.amountL, t)!,
      amountM: TextStyle.lerp(amountM, other.amountM, t)!,
      reference: TextStyle.lerp(reference, other.reference, t)!,
    );
  }
}

/// Spacing scale supplied by the active Buckets theme.
class BkSpacingScale extends ThemeExtension<BkSpacingScale> {
  /// Creates the spacing scale.
  const BkSpacingScale({
    required this.s1,
    required this.s2,
    required this.s3,
    required this.s4,
    required this.s5,
    required this.s6,
    required this.s8,
  });

  /// The standard Buckets spacing scale.
  static const standard = BkSpacingScale(
    s1: BkSpacing.s1,
    s2: BkSpacing.s2,
    s3: BkSpacing.s3,
    s4: BkSpacing.s4,
    s5: BkSpacing.s5,
    s6: BkSpacing.s6,
    s8: BkSpacing.s8,
  );

  /// Four logical pixels.
  final double s1;

  /// Eight logical pixels.
  final double s2;

  /// Twelve logical pixels.
  final double s3;

  /// Sixteen logical pixels.
  final double s4;

  /// Twenty logical pixels.
  final double s5;

  /// Twenty-four logical pixels.
  final double s6;

  /// Thirty-two logical pixels.
  final double s8;

  @override
  BkSpacingScale copyWith({
    double? s1,
    double? s2,
    double? s3,
    double? s4,
    double? s5,
    double? s6,
    double? s8,
  }) => BkSpacingScale(
    s1: s1 ?? this.s1,
    s2: s2 ?? this.s2,
    s3: s3 ?? this.s3,
    s4: s4 ?? this.s4,
    s5: s5 ?? this.s5,
    s6: s6 ?? this.s6,
    s8: s8 ?? this.s8,
  );

  @override
  BkSpacingScale lerp(BkSpacingScale? other, double t) {
    if (other == null) return this;
    double mix(double a, double b) => a + (b - a) * t;
    return BkSpacingScale(
      s1: mix(s1, other.s1),
      s2: mix(s2, other.s2),
      s3: mix(s3, other.s3),
      s4: mix(s4, other.s4),
      s5: mix(s5, other.s5),
      s6: mix(s6, other.s6),
      s8: mix(s8, other.s8),
    );
  }
}

/// Corner radii supplied by the active Buckets theme.
class BkRadiusScale extends ThemeExtension<BkRadiusScale> {
  /// Creates the radius scale.
  const BkRadiusScale({
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.full,
  });

  /// The standard Buckets radius scale.
  static const standard = BkRadiusScale(
    sm: BkRadius.sm,
    md: BkRadius.md,
    lg: BkRadius.lg,
    xl: BkRadius.xl,
    full: BkRadius.full,
  );

  /// Small radius.
  final double sm;

  /// Control radius.
  final double md;

  /// Card radius.
  final double lg;

  /// Hero-card and sheet radius.
  final double xl;

  /// Fully rounded radius.
  final double full;

  @override
  BkRadiusScale copyWith({
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? full,
  }) => BkRadiusScale(
    sm: sm ?? this.sm,
    md: md ?? this.md,
    lg: lg ?? this.lg,
    xl: xl ?? this.xl,
    full: full ?? this.full,
  );

  @override
  BkRadiusScale lerp(BkRadiusScale? other, double t) {
    if (other == null) return this;
    double mix(double a, double b) => a + (b - a) * t;
    return BkRadiusScale(
      sm: mix(sm, other.sm),
      md: mix(md, other.md),
      lg: mix(lg, other.lg),
      xl: mix(xl, other.xl),
      full: mix(full, other.full),
    );
  }
}
