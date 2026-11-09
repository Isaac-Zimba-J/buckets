import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/foundation/bk_semantics.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/material.dart';

/// Where a [BkIconButton] sits.
enum BkIconButtonVariant {
  /// On `bg` or a card: `surface` fill with `shadow-card`.
  surface,

  /// On the hero card: a light wash of `on-hero`.
  onHero,

  /// On other dark fills (toasts, sheets over the scrim).
  onDark,
}

/// A 44 × 44 round icon-only button: back, close, notifications.
///
/// ```dart
/// BkIconButton(
///   icon: BkIcons.back,
///   semanticLabel: 'Back',
///   onPressed: () => context.pop(),
/// )
/// ```
class BkIconButton extends StatelessWidget {
  /// Creates the button; [semanticLabel] is what screen readers say.
  const BkIconButton({
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
    this.variant = BkIconButtonVariant.surface,
    super.key,
  });

  /// The glyph.
  final BkIcons icon;

  /// The accessible name, e.g. "Back".
  final String semanticLabel;

  /// Called on tap; null disables the button.
  final VoidCallback? onPressed;

  /// The background it sits on.
  final BkIconButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    final enabled = onPressed != null;
    final onSurface = variant == BkIconButtonVariant.surface;
    final fill = !enabled
        ? c.surfaceSunken
        : onSurface
        ? c.surface
        : c.onHero.withValues(alpha: 0.14);
    final ink = !enabled
        ? c.inkMuted
        : onSurface
        ? c.ink
        : c.onHero;
    return Semantics(
      button: true,
      enabled: enabled,
      label: semanticLabel,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: enabled && onSurface ? bk.shadows.card : null,
        ),
        child: Material(
          color: fill,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: SizedBox.square(
              dimension: bkMinTapTarget,
              child: Center(child: BkIcon(icon, size: 22, color: ink)),
            ),
          ),
        ),
      ),
    );
  }
}
