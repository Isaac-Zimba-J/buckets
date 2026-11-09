import 'package:buckets_ui_kit/src/components/bk_icon_button.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/foundation/bk_semantics.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// Home's header: a muted greeting over a title, and the notifications
/// button with a dot when something is unread.
///
/// ```dart
/// BkGreetingHeader(greeting: 'Good morning', title: 'Payday is here',
///     hasUnread: true, notificationsLabel: 'Notifications',
///     onNotifications: open)
/// ```
class BkGreetingHeader extends StatelessWidget {
  /// Creates the header.
  const BkGreetingHeader({
    required this.greeting,
    required this.title,
    required this.notificationsLabel,
    required this.onNotifications,
    this.hasUnread = false,
    super.key,
  });

  /// The muted first line.
  final String greeting;

  /// The big second line.
  final String title;

  /// The button's accessible name (include "unread" in it if needed).
  final String notificationsLabel;

  /// Opens notifications.
  final VoidCallback onNotifications;

  /// Shows a dot on the button.
  final bool hasUnread;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final c = bk.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        BkSpacing.s4,
        BkSpacing.s2,
        BkSpacing.s4,
        BkSpacing.s2,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  greeting,
                  style: bk.type.callout.copyWith(color: c.inkMuted),
                ),
                BkHeading(
                  child: Text(
                    title,
                    style: bk.type.title1.copyWith(color: c.ink),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              BkIconButton(
                icon: BkIcons.notifications,
                semanticLabel: notificationsLabel,
                onPressed: onNotifications,
              ),
              if (hasUnread)
                Positioned(
                  top: 8,
                  right: 10,
                  child: IgnorePointer(
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: c.danger,
                        shape: BoxShape.circle,
                        border: Border.all(color: c.surface, width: 1.5),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
