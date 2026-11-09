import 'package:buckets_ui_kit/buckets_ui_kit.dart';
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

  for (final (name, theme) in [
    ('light', BucketsTheme.light),
    ('dark', BucketsTheme.dark),
  ]) {
    testWidgets('containers golden ($name)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 760));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_app(const _Sheet(), theme: theme));
      await expectLater(
        find.byType(_Sheet),
        matchesGoldenFile('goldens/containers_$name.png'),
      );
    });
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet();

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.bk.colors.bg,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BkHeroCard(
          child: BkMoneyText(
            ngwee: 308000,
            size: BkAmountSize.xl,
            color: context.bk.colors.onHero,
          ),
        ),
        const BkGap(BkSpacing.s3),
        const BkCard(child: Text('Surface card')),
        const BkGap(BkSpacing.s3),
        BkListGroup(
          children: [
            BkListRow(
              title: 'Rent',
              subtitle: 'Due 1 Nov',
              trailing: const BkMoneyText(ngwee: 250000),
              chevron: true,
              onTap: () {},
            ),
            const BkListRow(
              title: 'ZESCO',
              trailing: BkMoneyText(ngwee: 40000),
            ),
          ],
        ),
        const BkGap(BkSpacing.s3),
        const BkSkeleton(height: 28, width: 160),
        const BkGap(BkSpacing.s2),
        const BkSkeleton(height: 16),
        BkEmptyState(
          icon: BkIcons.goals,
          title: 'No goals yet',
          message: 'Add one and part of every payday goes to it.',
          actionLabel: 'Add a goal',
          onAction: () {},
        ),
      ],
    ),
  );
}
