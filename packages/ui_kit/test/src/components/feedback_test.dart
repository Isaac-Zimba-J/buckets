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
  testWidgets('BkBanner: tone colours; only danger is a live region', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    for (final tone in [BkTone.danger, BkTone.info]) {
      await tester.pumpWidget(
        _app(BkBanner(tone: tone, title: 'Title', message: 'Message')),
      );
      final text = tester.widget<Text>(find.text('Message'));
      expect(
        text.style!.color,
        tone.foreground(tester.element(find.text('Message'))),
      );
      expect(
        tester.getSemantics(find.byType(BkBanner)).flagsCollection.isLiveRegion,
        tone == BkTone.danger,
      );
    }
    handle.dispose();
  });

  testWidgets('BkBadge is a 24 px pill', (tester) async {
    await tester.pumpWidget(
      _app(const BkBadge(label: 'Proven', tone: BkTone.positive)),
    );
    final size = tester.getSize(find.byType(BkBadge));
    expect(size.height, 24);
    expect(size.width, lessThan(200));
  });

  testWidgets('showBkToast shows for 3 s; Undo runs once', (tester) async {
    var undone = 0;
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => BkButton.primary(
            label: 'Save',
            onPressed: () => showBkToast(
              context,
              message: 'Saved',
              actionLabel: 'Undo',
              onAction: () => undone++,
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Saved'), findsOneWidget);
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(undone, 1);
    expect(find.text('Saved'), findsNothing);

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
    expect(find.text('Saved'), findsNothing);
  });

  testWidgets('showBkSheet: title heading, actions, returns the pop value', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    String? result;
    await tester.pumpWidget(
      _app(
        Builder(
          builder: (context) => BkButton.primary(
            label: 'Open',
            onPressed: () async => result = await showBkSheet<String>(
              context,
              title: 'Sort payment',
              child: const Text('Body'),
              actions: [
                Builder(
                  builder: (c) => BkButton.primary(
                    label: 'File',
                    onPressed: () => Navigator.pop(c, 'filed'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(
      tester.getSemantics(find.text('Sort payment')),
      matchesSemantics(label: 'Sort payment', isHeader: true),
    );
    await tester.tap(find.text('File'));
    await tester.pumpAndSettle();
    expect(result, 'filed');
    handle.dispose();
  });

  for (final (name, theme) in [
    ('light', BucketsTheme.light),
    ('dark', BucketsTheme.dark),
  ]) {
    testWidgets('feedback golden ($name)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 720));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_app(const FeedbackPage(), theme: theme));
      await expectLater(
        find.byType(FeedbackPage),
        matchesGoldenFile('goldens/feedback_$name.png'),
      );
    });
  }
}
