import 'package:buckets_ui_kit/src/components/bk_button.dart';
import 'package:buckets_ui_kit/src/components/bk_text_field.dart';
import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A confirmation dialog. When [typedConfirmation] is set, the confirm button
/// stays disabled until the user types that exact word (e.g. DELETE for
/// "Delete all data", R-PRIV-4).
///
/// ```dart
/// final yes = await BkConfirmDialog.show(context,
///     title: 'Delete all data', message: '…',
///     confirmLabel: 'Delete', typedConfirmation: 'DELETE', destructive: true);
/// ```
class BkConfirmDialog extends StatefulWidget {
  /// Creates the dialog content.
  const BkConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    this.typedConfirmation,
    this.destructive = false,
    super.key,
  });

  /// The heading.
  final String title;

  /// The explanation.
  final String message;

  /// The confirm button label.
  final String confirmLabel;

  /// When set, the user must type this exactly to enable confirm.
  final String? typedConfirmation;

  /// Draws confirm as destructive.
  final bool destructive;

  /// Shows the dialog; resolves to true when confirmed, false otherwise.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    String? typedConfirmation,
    bool destructive = false,
  }) async =>
      await showDialog<bool>(
        context: context,
        builder: (_) => BkConfirmDialog(
          title: title,
          message: message,
          confirmLabel: confirmLabel,
          typedConfirmation: typedConfirmation,
          destructive: destructive,
        ),
      ) ??
      false;

  @override
  State<BkConfirmDialog> createState() => _BkConfirmDialogState();
}

class _BkConfirmDialogState extends State<BkConfirmDialog> {
  String _typed = '';

  bool get _canConfirm =>
      widget.typedConfirmation == null ||
      _typed.trim() == widget.typedConfirmation;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    void confirm() => Navigator.of(context).pop(true);
    return Dialog(
      backgroundColor: bk.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(bk.radius.lg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(BkSpacing.s5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              style: bk.type.title2.copyWith(color: bk.colors.ink),
            ),
            const BkGap(BkSpacing.s2),
            Text(
              widget.message,
              style: bk.type.body.copyWith(color: bk.colors.inkMuted),
            ),
            if (widget.typedConfirmation case final word?) ...[
              const BkGap(BkSpacing.s4),
              BkTextField(
                label: 'Type $word to confirm',
                value: _typed,
                onChanged: (v) => setState(() => _typed = v),
              ),
            ],
            const BkGap(BkSpacing.s5),
            if (widget.destructive)
              BkButton.destructive(
                label: widget.confirmLabel,
                onPressed: _canConfirm ? confirm : null,
              )
            else
              BkButton.primary(
                label: widget.confirmLabel,
                onPressed: _canConfirm ? confirm : null,
              ),
            const BkGap(BkSpacing.s2),
            BkButton.text(
              label: 'Cancel',
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    );
  }
}
