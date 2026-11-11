import 'package:buckets/bootstrap/app_config.dart';
import 'package:buckets/features/help/presentation/controllers/report_controller.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 31 Report a problem. Opens the email app; the app sends nothing
/// itself (R-SUPPORT-1).
class ReportScreen extends ConsumerWidget {
  /// Creates the screen.
  const ReportScreen({super.key});

  String _catLabel(AppLocalizations l, ProblemCategory c) => switch (c) {
    ProblemCategory.somethingWrong => l.reportCatBroke,
    ProblemCategory.idea => l.reportCatIdea,
    ProblemCategory.question => l.reportCatQuestion,
    ProblemCategory.other => l.reportCatOther,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final s = ref.watch(reportControllerProvider);
    final n = ref.read(reportControllerProvider.notifier);

    Future<void> send() async {
      if (await n.send() && context.mounted) {
        showBkToast(context, message: l.reportSent);
        context.go(Routes.help);
      }
    }

    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.go(Routes.me),
        ),
        title: l.meReport,
      ),
      actions: [
        BkButton.primary(
          label: l.reportOpenEmail,
          onPressed: s.text.trim().isEmpty ? null : send,
          disabledReason: s.text.trim().isEmpty ? l.reportNeedsText : null,
        ),
      ],
      children: [
        Text(
          l.reportWhat,
          style: bk.type.callout.copyWith(
            color: bk.colors.ink,
            fontWeight: FontWeight.w600,
          ),
        ),
        const BkGap(BkSpacing.s2),
        BkChipGroup<ProblemCategory>(
          options: [
            for (final c in ProblemCategory.values)
              BkChipOption(c, _catLabel(l, c)),
          ],
          selected: s.category,
          onChanged: n.setCategory,
        ),
        const BkGap(BkSpacing.s5),
        BkTextField(
          label: l.reportWhatHappened,
          hint: l.reportHint,
          value: s.text,
          onChanged: n.setText,
          maxLines: 5,
        ),
        const BkGap(BkSpacing.s2),
        Text(
          l.reportCaption,
          style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
        ),
        const BkGap(BkSpacing.s4),
        BkListGroup(
          children: [
            BkToggleRow(
              title: l.reportAttach,
              subtitle: l.reportAttachBody,
              value: s.includeAppInfo,
              onChanged: (v) => n.setIncludeAppInfo(include: v),
            ),
          ],
        ),
        const BkGap(BkSpacing.s4),
        if (s.errorCode == 'email.noApp')
          BkBanner(
            tone: BkTone.danger,
            message: l.reportNoEmail(AppConfig.supportEmail),
          )
        else
          BkBanner(tone: BkTone.info, message: l.reportInfo),
        const BkGap(BkSpacing.s6),
      ],
    );
  }
}
