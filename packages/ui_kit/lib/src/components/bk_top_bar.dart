import 'package:buckets_ui_kit/src/foundation/bk_semantics.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// The top bar: a 44 button left (back or close), an optional centred
/// headline, an optional 44 action right.
///
/// ```dart
/// BkTopBar(
///   leading: BkIconButton(icon: BkIcons.back, semanticLabel: 'Back',
///       onPressed: pop),
///   title: 'Emergency',
/// )
/// ```
class BkTopBar extends StatelessWidget {
  /// Creates the bar.
  const BkTopBar({this.leading, this.title, this.trailing, super.key});

  /// Usually a back or close `BkIconButton`.
  final Widget? leading;

  /// The centred headline.
  final String? title;

  /// Usually an action `BkIconButton`.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    const slot = SizedBox.square(dimension: bkMinTapTarget);
    final t = title;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: BkSpacing.s4,
        vertical: BkSpacing.s2,
      ),
      child: Row(
        children: [
          leading ?? slot,
          Expanded(
            child: t == null
                ? const SizedBox.shrink()
                : BkHeading(
                    child: Text(
                      t,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: bk.type.headline.copyWith(color: bk.colors.ink),
                    ),
                  ),
          ),
          trailing ?? slot,
        ],
      ),
    );
  }
}
