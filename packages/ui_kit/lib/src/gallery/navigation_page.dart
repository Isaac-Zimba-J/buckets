import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// The four app tabs, for the gallery and tests.
const galleryTabs = [
  BkTabItem('Home', BkIcons.home),
  BkTabItem('Goals', BkIcons.goals),
  BkTabItem('Plan', BkIcons.plan),
  BkTabItem('Me', BkIcons.me),
];

/// Gallery page: Navigation in light or dark, every state.
class NavigationPage extends StatelessWidget {
  /// Creates the page.
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    void none() {}
    return ColoredBox(
      color: context.bk.colors.bg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BkGreetingHeader(
            greeting: 'Good morning',
            title: 'Payday is here',
            notificationsLabel: 'Notifications',
            hasUnread: true,
            onNotifications: none,
          ),
          BkTopBar(
            leading: BkIconButton(
              icon: BkIcons.back,
              semanticLabel: 'Back',
              onPressed: none,
            ),
            title: 'Emergency',
            trailing: BkIconButton(
              icon: BkIcons.close,
              semanticLabel: 'Close',
              onPressed: none,
            ),
          ),
          BkFlowHeader(
            step: 2,
            total: 5,
            stepLabel: '2 of 5',
            backLabel: 'Back',
            onBack: none,
          ),
          const SizedBox(height: BkSpacing.s8),
          BkTabBar(items: galleryTabs, currentIndex: 0, onTap: (_) {}),
        ],
      ),
    );
  }
}
