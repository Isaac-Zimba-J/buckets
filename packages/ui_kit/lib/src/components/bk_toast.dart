import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A short confirmation pill: `ink` fill, `bg` text, optional action
/// (usually Undo). Show it with [showBkToast].
class BkToast extends StatelessWidget {
  /// Creates the toast.
  const BkToast({
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  /// What happened.
  final String message;

  /// The action text, e.g. "Undo".
  final String? actionLabel;

  /// Called when the action is tapped.
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final style = bk.type.callout.copyWith(color: bk.colors.bg);
    final label = actionLabel;
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      padding: const EdgeInsets.symmetric(horizontal: BkSpacing.s5),
      decoration: BoxDecoration(
        color: bk.colors.ink,
        borderRadius: BorderRadius.circular(bk.radius.full),
        boxShadow: bk.shadows.float,
      ),
      child: Row(
        children: [
          Expanded(child: Text(message, style: style)),
          if (label != null) ...[
            const BkGap(BkSpacing.s3),
            TextButton(
              onPressed: onAction,
              style: TextButton.styleFrom(
                minimumSize: const Size(44, 44),
                foregroundColor: bk.colors.bg,
              ),
              child: Text(
                label,
                style: style.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Shows a [BkToast] for 3 seconds, 16 px above the bottom action area
/// ([bottomOffset] is that area's height). Screen readers announce it.
///
/// ```dart
/// showBkToast(context, message: 'Saved', actionLabel: 'Undo',
///     onAction: undo)
/// ```
void showBkToast(
  BuildContext context, {
  required String message,
  String? actionLabel,
  VoidCallback? onAction,
  double bottomOffset = 0,
}) {
  final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      content: BkToast(
        message: message,
        actionLabel: actionLabel,
        onAction: onAction == null
            ? null
            : () {
                messenger.hideCurrentSnackBar();
                onAction();
              },
      ),
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.fromLTRB(
        BkSpacing.s4,
        0,
        BkSpacing.s4,
        BkSpacing.s4 + bottomOffset,
      ),
    ),
  );
}
