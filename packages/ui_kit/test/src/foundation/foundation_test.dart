import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? BucketsTheme.light,
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('BkMoneyText', () {
    final cases = <(BkMoneyText, String)>[
      (const BkMoneyText(ngwee: 154000), 'K\u00a01,540'),
      (const BkMoneyText(ngwee: -32000), '−K\u00a0320'),
      (const BkMoneyText(ngwee: 5000, showSign: true), '+K\u00a050'),
      (const BkMoneyText(ngwee: 41250, showNgwee: true), 'K\u00a0412.50'),
      (const BkMoneyText(ngwee: 41250), 'K\u00a0413'),
    ];
    for (final (widget, text) in cases) {
      testWidgets('shows $text', (tester) async {
        await tester.pumpWidget(_app(widget));
        expect(find.text(text), findsOneWidget);
      });
    }

    testWidgets('uses the amount style, ink, or the colour given', (
      tester,
    ) async {
      await tester.pumpWidget(
        _app(const BkMoneyText(ngwee: 100, size: BkAmountSize.xl)),
      );
      var text = tester.widget<Text>(find.byType(Text));
      expect(text.style!.fontSize, BkTypography.amountXl.fontSize);
      expect(text.style!.color, BkColors.light.ink);
      await tester.pumpWidget(
        _app(BkMoneyText(ngwee: 100, color: BkColors.light.danger)),
      );
      text = tester.widget<Text>(find.byType(Text));
      expect(text.style!.color, BkColors.light.danger);
      expect(text.style!.fontSize, BkTypography.amountM.fontSize);
    });
  });

  testWidgets('BkGap is square', (tester) async {
    await tester.pumpWidget(_app(const BkGap(BkSpacing.s4)));
    expect(tester.getSize(find.byType(BkGap)), const Size.square(16));
  });

  testWidgets('BkTapTarget gives a small child a 44 hit area', (tester) async {
    await tester.pumpWidget(
      _app(const BkTapTarget(child: BkIcon(BkIcons.close, size: 20))),
    );
    expect(
      tester.getSize(find.byType(BkTapTarget)),
      const Size.square(bkMinTapTarget),
    );
    expect(tester.getSize(find.byType(BkIcon)), const Size.square(20));
  });

  testWidgets('BkHeading and BkSemanticLabel', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _app(
        const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BkHeading(child: Text('Payday')),
            BkSemanticLabel(
              label: 'Living, K 1,540 left',
              child: Text('Living'),
            ),
          ],
        ),
      ),
    );
    expect(
      tester.getSemantics(find.text('Payday')),
      matchesSemantics(label: 'Payday', isHeader: true),
    );
    expect(find.bySemanticsLabel('Living, K 1,540 left'), findsOneWidget);
    expect(find.bySemanticsLabel('Living'), findsNothing);
    handle.dispose();
  });

  group('BkIcon', () {
    testWidgets('every glyph draws, outline and filled', (tester) async {
      await tester.pumpWidget(_app(const _IconSheet()));
      expect(
        find.byType(BkIcon),
        findsNWidgets(BkIcons.values.length + _tabs.length),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('is decorative', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(_app(const BkIcon(BkIcons.notifications)));
      expect(tester.getSemantics(find.byType(BkIcon)).label, isEmpty);
      handle.dispose();
    });
  });

  for (final (name, theme) in [
    ('light', BucketsTheme.light),
    ('dark', BucketsTheme.dark),
  ]) {
    testWidgets('foundation sheet golden ($name)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 420));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_app(const _Sheet(), theme: theme));
      await expectLater(
        find.byType(_Sheet),
        matchesGoldenFile('goldens/foundation_$name.png'),
      );
    });
  }
}

const List<BkIcons> _tabs = [
  BkIcons.home,
  BkIcons.goals,
  BkIcons.plan,
  BkIcons.me,
];

class _IconSheet extends StatelessWidget {
  const _IconSheet();

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: BkSpacing.s3,
    runSpacing: BkSpacing.s3,
    children: [
      for (final icon in BkIcons.values)
        BkIcon(icon, color: context.bk.colors.ink),
      for (final icon in _tabs)
        BkIcon(icon, filled: true, color: context.bk.colors.ink),
    ],
  );
}

class _Sheet extends StatelessWidget {
  const _Sheet();

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.bk.colors.bg,
    child: const Padding(
      padding: EdgeInsets.all(BkSpacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconSheet(),
          BkGap(BkSpacing.s6),
          BkMoneyText(ngwee: 768000, size: BkAmountSize.xl),
          BkMoneyText(ngwee: 154000, size: BkAmountSize.l),
          BkMoneyText(ngwee: -32000),
          BkMoneyText(ngwee: 41250, showNgwee: true, showSign: true),
        ],
      ),
    ),
  );
}
