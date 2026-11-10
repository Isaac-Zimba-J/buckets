import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

enum _Kind { primary, accent, secondary, text, destructive }

/// A text button: the four kinds from COMPONENT_SPECS plus `accent` for
/// hero screens.
///
/// Disabled when [onPressed] is null; pass [disabledReason] to explain why
/// in a caption below. [loading] shows a spinner and ignores taps.
///
/// ```dart
/// BkButton.primary(label: 'Check proof', onPressed: check)
/// BkButton.secondary(label: 'Snooze', onPressed: null,
///     disabledReason: 'No snoozes left')
/// ```
class BkButton extends StatelessWidget {
  /// The one main action of a screen: 54 tall, full width, `action` fill.
  const BkButton.primary({
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.disabledReason,
    super.key,
  }) : _kind = _Kind.primary;

  /// The main action on a full-bleed `hero` screen (payday complete):
  /// 54 tall, `accent` fill, `on-accent` text. Never on light grounds.
  const BkButton.accent({
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.disabledReason,
    super.key,
  }) : _kind = _Kind.accent;

  /// Alternatives: 48 tall, `surface` fill with a border.
  const BkButton.secondary({
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.disabledReason,
    super.key,
  }) : _kind = _Kind.secondary;

  /// Low-weight actions: 44 tall, no fill.
  const BkButton.text({
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.disabledReason,
    super.key,
  }) : _kind = _Kind.text;

  /// Remove or delete: a secondary button with `danger` text.
  const BkButton.destructive({
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.disabledReason,
    super.key,
  }) : _kind = _Kind.destructive;

  final _Kind _kind;

  /// The button text.
  final String label;

  /// Called on tap; null disables the button.
  final VoidCallback? onPressed;

  /// An optional icon before the label.
  final BkIcons? icon;

  /// Shows a spinner instead of the label and ignores taps.
  final bool loading;

  /// Why the button is disabled, shown below it.
  final String? disabledReason;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    final enabled = onPressed != null;
    final filled = _kind != _Kind.text;
    final fill = !enabled && filled
        ? c.surfaceSunken
        : switch (_kind) {
            _Kind.primary => c.action,
            _Kind.accent => c.accent,
            _Kind.secondary || _Kind.destructive => c.surface,
            _Kind.text => Colors.transparent,
          };
    final ink = !enabled
        ? c.inkMuted
        : switch (_kind) {
            _Kind.primary => c.onAction,
            _Kind.accent => c.onAccent,
            _Kind.secondary || _Kind.text => c.ink,
            _Kind.destructive => c.danger,
          };
    final radius = BorderRadius.circular(bk.radius.md);
    final bordered =
        enabled && (_kind == _Kind.secondary || _kind == _Kind.destructive);
    final button = Semantics(
      button: true,
      enabled: enabled && !loading,
      child: Material(
        color: fill,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: bordered ? BorderSide(color: c.controlBorder) : BorderSide.none,
        ),
        child: InkWell(
          onTap: loading ? null : onPressed,
          borderRadius: radius,
          child: SizedBox(
            height: switch (_kind) {
              _Kind.primary || _Kind.accent => 54,
              _Kind.secondary || _Kind.destructive => 48,
              _Kind.text => 44,
            },
            width: filled ? double.infinity : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: BkSpacing.s4),
              child: _content(context, ink),
            ),
          ),
        ),
      ),
    );
    final reason = disabledReason;
    if (enabled || reason == null) return button;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        button,
        const BkGap(BkSpacing.s2),
        Text(
          reason,
          textAlign: TextAlign.center,
          style: bk.type.caption.copyWith(color: c.inkMuted),
        ),
      ],
    );
  }

  Widget _content(BuildContext context, Color ink) {
    if (loading) {
      return Center(
        child: SizedBox.square(
          dimension: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: ink),
        ),
      );
    }
    final style = context.bk.type.callout.copyWith(
      color: ink,
      fontWeight: FontWeight.w600,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon case final i?) ...[
          BkIcon(i, size: 20, color: ink),
          const BkGap(BkSpacing.s2),
        ],
        Flexible(
          child: Text(label, style: style, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
