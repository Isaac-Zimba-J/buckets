import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icons.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:flutter/widgets.dart';

/// A round profile avatar: an ink circle with the accent initial, or a
/// neutral icon when there is no name (R-PROFILE-3).
///
/// ```dart
/// BkAvatar(initial: 'I')
/// ```
class BkAvatar extends StatelessWidget {
  /// Creates the avatar.
  const BkAvatar({this.initial, this.size = 48, super.key});

  /// The first letter of the name, upper-cased; null shows a neutral icon.
  final String? initial;

  /// Diameter in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bk.colors.ink, shape: BoxShape.circle),
      child: initial == null
          ? BkIcon(BkIcons.me, size: size * 0.5, color: bk.colors.accent)
          : Text(
              initial!,
              style: bk.type.title2.copyWith(color: bk.colors.accent),
            ),
    );
  }
}
