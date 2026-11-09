import 'package:buckets_ui_kit/src/foundation/bk_gap.dart';
import 'package:buckets_ui_kit/src/foundation/bk_icon.dart';
import 'package:buckets_ui_kit/src/foundation/bk_tone.dart';
import 'package:buckets_ui_kit/src/theme/bk_context.dart';
import 'package:buckets_ui_kit/src/tokens/bk_spacing.g.dart';
import 'package:flutter/widgets.dart';

/// A tinted message at the top of the area it is about: what happened and
/// what to do. Danger banners are announced (live region).
///
/// ```dart
/// BkBanner(tone: BkTone.danger, message: "Couldn't save. Try again.")
/// ```
class BkBanner extends StatelessWidget {
  /// Creates the banner.
  const BkBanner({
    required this.tone,
    required this.message,
    this.title,
    super.key,
  });

  /// Its meaning and colours.
  final BkTone tone;

  /// An optional bold first line.
  final String? title;

  /// The message.
  final String message;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final fg = tone.foreground(context);
    final style = bk.type.callout.copyWith(color: fg);
    return Semantics(
      liveRegion: tone == BkTone.danger,
      container: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(BkSpacing.s3),
        decoration: BoxDecoration(
          color: tone.tint(context),
          borderRadius: BorderRadius.circular(bk.radius.md),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BkIcon(tone.icon, size: 20, color: fg),
            const BkGap(BkSpacing.s2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title case final t?)
                    Text(t, style: style.copyWith(fontWeight: FontWeight.w600)),
                  Text(message, style: style),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
