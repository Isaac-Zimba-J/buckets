import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/l10n/app_localizations_en.dart';
import 'package:buckets/main.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';

/// English strings, as the screens show them.
final AppLocalizations l = AppLocalizationsEn();

/// A container on fakes for screen tests.
ProviderContainer fakeContainer([List<Override> extra = const []]) =>
    ProviderContainer(
      overrides: [...fakePortOverrides(), ...extra],
      retry: retryUnlessFailure,
    );

/// The whole app (router included) on [c].
Future<void> pumpApp(WidgetTester tester, ProviderContainer c) async {
  await tester.binding.setSurfaceSize(const Size(400, 900));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    UncontrolledProviderScope(container: c, child: const BucketsApp()),
  );
  await tester.pumpAndSettle();
}

/// One screen without the router, themed and localised.
Future<void> pumpScreen(
  WidgetTester tester,
  ProviderContainer c,
  Widget screen,
) async {
  await tester.binding.setSurfaceSize(const Size(400, 900));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: c,
      child: MaterialApp(
        theme: BucketsTheme.light,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: screen,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Types [text] into the `BkTextField` labelled [label].
Future<void> type(WidgetTester tester, String label, String text) async {
  final field = find.descendant(
    of: find.ancestor(of: find.text(label), matching: find.byType(BkTextField)),
    matching: find.byType(TextField),
  );
  await tester.enterText(field.last, text);
  await tester.pump();
}

/// Types [text] into the only (or last) amount field.
Future<void> typeAmount(WidgetTester tester, String text) async {
  await tester.enterText(
    find
        .descendant(
          of: find.byType(BkAmountField),
          matching: find.byType(TextField),
        )
        .last,
    text,
  );
  await tester.pump();
}

/// Scrolls [finder] into view, taps it and settles.
Future<void> tapOn(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Lets live (stream) controllers deliver: their reads hop through the
/// real event loop, so alternate short real waits with frames.
Future<void> settleStreams(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 20)),
    );
    await tester.pump();
  }
  await tester.pumpAndSettle();
}
