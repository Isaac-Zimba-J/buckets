import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/widgets.dart';

/// Title (headline) over an optional subtitle (caption, `ink-muted`): the
/// left side of every list row. Internal to ui_kit.
class RowText extends StatelessWidget {
  /// Creates the text block.
  const RowText({required this.title, this.subtitle, super.key});

  /// The main line.
  final String title;

  /// The muted second line.
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: bk.type.headline.copyWith(color: bk.colors.ink)),
        if (subtitle case final s?)
          Text(s, style: bk.type.caption.copyWith(color: bk.colors.inkMuted)),
      ],
    );
  }
}
