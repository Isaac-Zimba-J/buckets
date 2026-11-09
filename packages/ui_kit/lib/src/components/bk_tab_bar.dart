import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/material.dart';

/// One tab of a [BkTabBar].
class BkTabItem {
  /// Creates the tab.
  const BkTabItem(this.label, this.icon);

  /// The text under the icon.
  final String label;

  /// The glyph; filled when active.
  final BkIcons icon;
}

/// The bottom tab bar: 76 tall `surface` with a 1px `line` top; the active
/// tab is `ink` 600 with a filled icon, the others `ink-muted`.
///
/// ```dart
/// BkTabBar(items: tabs, currentIndex: 0, onTap: goToTab)
/// ```
class BkTabBar extends StatelessWidget {
  /// Creates the bar.
  const BkTabBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  /// The tabs: Home, Goals, Plan, Me.
  final List<BkTabItem> items;

  /// The active tab.
  final int currentIndex;

  /// Called with the tapped tab's index.
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.surface,
        border: Border(top: BorderSide(color: c.line)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 76,
          child: Row(
            children: [
              for (final (i, item) in items.indexed)
                Expanded(child: _tab(context, i, item)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab(BuildContext context, int i, BkTabItem item) {
    final bk = context.bk;
    final active = i == currentIndex;
    final color = active ? bk.colors.ink : bk.colors.inkMuted;
    return Semantics(
      selected: active,
      button: true,
      child: InkWell(
        onTap: () => onTap(i),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BkIcon(item.icon, color: color, filled: active),
            const BkGap(BkSpacing.s1),
            Text(
              item.label,
              style: bk.type.caption.copyWith(
                color: color,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
