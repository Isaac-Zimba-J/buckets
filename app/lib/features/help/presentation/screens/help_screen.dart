import 'package:buckets/features/help/presentation/controllers/help_controller.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 29 Help: search and topic cards over the bundled articles.
class HelpScreen extends ConsumerWidget {
  /// Creates the screen.
  const HelpScreen({super.key});

  static BkIcons _icon(String id) => switch (id) {
    'how-payday-works' => BkIcons.clock,
    'proving-a-transfer' => BkIcons.check,
    'sorting-payments' => BkIcons.notifications,
    'scanning-receipts' => BkIcons.camera,
    'app-lock' => BkIcons.lock,
    _ => BkIcons.info,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(helpControllerProvider);
    final n = ref.read(helpControllerProvider.notifier);
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.go(Routes.me),
        ),
        title: l.meHelp,
      ),
      children: [
        BkSearchField(hint: l.helpSearch, onChanged: n.search),
        const BkGap(BkSpacing.s4),
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(helpControllerProvider),
          data: (s) => _Body(state: s),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final HelpState state;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final items = state.results;
    void open(String id) => context.go(Routes.helpArticle(id));
    if (state.query.isNotEmpty && items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: BkSpacing.s6),
        child: BkEmptyState(
          icon: BkIcons.info,
          title: l.helpNoResultsTitle,
          message: l.helpNoResults,
          actionLabel: l.meReport,
          onAction: () => context.go(Routes.helpReport),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < items.length; i += 2)
          Padding(
            padding: const EdgeInsets.only(bottom: BkSpacing.s3),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _TopicCard(article: items[i], onTap: open),
                  ),
                  const BkGap(BkSpacing.s3),
                  if (i + 1 < items.length)
                    Expanded(
                      child: _TopicCard(article: items[i + 1], onTap: open),
                    )
                  else
                    const Expanded(child: SizedBox()),
                ],
              ),
            ),
          ),
        const BkGap(BkSpacing.s3),
        _ReportCta(onTap: () => context.go(Routes.helpReport)),
        const BkGap(BkSpacing.s6),
      ],
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.article, required this.onTap});

  final HelpArticle article;
  final void Function(String id) onTap;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return InkWell(
      onTap: () => onTap(article.id),
      borderRadius: BorderRadius.circular(bk.radius.lg),
      child: BkCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: bk.colors.surfaceSunken,
                borderRadius: BorderRadius.circular(bk.radius.sm),
              ),
              child: BkIcon(HelpScreen._icon(article.id), size: 22),
            ),
            const BkGap(BkSpacing.s4),
            Text(
              article.title,
              style: bk.type.headline.copyWith(color: bk.colors.ink),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReportCta extends StatelessWidget {
  const _ReportCta({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final l = AppLocalizations.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(bk.radius.lg),
      child: Semantics(
        button: true,
        child: Container(
          padding: const EdgeInsets.all(BkSpacing.s4),
          decoration: BoxDecoration(
            color: bk.colors.hero,
            borderRadius: BorderRadius.circular(bk.radius.lg),
          ),
          child: Row(
            children: [
              BkIcon(BkIcons.info, size: 22, color: bk.colors.accent),
              const BkGap(BkSpacing.s3),
              Expanded(
                child: Text(
                  l.helpReportCta,
                  style: bk.type.headline.copyWith(color: bk.colors.onHero),
                ),
              ),
              BkIcon(
                BkIcons.chevronRight,
                size: 20,
                color: bk.colors.onHeroMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
