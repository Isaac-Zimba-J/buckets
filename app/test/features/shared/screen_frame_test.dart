import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ScreenFrame keeps its actions above the keyboard', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(400, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: BucketsTheme.light,
        home: ScreenFrame(
          header: const BkTopBar(title: 'Log'),
          actions: [BkButton.primary(label: 'Save', onPressed: () {})],
          children: [BkTextField(label: 'Note', value: '', onChanged: (_) {})],
        ),
      ),
    );
    final closed = tester.getBottomLeft(find.text('Save')).dy;
    tester.view.viewInsets = FakeViewPadding(
      bottom: 300 * tester.view.devicePixelRatio,
    );
    addTearDown(tester.view.resetViewInsets);
    await tester.pumpAndSettle();
    final open = tester.getBottomLeft(find.text('Save')).dy;
    expect(open, lessThan(900.0 - 300));
    expect(open, lessThan(closed));
  });

  testWidgets('a toast sits above the actions, not on them', (tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      MaterialApp(
        theme: BucketsTheme.light,
        home: Builder(
          builder: (context) => ScreenFrame(
            header: const BkTopBar(title: 'Log'),
            actions: [
              BkButton.primary(
                label: 'Save',
                onPressed: () => showBkToast(context, message: 'Saved'),
              ),
            ],
            children: const [],
          ),
        ),
      ),
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    final toast = tester.getRect(find.byType(SnackBar));
    final save = tester.getRect(find.widgetWithText(BkButton, 'Save'));
    expect(toast.bottom, lessThanOrEqualTo(save.top));
  });
}
