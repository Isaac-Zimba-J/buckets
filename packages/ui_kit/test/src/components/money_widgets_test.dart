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
      await tester.pumpWidget(_app(const _Sheet(), theme: theme));
      await expectLater(
        find.byType(_Sheet),
        matchesGoldenFile('goldens/money_widgets_$name.png'),
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
        const BkSplitBar(
          segments: [
            (BkBucketColor.living, 4000),
            (BkBucketColor.fun, 1000),
            (BkBucketColor.emergency, 1000),
            (BkBucketColor.short, 1000),
            (BkBucketColor.long, 2000),
            (BkBucketColor.goal, 1000),
          ],
        ),
        const BkGap(BkSpacing.s4),
        Row(
          children: [
            for (final (label, color, p) in const [
              ('Living', BkBucketColor.living, 0.6),
              ('Guilt-free', BkBucketColor.fun, 0.2),
              ('Laptop', BkBucketColor.goal, 0.9),
            ]) ...[
              Expanded(
                child: BkBucketTile(
                  label: label,
                  color: color,
                  amountText: 'K 770',
                  progress: p,
                ),
              ),
              const BkGap(BkSpacing.s2),
            ],
          ],
        ),
        const BkGap(BkSpacing.s4),
        BkHeroCard(
          child: Column(
            children: [
              BkProgressBar(value: 0.5, onHero: true),
              const BkGap(BkSpacing.s2),
              const BkProgressBar(value: 0.3, color: BkBucketColor.short),
            ],
          ),
        ),
        const BkGap(BkSpacing.s4),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BkProgressRing(value: 0.25, centerLabel: '36h'),
            BkProgressRing(value: 1, centerLabel: '0h'),
            BkBucketDot(color: BkBucketColor.family, size: 16),
          ],
        ),
        BkListGroup(
          children: [
            for (final (status, label) in const [
              (BkTransferStatus.pending, 'Needs proof'),
              (BkTransferStatus.proven, 'Proven'),
              (BkTransferStatus.partial, 'K 70 owed'),
              (BkTransferStatus.selfReported, 'Marked saved'),
            ])
              BkTransferRow(
                bucketLabel: 'Emergency',
                color: BkBucketColor.emergency,
                amountText: 'K 770',
                destination: 'Bank ••4521',
                status: status,
                statusLabel: label,
              ),
          ],
        ),
        const BkGap(BkSpacing.s3),
        for (final r in BkCheckResult.values)
          BkProofCheckRow(label: 'Amount', value: 'K 770', result: r),
        const BkStepList(
          steps: [
            BkStep('Sort payments', BkStepState.done),
            BkStep('Count cash', BkStepState.active, subtitle: '2 of 3'),
            BkStep('Your week', BkStepState.todo),
          ],
        ),
      ],
    ),
  );
}
