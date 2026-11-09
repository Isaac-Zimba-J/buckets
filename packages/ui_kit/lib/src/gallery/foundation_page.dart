import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

const List<BkIcons> _tabs = [
  BkIcons.home,
  BkIcons.goals,
  BkIcons.plan,
  BkIcons.me,
];

/// Every icon, then the filled tab icons.
class IconSheet extends StatelessWidget {
  /// Creates the sheet.
  const IconSheet({super.key});

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

/// Gallery page: Foundation in light or dark, every state.
class FoundationPage extends StatelessWidget {
  /// Creates the page.
  const FoundationPage({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.bk.colors.bg,
    child: const Padding(
      padding: EdgeInsets.all(BkSpacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconSheet(),
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
