import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? BucketsTheme.light,
  home: Scaffold(body: Center(child: child)),
);

const _tabs = [
  BkTabItem('Home', BkIcons.home),
  BkTabItem('Goals', BkIcons.goals),
  BkTabItem('Plan', BkIcons.plan),
  BkTabItem('Me', BkIcons.me),
];

void main() {
  testWidgets('BkTopBar: heading title, empty slots keep it centred', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(_app(const BkTopBar(title: 'Emergency')));
    expect(
      tester.getSemantics(find.text('Emergency')),
      matchesSemantics(label: 'Emergency', isHeader: true),
    );
    final bar = tester.getRect(find.byType(BkTopBar));
    final title = tester.getRect(find.text('Emergency'));
    expect(title.center.dx, closeTo(bar.center.dx, 0.5));
    handle.dispose();
  });

  testWidgets('BkFlowHeader: step label, progress, back', (tester) async {
    var back = 0;
    await tester.pumpWidget(
      _app(
        BkFlowHeader(
          step: 2,
          total: 5,
          stepLabel: '2 of 5',
          backLabel: 'Back',
          onBack: () => back++,
        ),
      ),
    );
    expect(find.text('2 of 5'), findsOneWidget);
    expect(tester.widget<BkProgressBar>(find.byType(BkProgressBar)).value, 0.4);
    await tester.tap(find.byType(BkIconButton));
    expect(back, 1);
    await tester.pumpWidget(
      _app(
        const BkFlowHeader(
          step: 1,
          total: 5,
          stepLabel: '1 of 5',
          backLabel: 'Back',
        ),
      ),
    );
    expect(find.byType(BkIconButton), findsNothing);
  });

  testWidgets('BkGreetingHeader: unread dot and notifications', (tester) async {
    var opened = 0;
    Widget header({required bool unread}) => _app(
      BkGreetingHeader(
        greeting: 'Good morning',
        title: 'Payday is here',
        notificationsLabel: 'Notifications',
        hasUnread: unread,
        onNotifications: () => opened++,
      ),
    );
    await tester.pumpWidget(header(unread: true));
    expect(find.byType(Positioned), findsOneWidget);
    await tester.tap(find.byType(BkIconButton));
    expect(opened, 1);
    await tester.pumpWidget(header(unread: false));
    expect(find.byType(Positioned), findsNothing);
  });

  testWidgets('BkTabBar: 76 tall, active tab filled and selected', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    var tapped = -1;
    await tester.pumpWidget(
      _app(BkTabBar(items: _tabs, currentIndex: 1, onTap: (i) => tapped = i)),
    );
    expect(tester.getSize(find.byType(BkTabBar)).height, 76);
    final icons = tester.widgetList<BkIcon>(find.byType(BkIcon)).toList();
    expect(icons.map((i) => i.filled), [false, true, false, false]);
    expect(
      tester.getSemantics(find.text('Goals')),
      matchesSemantics(
        label: 'Goals',
        isSelected: true,
        hasSelectedState: true,
        isButton: true,
        hasTapAction: true,
        hasFocusAction: true,
        isFocusable: true,
      ),
    );
    await tester.tap(find.text('Plan'));
    expect(tapped, 2);
    handle.dispose();
  });

  for (final (name, theme) in [
    ('light', BucketsTheme.light),
    ('dark', BucketsTheme.dark),
  ]) {
    testWidgets('navigation golden ($name)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 420));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_app(const _Sheet(), theme: theme));
      await expectLater(
        find.byType(_Sheet),
        matchesGoldenFile('goldens/navigation_$name.png'),
      );
    });
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet();

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
          BkTabBar(items: _tabs, currentIndex: 0, onTap: (_) {}),
        ],
      ),
    );
  }
}
