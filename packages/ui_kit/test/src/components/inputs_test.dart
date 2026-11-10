import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:buckets_ui_kit/gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
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
  test('bkParseKwacha', () {
    expect(bkParseKwacha('1540'), 154000);
    expect(bkParseKwacha('1540.5'), 154050);
    expect(bkParseKwacha('0.05'), 5);
    expect(bkParseKwacha('12.'), 1200);
    expect(bkParseKwacha(''), isNull);
    expect(bkParseKwacha('.'), isNull);
    expect(bkParseKwacha('1.234'), isNull);
    expect(bkParseKwacha('1,540'), isNull);
  });

  testWidgets('BkAmountField reports ngwee; an error replaces the effect', (
    tester,
  ) async {
    int? value = 1;
    await tester.pumpWidget(
      _app(
        BkAmountField(
          ngwee: null,
          onChanged: (v) => value = v,
          effectCaption: 'Living after: K 1,955',
        ),
      ),
    );
    expect(find.text('Living after: K 1,955'), findsOneWidget);
    await tester.enterText(find.byType(TextField), '12.5');
    expect(value, 1250);
    await tester.enterText(find.byType(TextField), '');
    expect(value, isNull);
    await tester.pumpWidget(
      _app(
        BkAmountField(
          ngwee: 0,
          onChanged: (_) {},
          effectCaption: 'Living after: K 1,955',
          errorText: 'Enter more than K 0.',
        ),
      ),
    );
    expect(find.text('Enter more than K 0.'), findsOneWidget);
    expect(find.text('Living after: K 1,955'), findsNothing);
  });

  testWidgets('BkTextField edits, shows errors and follows its value', (
    tester,
  ) async {
    var value = '';
    Widget field(String v, {String? error}) => _app(
      BkTextField(
        label: 'Name',
        value: v,
        onChanged: (t) => value = t,
        errorText: error,
      ),
    );
    await tester.pumpWidget(field(''));
    expect(find.text('Name'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Rent');
    expect(value, 'Rent');
    await tester.pumpWidget(field('ZESCO', error: 'Add a name.'));
    expect(find.text('ZESCO'), findsOneWidget);
    expect(find.text('Add a name.'), findsOneWidget);
  });

  testWidgets('BkSegmented reports the tapped option', (tester) async {
    var selected = 'cash';
    await tester.pumpWidget(
      _app(
        BkSegmented<String>(
          options: const [
            BkSegment('cash', 'Cash'),
            BkSegment('paste', 'Paste', icon: BkIcons.plan),
          ],
          selected: selected,
          onChanged: (v) => selected = v,
        ),
      ),
    );
    await tester.tap(find.text('Paste'));
    expect(selected, 'paste');
  });

  testWidgets('BkChipGroup: tap, 44 targets, disabled', (tester) async {
    String? picked;
    await tester.pumpWidget(
      _app(
        BkChipGroup<String>(
          options: const [
            BkChipOption('food', 'Food'),
            BkChipOption('living', 'Living', dot: BkBucketColor.living),
          ],
          selected: 'food',
          onChanged: (v) => picked = v,
        ),
      ),
    );
    await tester.tap(find.text('Living'));
    expect(picked, 'living');
    expect(
      tester.getSize(find.byType(BkTapTarget).first).height,
      bkMinTapTarget,
    );
    picked = null;
    await tester.pumpWidget(
      _app(
        const BkChipGroup<String>(
          options: [BkChipOption('food', 'Food')],
          selected: null,
          onChanged: null,
        ),
      ),
    );
    await tester.tap(find.text('Food'));
    expect(picked, isNull);
  });

  testWidgets('rows: toggle, check, radio card, picker', (tester) async {
    var on = false;
    var checked = false;
    var radio = 0;
    var picker = 0;
    await tester.pumpWidget(
      _app(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BkToggleRow(title: 'App lock', value: on, onChanged: (v) => on = v),
            BkCheckRow(
              title: 'Gas',
              checked: checked,
              onChanged: (v) => checked = v,
            ),
            BkRadioCard(title: 'Hold', selected: false, onTap: () => radio++),
            BkRowPicker(
              label: 'Bucket',
              value: 'Living',
              onTap: () => picker++,
            ),
          ],
        ),
      ),
    );
    await tester.tap(find.text('App lock'));
    await tester.tap(find.text('Gas'));
    await tester.tap(find.text('Hold'));
    await tester.tap(find.text('Bucket'));
    expect((on, checked, radio, picker), (true, true, 1, 1));
    expect(
      tester.getSize(find.byType(BkRowPicker)).height,
      greaterThanOrEqualTo(56),
    );
  });

  testWidgets('disabled toggle row ignores taps', (tester) async {
    await tester.pumpWidget(
      _app(const BkToggleRow(title: 'Lock', value: false, onChanged: null)),
    );
    await tester.tap(find.text('Lock'));
    expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
  });

  testWidgets('BkSmsField: multi-line, Paste action, follows value, error', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    var pasted = 0;
    var text = '';
    Widget field(String value, {bool error = false}) => _app(
      BkSmsField(
        label: 'Confirmation SMS',
        pasteLabel: 'Paste',
        value: value,
        error: error,
        onChanged: (v) => text = v,
        onPaste: () => pasted++,
      ),
    );
    await tester.pumpWidget(field(''));
    final box = find.byType(TextField);
    expect(tester.getSize(box).height, 108);
    expect(tester.widget<TextField>(box).maxLines, isNull);

    await tester.enterText(box, 'line one\nline two');
    expect(text, 'line one\nline two');

    await tester.tap(find.text('Paste'));
    expect(pasted, 1);
    expect(
      tester
          .getSize(
            find.ancestor(
              of: find.text('Paste'),
              matching: find.byType(InkWell),
            ),
          )
          .height,
      greaterThanOrEqualTo(44),
    );
    final paste = tester.getSemantics(find.text('Paste'));
    expect(paste.label, 'Paste');
    expect(paste.flagsCollection.isButton, isTrue);
    expect(paste.getSemanticsData().hasAction(SemanticsAction.tap), isTrue);

    // A paste from the app replaces the text.
    await tester.pumpWidget(field('ZMW 770.00 sent', error: true));
    expect(find.text('ZMW 770.00 sent'), findsOneWidget);
    final decoration = tester.widget<TextField>(box).decoration!;
    final ctx = tester.element(box);
    expect(
      (decoration.enabledBorder! as OutlineInputBorder).borderSide.color,
      ctx.bk.colors.danger,
    );
    handle.dispose();
  });

  testWidgets('BkSmsField without onPaste hides the action', (tester) async {
    await tester.pumpWidget(
      _app(
        BkSmsField(
          label: 'Confirmation SMS',
          pasteLabel: 'Paste',
          value: '',
          onChanged: (_) {},
        ),
      ),
    );
    expect(find.text('Paste'), findsNothing);
  });

  for (final (name, theme) in [
    ('light', BucketsTheme.light),
    ('dark', BucketsTheme.dark),
  ]) {
    testWidgets('inputs golden ($name)', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 1240));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(_app(const InputsPage(), theme: theme));
      await expectLater(
        find.byType(InputsPage),
        matchesGoldenFile('goldens/inputs_$name.png'),
      );
    });
  }
}
