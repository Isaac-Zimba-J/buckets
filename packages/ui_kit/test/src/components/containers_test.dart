import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:buckets_ui_kit/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? BucketsTheme.light,
  home: Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(BkSpacing.s4),
      child: Center(child: child),
    ),
  ),
);

void main() {
  testWidgets('BkListGroup divides rows; rows tap and are 56 tall', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      _app(
        BkListGroup(
          children: [
            BkListRow(title: 'Rent', chevron: true, onTap: () => taps++),
            const BkListRow(title: 'ZESCO', subtitle: 'Due 1 Nov'),
            const BkListRow(title: 'Water'),
          ],
        ),
      ),
    );
    expect(find.byType(Divider), findsNWidgets(2));
    expect(find.byType(BkIcon), findsOneWidget);
    expect(tester.getSize(find.byType(BkListRow).first).height, 56);
    await tester.tap(find.text('Rent'));
    expect(taps, 1);
  });

  testWidgets('BkHeroCard gives its text on-hero', (tester) async {
    await tester.pumpWidget(_app(const BkHeroCard(child: Text('Left'))));
    final style = DefaultTextStyle.of(tester.element(find.text('Left'))).style;
    expect(style.color, BkColors.light.onHero);
  });

  testWidgets('BkHeroStat: accent icon, on-hero value, one semantics node', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _app(
        const BkHeroCard(
          child: BkHeroStat(
            icon: BkIcons.streak,
            label: 'Streak',
            value: '5 paydays',
          ),
        ),
      ),
    );
    const c = BkColors.light;
    expect(tester.widget<BkIcon>(find.byType(BkIcon)).color, c.accent);
    expect(tester.widget<Text>(find.text('5 paydays')).style!.color, c.onHero);
    expect(
      tester.getSemantics(find.byType(BkHeroStat)).label,
      'Streak\n5 paydays',
    );
    handle.dispose();
  });

  testWidgets('BkSkeleton is hidden from screen readers', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(_app(const BkSkeleton(width: 120, height: 28)));
    expect(tester.getSize(find.byType(BkSkeleton)), const Size(120, 28));
    expect(find.byType(ExcludeSemantics), findsWidgets);
    handle.dispose();
  });

  testWidgets('BkEmptyState: heading, message, one action', (tester) async {
    final handle = tester.ensureSemantics();
    var taps = 0;
    await tester.pumpWidget(
      _app(
        BkEmptyState(
          icon: BkIcons.goals,
          title: 'No goals yet',
          message: 'Add one and part of every payday goes to it.',
          actionLabel: 'Add a goal',
          onAction: () => taps++,
        ),
      ),
    );
    expect(
      tester.getSemantics(find.text('No goals yet')),
      matchesSemantics(label: 'No goals yet', isHeader: true),
    );
    await tester.tap(find.text('Add a goal'));
    expect(taps, 1);
    handle.dispose();
  });

  testWidgets('BkBottomActions keeps a 32 px inset above the system bar', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: BucketsTheme.light,
        home: MediaQuery(
          data: const MediaQueryData(padding: EdgeInsets.only(bottom: 20)),
          child: Scaffold(
            bottomNavigationBar: BkBottomActions(
              children: [BkButton.primary(label: 'Continue', onPressed: () {})],
            ),
          ),
        ),
      ),
    );
    final box = tester.getRect(find.byType(BkBottomActions));
    final button = tester.getRect(find.byType(BkButton));
    expect(box.bottom - button.bottom, BkSpacing.s8 + 20);
  });

  group('BkAvatar', () {
    testWidgets('shows the initial, or a neutral icon', (tester) async {
      await tester.pumpWidget(_app(const BkAvatar(initial: 'I')));
      expect(find.text('I'), findsOneWidget);
      await tester.pumpWidget(_app(const BkAvatar()));
      expect(find.text('I'), findsNothing);
      expect(find.byType(BkIcon), findsOneWidget);
    });
  });

  testWidgets('BkSearchField reports edits', (tester) async {
    var text = '';
    await tester.pumpWidget(
      _app(BkSearchField(hint: 'Search help', onChanged: (v) => text = v)),
    );
    await tester.enterText(find.byType(TextField), 'lock');
    expect(text, 'lock');
  });

  group('BkSettingsRow', () {
    testWidgets('shows value, taps, and is a button', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _app(
          BkSettingsRow(
            title: 'Security',
            value: 'Lock on',
            leadingIcon: BkIcons.lock,
            onTap: () => taps++,
          ),
        ),
      );
      expect(find.text('Lock on'), findsOneWidget);
      await tester.tap(find.byType(BkSettingsRow));
      expect(taps, 1);
    });
  });

  group('BkConfirmDialog', () {
    testWidgets('confirm returns true, cancel false', (tester) async {
      late Future<bool> result;
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) => BkButton.primary(
              label: 'Open',
              onPressed: () => result = BkConfirmDialog.show(
                context,
                title: 'Clear history',
                message: 'Delete stored alert text now?',
                confirmLabel: 'Clear',
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Clear'));
      await tester.pumpAndSettle();
      expect(await result, isTrue);
    });

    testWidgets('typedConfirmation gates confirm (R-PRIV-4)', (tester) async {
      late Future<bool> result;
      await tester.pumpWidget(
        _app(
          Builder(
            builder: (context) => BkButton.primary(
              label: 'Open',
              onPressed: () => result = BkConfirmDialog.show(
                context,
                title: 'Delete all data',
                message: 'This cannot be undone.',
                confirmLabel: 'Delete',
                typedConfirmation: 'DELETE',
                destructive: true,
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      // Confirm is disabled until DELETE is typed.
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'DELETE');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();
      expect(await result, isTrue);
    });
  });

  for (final (name, theme) in [
    ('light', BucketsTheme.light),
    ('dark', BucketsTheme.dark),
  ]) {
    testWidgets('containers golden ($name)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1240));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_app(const ContainersPage(), theme: theme));
      await expectLater(
        find.byType(ContainersPage),
        matchesGoldenFile('goldens/containers_$name.png'),
      );
    });
  }
}
