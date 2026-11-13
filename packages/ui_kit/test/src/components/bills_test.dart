import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:buckets_ui_kit/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? BucketsTheme.light,
  home: Scaffold(body: Center(child: child)),
);

void main() {
  testWidgets('BkBillRow: tick and row taps; paid is checked', (tester) async {
    var ticks = 0;
    var taps = 0;
    await tester.pumpWidget(
      _app(
        BkBillRow(
          title: 'ZESCO',
          amountText: 'K 400',
          status: BkBillStatus.dueSoon,
          statusLabel: 'Due soon',
          onTick: () => ticks++,
          onTap: () => taps++,
        ),
      ),
    );
    expect(find.text('Due soon'), findsOneWidget);
    await tester.tap(
      find.byWidgetPredicate((w) => w is SizedBox && w.width == 44),
    );
    expect(ticks, 1);
    await tester.tap(find.text('ZESCO'));
    expect(taps, 1);

    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _app(
        const BkBillRow(
          title: 'Rent',
          amountText: 'K 2,500',
          status: BkBillStatus.paid,
          statusLabel: 'Paid',
        ),
      ),
    );
    expect(find.byType(BkIcon), findsOneWidget);
    expect(
      tester.getSemantics(find.byType(BkBillRow)),
      isSemantics(isChecked: true, hasCheckedState: true),
    );
    handle.dispose();
  });

  testWidgets('BkMonthGrid lays out three to a row', (tester) async {
    await tester.pumpWidget(
      _app(
        const BkMonthGrid(
          months: [
            (label: 'Jun', state: BkMonthState.paid, caption: 'K 420'),
            (label: 'Jul', state: BkMonthState.late, caption: 'K 380'),
            (label: 'Aug', state: BkMonthState.due, caption: 'Due 20th'),
            (label: 'Sep', state: BkMonthState.skipped, caption: 'Skipped'),
          ],
        ),
      ),
    );
    expect(find.byType(BkIcon), findsNWidgets(2)); // paid tick, late clock
    final jun = tester.getTopLeft(find.text('Jun')).dy;
    expect(tester.getTopLeft(find.text('Jul')).dy, jun);
    expect(tester.getTopLeft(find.text('Aug')).dy, jun);
    expect(tester.getTopLeft(find.text('Sep')).dy, greaterThan(jun));
  });

  testWidgets('BkProviderBar fills to its fraction', (tester) async {
    await tester.pumpWidget(
      _app(
        const SizedBox(
          width: 300,
          child: BkProviderBar(
            label: 'MTN MoMo',
            amountText: 'K 52',
            fraction: 0.5,
            color: BkBucketColor.fun,
          ),
        ),
      ),
    );
    expect(find.text('K 52'), findsOneWidget);
    expect(tester.widget<BkProgressBar>(find.byType(BkProgressBar)).value, 0.5);
  });

  for (final (name, theme) in [
    ('light', BucketsTheme.light),
    ('dark', BucketsTheme.dark),
  ]) {
    testWidgets('bills golden ($name)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 760));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_app(const BillsPage(), theme: theme));
      await expectLater(
        find.byType(BillsPage),
        matchesGoldenFile('goldens/bills_$name.png'),
      );
    });
  }
}
