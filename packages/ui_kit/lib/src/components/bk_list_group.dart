import 'package:buckets_ui_kit/src/components/bk_card.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/material.dart';

/// A surface card of rows divided by 1px `line` hairlines.
///
/// ```dart
/// BkListGroup(children: [BkListRow(title: 'Rent'),
///     BkListRow(title: 'ZESCO')])
/// ```
class BkListGroup extends StatelessWidget {
  /// Groups [children], usually `BkListRow`s.
  const BkListGroup({required this.children, super.key});

  /// The rows.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => BkCard(
    padding: EdgeInsets.zero,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(context.bk.radius.lg),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final (i, row) in children.indexed) ...[
              if (i > 0) Divider(height: 1, color: context.bk.colors.line),
              row,
            ],
          ],
        ),
      ),
    ),
  );
}
