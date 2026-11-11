import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// A rounded search field: a pill on `surface-sunken`, 44 tall (touch
/// target, AGENTS §8).
///
/// ```dart
/// BkSearchField(hint: 'Search help', onChanged: controller.search)
/// ```
class BkSearchField extends StatelessWidget {
  /// Creates the field.
  const BkSearchField({
    required this.hint,
    required this.onChanged,
    this.value,
    super.key,
  });

  /// Placeholder text.
  final String hint;

  /// Called on every edit.
  final ValueChanged<String> onChanged;

  /// Optional initial text.
  final String? value;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 44),
      child: TextField(
        controller: value == null ? null : TextEditingController(text: value),
        onChanged: onChanged,
        style: bk.type.body.copyWith(color: bk.colors.ink),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: bk.colors.surfaceSunken,
          hintText: hint,
          hintStyle: bk.type.body.copyWith(color: bk.colors.inkMuted),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: BkSpacing.s4,
            vertical: BkSpacing.s3,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(bk.radius.full),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
