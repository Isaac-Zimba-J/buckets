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
  group('BkButton', () {
    testWidgets('taps, with the spec heights', (tester) async {
      var taps = 0;
      for (final (button, height) in [
        (BkButton.primary(label: 'Go', onPressed: () => taps++), 54.0),
        (BkButton.secondary(label: 'Go', onPressed: () => taps++), 48.0),
        (BkButton.text(label: 'Go', onPressed: () => taps++), 44.0),
        (BkButton.destructive(label: 'Go', onPressed: () => taps++), 48.0),
      ]) {
        await tester.pumpWidget(_app(button));
        await tester.tap(find.text('Go'));
        expect(tester.getSize(find.byType(InkWell)).height, height);
      }
      expect(taps, 4);
    });

    testWidgets('disabled shows its reason and ignores taps', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(
        _app(
          const BkButton.secondary(
            label: 'Snooze',
            onPressed: null,
            disabledReason: 'No snoozes left',
          ),
        ),
      );
      expect(find.text('No snoozes left'), findsOneWidget);
      expect(
        tester.getSemantics(find.text('Snooze')),
        matchesSemantics(
          label: 'Snooze',
          isButton: true,
          hasEnabledState: true,
        ),
      );
      handle.dispose();
    });

    testWidgets('loading shows a spinner and ignores taps', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        _app(
          BkButton.primary(
            label: 'Save',
            onPressed: () => taps++,
            loading: true,
          ),
        ),
      );
      expect(find.text('Save'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.tap(find.byType(BkButton));
      expect(taps, 0);
    });

    testWidgets('icon before the label', (tester) async {
      await tester.pumpWidget(
        _app(
          BkButton.secondary(
            label: 'Retake',
            icon: BkIcons.camera,
            onPressed: () {},
          ),
        ),
      );
      expect(find.byType(BkIcon), findsOneWidget);
    });
  });

  testWidgets('BkIconButton: label, 44 target, taps', (tester) async {
    final handle = tester.ensureSemantics();
    var taps = 0;
    await tester.pumpWidget(
      _app(
        BkIconButton(
          icon: BkIcons.back,
          semanticLabel: 'Back',
          onPressed: () => taps++,
        ),
      ),
    );
    expect(tester.getSize(find.byType(InkWell)), const Size.square(44));
    expect(find.bySemanticsLabel('Back'), findsOneWidget);
    await tester.tap(find.byType(BkIconButton));
    expect(taps, 1);
    handle.dispose();
  });

  testWidgets('BkFab: label, 60 target, taps', (tester) async {
    final handle = tester.ensureSemantics();
    var taps = 0;
    await tester.pumpWidget(
      _app(BkFab(semanticLabel: 'Log a payment', onPressed: () => taps++)),
    );
    expect(tester.getSize(find.byType(InkWell)), const Size.square(60));
    expect(find.bySemanticsLabel('Log a payment'), findsOneWidget);
    await tester.tap(find.byType(BkFab));
    expect(taps, 1);
    handle.dispose();
  });

  for (final (name, theme) in [
    ('light', BucketsTheme.light),
    ('dark', BucketsTheme.dark),
  ]) {
    testWidgets('actions golden ($name)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 640));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_app(const _Sheet(), theme: theme));
      await expectLater(
        find.byType(_Sheet),
        matchesGoldenFile('goldens/actions_$name.png'),
      );
    });
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet();

  @override
  Widget build(BuildContext context) {
    void tap() {}
    return ColoredBox(
      color: context.bk.colors.bg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BkButton.primary(label: 'Check proof', onPressed: tap),
          const BkGap(BkSpacing.s2),
          const BkButton.primary(
            label: 'Saving',
            onPressed: null,
            loading: true,
          ),
          const BkGap(BkSpacing.s2),
          BkButton.secondary(
            label: 'Retake',
            icon: BkIcons.camera,
            onPressed: tap,
          ),
          const BkGap(BkSpacing.s2),
          const BkButton.secondary(
            label: 'Snooze',
            onPressed: null,
            disabledReason: 'No snoozes left',
          ),
          const BkGap(BkSpacing.s2),
          BkButton.destructive(label: 'Remove', onPressed: tap),
          BkButton.text(label: 'Skip', onPressed: tap),
          const BkGap(BkSpacing.s2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BkIconButton(
                icon: BkIcons.back,
                semanticLabel: 'Back',
                onPressed: tap,
              ),
              const BkIconButton(
                icon: BkIcons.close,
                semanticLabel: 'Close',
                onPressed: null,
              ),
              ColoredBox(
                color: context.bk.colors.hero,
                child: Padding(
                  padding: const EdgeInsets.all(BkSpacing.s2),
                  child: BkIconButton(
                    icon: BkIcons.notifications,
                    semanticLabel: 'Notifications',
                    variant: BkIconButtonVariant.onHero,
                    onPressed: tap,
                  ),
                ),
              ),
              BkFab(semanticLabel: 'Log a payment', onPressed: tap),
            ],
          ),
        ],
      ),
    );
  }
}
