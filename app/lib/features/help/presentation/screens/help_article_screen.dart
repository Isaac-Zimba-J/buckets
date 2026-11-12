import 'dart:async';

import 'package:buckets/features/help/presentation/controllers/help_article_controller.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 30 Help article: paragraphs or numbered steps, with a feedback row.
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
    final overline = a.topic ?? a.keywords.firstOrNull;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (overline != null)
          Padding(
            padding: const EdgeInsets.only(bottom: BkSpacing.s2),
            child: BkHeading(
              child: Text(
                overline.toUpperCase(),
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
        const BkGap(BkSpacing.s3),
        Text(a.body, style: bk.type.body.copyWith(color: bk.colors.inkMuted)),
        const BkGap(BkSpacing.s4),
        if (a.steps.isNotEmpty)
          _StepsCard(steps: a.steps, controller: n)
        else
          _ParagraphsCard(body: a.body),
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

class _StepsCard extends StatelessWidget {
  const _StepsCard({required this.steps, required this.controller});

  final List<HelpStep> steps;
  final HelpArticleController controller;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return BkCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < steps.length; i++) ...[
            if (i > 0) Divider(height: 1, thickness: 1, color: bk.colors.line),
            _StepRow(index: i + 1, step: steps[i], controller: controller),
          ],
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.index,
    required this.step,
    required this.controller,
  });

  final int index;
  final HelpStep step;
  final HelpArticleController controller;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return Padding(
      padding: const EdgeInsets.all(BkSpacing.s4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: bk.colors.ink,
              shape: BoxShape.circle,
            ),
            child: Text(
              '$index',
              style: bk.type.callout.copyWith(
                color: bk.colors.surface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const BkGap(BkSpacing.s3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step.title,
                  style: bk.type.headline.copyWith(color: bk.colors.ink),
                ),
                const BkGap(BkSpacing.s1),
                Text(
                  step.body,
                  style: bk.type.body.copyWith(color: bk.colors.inkMuted),
                ),
                if (step.actionKind != HelpStepActionKind.none &&
                    step.actionLabel != null) ...[
                  const BkGap(BkSpacing.s3),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: BkButton.primary(
                      label: step.actionLabel!,
                      onPressed: () => unawaited(_runAction(step.actionKind)),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _runAction(HelpStepActionKind kind) => switch (kind) {
    HelpStepActionKind.openNotificationAccess =>
      controller.openNotificationAccess(),
    HelpStepActionKind.openBatterySettings => controller.openBatterySettings(),
    HelpStepActionKind.none => Future<void>.value(),
  };
}

class _ParagraphsCard extends StatelessWidget {
  const _ParagraphsCard({required this.body});

  final String body;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final paragraphs = body
        .split('\n')
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();
    return BkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < paragraphs.length; i++) ...[
            Text(
              paragraphs[i],
              style: bk.type.body.copyWith(color: bk.colors.ink),
            ),
            if (i < paragraphs.length - 1) const BkGap(BkSpacing.s3),
          ],
        ],
      ),
    );
  }
}
