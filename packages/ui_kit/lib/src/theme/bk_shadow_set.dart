import 'package:buckets_ui_kit/src/tokens/bk_shadows.g.dart';
import 'package:flutter/material.dart';

/// Elevation shadows supplied by the active Buckets theme.
class BkShadowSet extends ThemeExtension<BkShadowSet> {
  /// Creates the shadow set.
  const BkShadowSet({
    required this.card,
    required this.sheet,
    required this.float,
  });

  /// The standard Buckets shadows.
  static const standard = BkShadowSet(
    card: BkShadows.card,
    sheet: BkShadows.sheet,
    float: BkShadows.float,
  );

  /// Surface-card shadows.
  final List<BoxShadow> card;

  /// Bottom-sheet shadows.
  final List<BoxShadow> sheet;

  /// Floating action and toast shadows.
  final List<BoxShadow> float;

  @override
  BkShadowSet copyWith({
    List<BoxShadow>? card,
    List<BoxShadow>? sheet,
    List<BoxShadow>? float,
  }) => BkShadowSet(
    card: card ?? this.card,
    sheet: sheet ?? this.sheet,
    float: float ?? this.float,
  );

  @override
  BkShadowSet lerp(BkShadowSet? other, double t) {
    if (other == null) return this;
    return BkShadowSet(
      card: BoxShadow.lerpList(card, other.card, t) ?? card,
      sheet: BoxShadow.lerpList(sheet, other.sheet, t) ?? sheet,
      float: BoxShadow.lerpList(float, other.float, t) ?? float,
    );
  }
}
