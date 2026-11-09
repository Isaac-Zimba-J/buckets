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
  testWidgets('BkSplitBar widths follow basis points with 3px gaps', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        const SizedBox(
          width: 306,
          child: BkSplitBar(
            segments: [
              (BkBucketColor.living, 5000),
              (BkBucketColor.fun, 0),
              (BkBucketColor.emergency, 2500),
              (BkBucketColor.long, 2500),
            ],
          ),
        ),
      ),
    );
    final widths = tester
        .widgetList<Expanded>(find.byType(Expanded))
        .map((e) => e.flex)
        .toList();
    expect(widths, [5000, 2500, 2500]);
    final boxes = find.descendant(
      of: find.byType(BkSplitBar),
      matching: find.byType(ColoredBox),
    );
    expect(tester.getSize(boxes.at(0)), const Size(150, 12));
    expect(tester.getSize(boxes.at(1)).width, 75);
  });

  testWidgets('BkProgressBar clamps and reports a percentage', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _app(const SizedBox(width: 200, child: BkProgressBar(value: 1.4))),
    );
    expect(tester.getSize(find.byType(FractionallySizedBox)).width, 200);
    expect(tester.getSemantics(find.byType(BkProgressBar)).value, '100%');
    handle.dispose();
  });

  testWidgets('BkProgressRing reads its label and value', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _app(const BkProgressRing(value: 0.25, centerLabel: '36h')),
    );
    expect(
      tester.getSemantics(find.byType(BkProgressRing)),
      matchesSemantics(label: '36h', value: '25%'),
    );
    handle.dispose();
  });

  testWidgets('BkBucketTile reads as one sentence and taps', (tester) async {
    final handle = tester.ensureSemantics();
    var taps = 0;
    await tester.pumpWidget(
      _app(
        SizedBox(
          width: 120,
          child: BkBucketTile(
            label: 'Living',
            color: BkBucketColor.living,
            amountText: 'K 3,080',
            progress: 0.6,
            onTap: () => taps++,
          ),
        ),
      ),
    );
    expect(find.bySemanticsLabel('Living, K 3,080'), findsOneWidget);
    await tester.tap(find.byType(BkBucketTile));
    expect(taps, 1);
    handle.dispose();
  });

  testWidgets('BkTransferRow taps to prove; badge text from the app', (
    tester,
  ) async {
    var proved = 0;
    await tester.pumpWidget(
      _app(
        BkTransferRow(
          bucketLabel: 'Emergency',
          color: BkBucketColor.emergency,
          amountText: 'K 770',
          destination: 'Bank ••4521',
          status: BkTransferStatus.pending,
          statusLabel: 'Needs proof',
          onProve: () => proved++,
        ),
      ),
    );
    expect(find.text('Needs proof'), findsOneWidget);
    await tester.tap(find.text('Emergency'));
    expect(proved, 1);
  });

  testWidgets('BkStepList marks the active step and numbers the rest', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        const BkStepList(
          steps: [
            BkStep('Sort payments', BkStepState.done),
            BkStep('Count cash', BkStepState.active),
            BkStep('Your week', BkStepState.todo),
          ],
        ),
      ),
    );
    expect(find.byType(BkIcon), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
  });

  for (final (name, theme) in [
    ('light', BucketsTheme.light),
    ('dark', BucketsTheme.dark),
  ]) {
    testWidgets('money widgets golden ($name)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1040));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_app(const MoneyWidgetsPage(), theme: theme));
      await expectLater(
        find.byType(MoneyWidgetsPage),
        matchesGoldenFile('goldens/money_widgets_$name.png'),
      );
    });
  }
}
