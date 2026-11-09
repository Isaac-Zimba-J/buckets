import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Kwacha typed as `1540` or `1540.5` → ngwee; null when empty.
int? bkParseKwacha(String text) {
  final match = RegExp(r'^(\d+)(?:\.(\d{0,2}))?$').firstMatch(text);
  if (match == null) return null;
  final cents = (match[2] ?? '').padRight(2, '0');
  return int.parse(match[1]!) * 100 + int.parse(cents);
}

/// The big centred amount input: amount-xl, no border, with a caption
/// below showing its effect ("Living after: K 1,955") or an error.
///
/// ```dart
/// BkAmountField(ngwee: amount, onChanged: setAmount,
///     effectCaption: 'Living after: K 1,955')
/// ```
class BkAmountField extends StatefulWidget {
  /// Creates the field.
  const BkAmountField({
    required this.ngwee,
    required this.onChanged,
    this.effectCaption,
    this.errorText,
    this.autofocus = false,
    super.key,
  });

  /// The current amount in ngwee; null when empty.
  final int? ngwee;

  /// Called with the typed amount in ngwee, or null when cleared.
  final ValueChanged<int?> onChanged;

  /// What this amount does, shown below.
  final String? effectCaption;

  /// An error caption, shown instead of [effectCaption].
  final String? errorText;

  /// Opens the keyboard straight away.
  final bool autofocus;

  @override
  State<BkAmountField> createState() => _BkAmountFieldState();
}

class _BkAmountFieldState extends State<BkAmountField> {
  late final _controller = TextEditingController(text: _text(widget.ngwee));

  static String _text(int? ngwee) {
    if (ngwee == null) return '';
    final cents = ngwee % 100;
    return cents == 0
        ? '${ngwee ~/ 100}'
        : '${ngwee ~/ 100}.${cents.toString().padLeft(2, '0')}';
  }

  @override
  void didUpdateWidget(BkAmountField old) {
    super.didUpdateWidget(old);
    if (widget.ngwee != bkParseKwacha(_controller.text)) {
      _controller.text = _text(widget.ngwee);
    }
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
    final error = widget.errorText;
    final caption = error ?? widget.effectCaption;
    final style = bk.type.amountXl.copyWith(color: c.ink);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _controller,
          autofocus: widget.autofocus,
          textAlign: TextAlign.center,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
          onChanged: (t) => widget.onChanged(bkParseKwacha(t)),
          style: style,
          cursorColor: c.ink,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixText: 'K\u00a0',
            prefixStyle: style,
            hintText: '0',
            hintStyle: style.copyWith(color: c.inkMuted),
          ),
        ),
        if (caption != null) ...[
          const BkGap(BkSpacing.s2),
          Text(
            caption,
            textAlign: TextAlign.center,
            style: bk.type.caption.copyWith(
              color: error != null ? c.danger : c.inkMuted,
            ),
          ),
        ],
      ],
    );
  }
}
