import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/material.dart';

/// The floating "log a payment" button: 60 × 60, `action` fill, plus icon.
/// Home only, bottom-right above the tab bar.
///
/// ```dart
/// BkFab(semanticLabel: 'Log a payment', onPressed: openLog)
/// ```
class BkFab extends StatelessWidget {
  /// Creates the button; [semanticLabel] is what screen readers say.
  const BkFab({
    required this.semanticLabel,
    required this.onPressed,
    super.key,
  });

  /// The accessible name.
  final String semanticLabel;

  /// Called on tap.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return Semantics(
      button: true,
      label: semanticLabel,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: bk.shadows.float,
        ),
        child: Material(
          color: bk.colors.action,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: SizedBox.square(
              dimension: 60,
              child: Center(
                child: BkIcon(
                  BkIcons.plus,
                  size: 28,
                  color: bk.colors.onAction,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
