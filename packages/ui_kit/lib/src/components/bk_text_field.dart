import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A labelled text field: 52 tall, `surface` fill, 1px `control-border`;
/// 2px `ink` when focused, 2px `danger` with a caption on error.
///
/// ```dart
/// BkTextField(label: 'Name', value: name, onChanged: setName,
///     errorText: nameError)
/// ```
class BkTextField extends StatefulWidget {
  /// Creates the field.
  const BkTextField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.hint,
    this.errorText,
    this.keyboardType,
    this.enabled = true,
    super.key,
  });

  /// The label above the field.
  final String label;

  /// The current text; the field follows it when it changes from outside.
  final String value;

  /// Called on every edit.
  final ValueChanged<String> onChanged;

  /// Placeholder text.
  final String? hint;

  /// An error caption below; also turns the border `danger`.
  final String? errorText;

  /// The keyboard to show.
  final TextInputType? keyboardType;

  /// False greys the field out.
  final bool enabled;

  @override
  State<BkTextField> createState() => _BkTextFieldState();
}

class _BkTextFieldState extends State<BkTextField> {
  late final _controller = TextEditingController(text: widget.value);

  @override
  void didUpdateWidget(BkTextField old) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: bk.type.callout.copyWith(
            color: c.ink,
            fontWeight: FontWeight.w600,
          ),
        ),
        const BkGap(BkSpacing.s2),
        TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          keyboardType: widget.keyboardType,
          style: bk.type.body.copyWith(
            color: widget.enabled ? c.ink : c.inkMuted,
          ),
          cursorColor: c.ink,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: bk.type.body.copyWith(color: c.inkMuted),
            errorText: widget.errorText,
            errorStyle: bk.type.caption.copyWith(color: c.danger),
            filled: true,
            fillColor: widget.enabled ? c.surface : c.surfaceSunken,
            constraints: const BoxConstraints(minHeight: 52),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: BkSpacing.s4,
              vertical: BkSpacing.s4,
            ),
            enabledBorder: border(c.controlBorder, 1),
            disabledBorder: border(c.controlBorder, 1),
            focusedBorder: border(c.ink, 2),
            errorBorder: border(c.danger, 2),
            focusedErrorBorder: border(c.danger, 2),
          ),
        ),
      ],
    );
  }
}
