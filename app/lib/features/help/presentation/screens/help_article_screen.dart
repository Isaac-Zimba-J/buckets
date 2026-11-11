import 'dart:async';

import 'package:buckets/features/help/presentation/controllers/help_article_controller.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 30 Help article.
class HelpArticleScreen extends ConsumerWidget {
  /// Creates the screen for [articleId].
  const HelpArticleScreen({required this.articleId, super.key});

  /// The article to show.
  final String articleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final provider = helpArticleControllerProvider(articleId);
    final value = ref.watch(provider);
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.go(Routes.help),
        ),
      ),
      children: [
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(provider),
          data: (s) => _Body(articleId: articleId, state: s),
        ),
      ],
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.articleId, required this.state});

  final String articleId;
  final HelpArticleState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final a = state.article;
    final n = ref.read(helpArticleControllerProvider(articleId).notifier);
    final paragraphs = a.body
        .split('\n')
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();
    final showSettings = a.keywords.contains('alert');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (a.keywords.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: BkSpacing.s2),
            child: BkHeading(
              child: Text(
                a.keywords.first.toUpperCase(),
                style: bk.type.overline.copyWith(color: bk.colors.inkMuted),
              ),
            ),
          ),
        BkHeading(
          child: Text(
            a.title,
            style: bk.type.title1.copyWith(color: bk.colors.ink),
          ),
        ),
        const BkGap(BkSpacing.s4),
        BkCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final p in paragraphs) ...[
                Text(p, style: bk.type.body.copyWith(color: bk.colors.ink)),
                const BkGap(BkSpacing.s3),
              ],
              if (showSettings)
                BkButton.secondary(
                  label: l.helpOpenSettings,
                  onPressed: () => unawaited(n.openNotificationAccess()),
                ),
            ],
          ),
        ),
        const BkGap(BkSpacing.s5),
        Row(
          children: [
            Expanded(
              child: Text(
                l.helpDidThisHelp,
                style: bk.type.headline.copyWith(color: bk.colors.ink),
              ),
            ),
            const BkGap(BkSpacing.s2),
            if (state.feedbackGiven)
              Text(
                l.helpThanks,
                style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
              )
            else ...[
              BkChip(
                label: l.helpYes,
                selected: false,
                onTap: () => unawaited(n.recordFeedback(helpful: true)),
              ),
              const BkGap(BkSpacing.s2),
              BkChip(
                label: l.helpNo,
                selected: false,
                onTap: () => unawaited(n.recordFeedback(helpful: false)),
              ),
            ],
          ],
        ),
        const BkGap(BkSpacing.s6),
      ],
    );
  }
}
