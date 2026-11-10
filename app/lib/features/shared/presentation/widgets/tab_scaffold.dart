import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The four tabs.
enum AppTab {
  /// Home.
  home,

  /// Goals.
  goals,

  /// Plan.
  plan,

  /// Me.
  me,
}

/// A tab screen: `bg`, the body and the tab bar; optional floating button.
class TabScaffold extends StatelessWidget {
  /// Creates the scaffold.
  const TabScaffold({
    required this.tab,
    required this.body,
    this.fab,
    super.key,
  });

  /// The active tab.
  final AppTab tab;

  /// The screen content.
  final Widget body;

  /// The floating log button (Home only).
  final Widget? fab;

  static const List<String> _routes = [
    Routes.home,
    Routes.goals,
    Routes.plan,
    Routes.me,
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: context.bk.colors.bg,
      body: SafeArea(bottom: false, child: body),
      floatingActionButton: fab,
      bottomNavigationBar: BkTabBar(
        items: [
          BkTabItem(l.tabHome, BkIcons.home),
          BkTabItem(l.tabGoals, BkIcons.goals),
          BkTabItem(l.tabPlan, BkIcons.plan),
          BkTabItem(l.tabMe, BkIcons.me),
        ],
        currentIndex: tab.index,
        onTap: (i) {
          if (i != tab.index) context.go(_routes[i]);
        },
      ),
    );
  }
}
