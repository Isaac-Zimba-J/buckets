import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A multi-line field for a pasted confirmation message: a label with a
/// Paste action on the right, then a 108 tall box in the `reference`
/// (mono) style. [error] turns the border 2px `danger`; the reason is
/// shown by a banner above, so the field itself has no caption.
///
/// ```dart
/// BkSmsField(label: 'Confirmation SMS', pasteLabel: 'Paste',
///     value: text, onChanged: setText, onPaste: pasteFromClipboard)
/// ```
class BkSmsField extends StatefulWidget {
  /// Creates the field; [onPaste] null hides the Paste action.
  const BkSmsField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.pasteLabel,
    this.onPaste,
    this.hint,
    this.error = false,
    super.key,
  });

  /// The label above the field.
  final String label;

  /// The current text; the field follows it when it changes from outside
  /// (e.g. after a paste).
  final String value;

  /// Called on every edit.
  final ValueChanged<String> onChanged;

  /// The Paste action's text.
  final String? pasteLabel;

  /// Reads the clipboard; the app sets [value] with what it got.
  final VoidCallback? onPaste;

  /// Placeholder text.
  final String? hint;

  /// Whether the message failed a check.
  final bool error;

  @override
  State<BkSmsField> createState() => _BkSmsFieldState();
}

class _BkSmsFieldState extends State<BkSmsField> {
  late final _controller = TextEditingController(text: widget.value);

  @override
  void didUpdateWidget(BkSmsField old) {
    super.didUpdateWidget(old);
    if (widget.value != _controller.text) _controller.text = widget.value;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(bk.radius.md),
      borderSide: BorderSide(color: color, width: width),
    );
    final idle = widget.error
        ? border(c.danger, 2)
        : border(c.controlBorder, 1);
    final onPaste = widget.onPaste;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: bk.type.callout.copyWith(
                  color: c.ink,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (onPaste != null)
              _PasteAction(label: widget.pasteLabel ?? '', onTap: onPaste),
          ],
        ),
        const BkGap(BkSpacing.s2),
        SizedBox(
          height: 108,
          child: TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            expands: true,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            textAlignVertical: TextAlignVertical.top,
            style: bk.type.reference.copyWith(color: c.ink),
            cursorColor: c.ink,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: bk.type.reference.copyWith(color: c.inkMuted),
              filled: true,
              fillColor: c.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: BkSpacing.s4,
                vertical: BkSpacing.s3,
              ),
              enabledBorder: idle,
              focusedBorder: widget.error
                  ? border(c.danger, 2)
                  : border(c.ink, 2),
            ),
          ),
        ),
      ],
    );
  }
}

/// "Paste" in `info` with the clipboard icon; 44 tall to stay tappable.
class _PasteAction extends StatelessWidget {
  const _PasteAction({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return Semantics(
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(bk.radius.full),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: BkSpacing.s2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BkIcon(BkIcons.paste, size: 16, color: bk.colors.info),
                const BkGap(BkSpacing.s1),
                Text(
                  label,
                  style: bk.type.callout.copyWith(
                    color: bk.colors.info,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
