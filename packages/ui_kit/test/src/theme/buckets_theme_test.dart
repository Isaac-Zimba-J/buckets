import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('light theme installs all Buckets extensions', (tester) async {
    late BkThemeTokens tokens;
    await tester.pumpWidget(
      MaterialApp(
        theme: BucketsTheme.light,
        home: _ThemeProbe(onTokens: (value) => tokens = value),
      ),
    );

    expect(tokens.colors.bg, BkColors.light.bg);
    expect(tokens.type.title1, BkTypography.title1);
    expect(tokens.spacing.s5, 20);
    expect(tokens.radius.lg, 20);
    expect(tokens.shadows.card, BkShadows.card);
  });

  testWidgets('dark theme installs dark color tokens', (tester) async {
    late BkThemeTokens tokens;
    await tester.pumpWidget(
      MaterialApp(
        theme: BucketsTheme.dark,
        home: _ThemeProbe(onTokens: (value) => tokens = value),
      ),
    );

    expect(tokens.colors.bg, BkColors.dark.bg);
    expect(tokens.colors.action, BkColors.dark.action);
  });

  testWidgets('light token sheet golden', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(theme: BucketsTheme.light, home: const _TokenSheet()),
    );

    await expectLater(
      find.byType(_TokenSheet),
      matchesGoldenFile('goldens/token_sheet_light.png'),
    );
  });

  testWidgets('dark token sheet golden', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(theme: BucketsTheme.dark, home: const _TokenSheet()),
    );

    await expectLater(
      find.byType(_TokenSheet),
      matchesGoldenFile('goldens/token_sheet_dark.png'),
    );
  });
}

class _ThemeProbe extends StatelessWidget {
  const _ThemeProbe({required this.onTokens});

  final ValueChanged<BkThemeTokens> onTokens;

  @override
  Widget build(BuildContext context) => Builder(
    builder: (context) {
      onTokens(context.bk);
      return const SizedBox.shrink();
    },
  );
}

class _TokenSheet extends StatelessWidget {
  const _TokenSheet();

  @override
  Widget build(BuildContext context) {
    final tokens = context.bk;
    final colors = tokens.colors;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(tokens.spacing.s5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('BUCKETS · UI KIT', style: tokens.type.overline),
                SizedBox(height: tokens.spacing.s2),
                Text(
                  'Design tokens',
                  style: tokens.type.title1.copyWith(color: colors.ink),
                ),
                SizedBox(height: tokens.spacing.s6),
                Text('Color', style: tokens.type.title2),
                SizedBox(height: tokens.spacing.s3),
                Wrap(
                  spacing: tokens.spacing.s2,
                  runSpacing: tokens.spacing.s2,
                  children: [
                    _Swatch('Background', colors.bg, tokens),
                    _Swatch('Surface', colors.surface, tokens),
                    _Swatch('Action', colors.action, tokens),
                    _Swatch('Positive', colors.positive, tokens),
                    _Swatch('Living', colors.bucketLiving, tokens),
                    _Swatch('Guilt-free', colors.bucketFun, tokens),
                  ],
                ),
                SizedBox(height: tokens.spacing.s6),
                Text('Type', style: tokens.type.title2),
                SizedBox(height: tokens.spacing.s2),
                Text(
                  'Give every kwacha a job',
                  style: tokens.type.display.copyWith(color: colors.ink),
                ),
                Text(
                  'K 1,540',
                  style: tokens.type.amountL.copyWith(color: colors.ink),
                ),
                SizedBox(height: tokens.spacing.s6),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(tokens.spacing.s4),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(tokens.radius.lg),
                    boxShadow: tokens.shadows.card,
                  ),
                  child: Text(
                    'Spacing · ${tokens.spacing.s4.toInt()} px     '
                    'Radius · ${tokens.radius.lg.toInt()} px',
                    style: tokens.type.callout.copyWith(color: colors.ink),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Swatch extends StatelessWidget {
  const _Swatch(this.label, this.color, this.tokens);

  final String label;
  final Color color;
  final BkThemeTokens tokens;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 164,
    child: Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(tokens.radius.sm),
          ),
        ),
        SizedBox(width: tokens.spacing.s2),
        Expanded(child: Text(label, style: tokens.type.caption)),
      ],
    ),
  );
}
