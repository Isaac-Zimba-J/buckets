import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// Gallery page: Inputs in light or dark, every state.
class InputsPage extends StatelessWidget {
  /// Creates the page.
  const InputsPage({super.key});

  @override
  Widget build(BuildContext context) {
    void none(Object? _) {}
    return ColoredBox(
      color: context.bk.colors.bg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BkTextField(label: 'Name', value: 'Rent', onChanged: none),
          const BkGap(BkSpacing.s2),
          BkTextField(
            label: 'Amount',
            value: '0',
            onChanged: none,
            errorText: 'Enter more than K 0.',
          ),
          BkAmountField(
            ngwee: 154000,
            onChanged: none,
            effectCaption: 'Living after: K 1,955',
          ),
          BkSegmented<int>(
            options: const [BkSegment(0, 'Cash'), BkSegment(1, 'Paste')],
            selected: 0,
            onChanged: none,
          ),
          BkChipGroup<int>(
            options: const [
              BkChipOption(0, 'Food'),
              BkChipOption(1, 'Living', dot: BkBucketColor.living),
              BkChipOption(2, 'Transport'),
            ],
            selected: 1,
            onChanged: none,
          ),
          BkToggleRow(
            title: 'App lock',
            subtitle: 'Ask for your fingerprint',
            leadingIcon: BkIcons.lock,
            value: true,
            onChanged: none,
          ),
          BkCheckRow(
            title: 'Gas',
            checked: true,
            onChanged: none,
            trailing: const BkMoneyText(ngwee: 35000),
          ),
          BkCheckRow(title: 'Shoes', checked: false, onChanged: none),
          BkRadioCard(
            title: 'Hold until month end',
            subtitle: 'Split on 31 Oct',
            selected: true,
            onTap: () {},
          ),
          const BkGap(BkSpacing.s2),
          BkRadioCard(title: 'Split it now', selected: false, onTap: () {}),
          BkRowPicker(
            label: 'Bucket',
            value: 'Living',
            dot: BkBucketColor.living,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
