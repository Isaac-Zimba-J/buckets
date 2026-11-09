import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:buckets_ui_kit/gallery.dart';
import 'package:buckets_ui_kit_gallery/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Some pages show a spinner, so pump for a while instead of settling.
Future<void> _show(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
}

void main() {
  testWidgets('lists every page and opens each in both themes', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 1400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const GalleryApp());
    for (final mode in ['Light', 'Dark']) {
      await tester.tap(find.text(mode));
      await _show(tester);
      for (final (title, page) in galleryPages) {
        await tester.tap(find.text(title));
        await _show(tester);
        expect(find.byWidget(page), findsOneWidget, reason: title);
        expect(tester.takeException(), isNull, reason: '$title ($mode)');
        await tester.tap(find.byType(BkIconButton).first);
        await _show(tester);
      }
    }
  });
}
