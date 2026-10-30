import 'dart:ui';

import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter_test/flutter_test.dart';

// Expected values are copied from docs/design/tokens.json.
void main() {
  group('BkColors', () {
    test('hex tokens per theme', () {
      expect(BkColors.light.bg, const Color(0xFFF3F4F1));
      expect(BkColors.dark.bg, const Color(0xFF0C0E0D));
      expect(BkColors.light.bucketLiving, isNot(BkColors.dark.bucketLiving));
    });

    test('rgba tokens keep their alpha', () {
      // rgba(14,18,16,0.48) → alpha round(0.48 × 255) = 122 = 0x7A
      expect(BkColors.light.scrim, const Color(0x7A0E1210));
      expect(BkColors.dark.scrim, const Color(0x99000000));
    });

    test('copyWith replaces one field only', () {
      const red = Color(0xFFFF0000);
      final copy = BkColors.light.copyWith(ink: red);
      expect(copy.ink, red);
      expect(copy.bg, BkColors.light.bg);
      expect(BkColors.light.copyWith().surface, BkColors.light.surface);
    });

    test('lerp blends between themes', () {
      expect(BkColors.light.lerp(BkColors.dark, 0).bg, BkColors.light.bg);
      expect(BkColors.light.lerp(BkColors.dark, 1).bg, BkColors.dark.bg);
      expect(BkColors.light.lerp(null, 0.5), same(BkColors.light));
    });
  });

  group('BkTypography', () {
    test('line height and letter spacing convert from px and em', () {
      const d = BkTypography.display;
      expect(d.fontFamily, 'Geist');
      expect(d.fontSize! * d.height!, closeTo(40, 1e-9));
      expect(d.letterSpacing, closeTo(-0.03 * 36, 1e-9));
      expect(d.fontWeight, FontWeight.w700);
      expect(BkTypography.title2.fontWeight, const FontWeight(650));
      expect(BkTypography.body.letterSpacing, isNull);
    });

    test('amounts use tabular figures, references use Geist Mono', () {
      expect(BkTypography.amountXl.fontFeatures, [
        const FontFeature.tabularFigures(),
      ]);
      expect(BkTypography.body.fontFeatures, isNull);
      expect(BkTypography.reference.fontFamily, 'Geist Mono');
    });
  });

  test('spacing, radius and shadows', () {
    expect(BkSpacing.s1, 4);
    expect(BkSpacing.s8, 32);
    expect(BkRadius.md, 14);
    expect(BkRadius.full, 999);
    expect(BkShadows.card, hasLength(2));
    expect(BkShadows.sheet.single.offset, const Offset(0, -10));
    expect(BkShadows.float.single.blurRadius, 28);
  });
}
