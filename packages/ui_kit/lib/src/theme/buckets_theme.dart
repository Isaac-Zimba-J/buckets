import 'package:buckets_ui_kit/src/theme/bk_theme_extensions.dart';
import 'package:buckets_ui_kit/src/tokens/bk_colors.g.dart';
import 'package:flutter/material.dart';

/// Builds the light and dark Material themes for Buckets.
abstract final class BucketsTheme {
  /// Light Buckets theme.
  static final ThemeData light = _build(Brightness.light, BkColors.light);

  /// Dark Buckets theme.
  static final ThemeData dark = _build(Brightness.dark, BkColors.dark);

  static ThemeData _build(Brightness brightness, BkColors colors) => ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: colors.bg,
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: _BkPageTransitionsBuilder(),
        TargetPlatform.iOS: _BkPageTransitionsBuilder(),
      },
    ),
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: colors.action,
          brightness: brightness,
        ).copyWith(
          primary: colors.action,
          onPrimary: colors.onAction,
          secondary: colors.accent,
          onSecondary: colors.onAccent,
          surface: colors.surface,
          onSurface: colors.ink,
          error: colors.danger,
        ),
    extensions: <ThemeExtension<dynamic>>[
      colors,
      BkTypeStyles.standard,
      BkSpacingScale.standard,
      BkRadiusScale.standard,
      BkShadowSet.standard,
    ],
  );
}

/// Fade + 3% upward-slide transition used for every screen push/pop.
class _BkPageTransitionsBuilder extends PageTransitionsBuilder {
  const _BkPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curve = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
    return FadeTransition(
      opacity: curve,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.03),
          end: Offset.zero,
        ).animate(curve),
        child: child,
      ),
    );
  }
}
