import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/widgets.dart';

/// Setup steps 01b and 02–06 show "n of 6" with progress; the same
/// from Me show a plain top bar with the title.
Widget setupHeader(
  BuildContext context, {
  required int step,
  required bool fromMe,
  required String title,
  required VoidCallback? onBack,
}) {
  final l = AppLocalizations.of(context);
  if (fromMe) {
    return BkTopBar(
      leading: BkIconButton(
        icon: BkIcons.back,
        semanticLabel: l.back,
        onPressed: onBack,
      ),
      title: title,
    );
  }
  return BkFlowHeader(
    step: step,
    total: 6,
    stepLabel: l.stepOf(step, 6),
    backLabel: l.back,
    onBack: onBack,
  );
}

/// The screen title inside setup flows (title1).
class SetupTitle extends StatelessWidget {
  /// Creates the title.
  const SetupTitle(this.text, {this.intro, super.key});

  /// The title.
  final String text;

  /// An optional muted sentence below.
  final String? intro;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final i = intro;
    return Padding(
      padding: const EdgeInsets.only(bottom: BkSpacing.s5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BkHeading(
            child: Text(
              text,
              style: bk.type.title1.copyWith(color: bk.colors.ink),
            ),
          ),
          if (i != null) ...[
            const BkGap(BkSpacing.s2),
            Text(i, style: bk.type.body.copyWith(color: bk.colors.inkMuted)),
          ],
        ],
      ),
    );
  }
}
