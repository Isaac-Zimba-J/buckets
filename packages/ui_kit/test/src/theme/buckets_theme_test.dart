import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:buckets_ui_kit/gallery.dart';
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
      MaterialApp(
        theme: BucketsTheme.light,
        home: const Scaffold(body: SingleChildScrollView(child: TokensPage())),
      ),
    );

    await expectLater(
      find.byType(TokensPage),
      matchesGoldenFile('goldens/token_sheet_light.png'),
    );
  });

  testWidgets('dark token sheet golden', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: BucketsTheme.dark,
        home: const Scaffold(body: SingleChildScrollView(child: TokensPage())),
      ),
    );

    await expectLater(
      find.byType(TokensPage),
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
