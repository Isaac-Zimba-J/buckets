import 'package:buckets/features/me/presentation/controllers/me_controller.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/tab_scaffold.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 24 Me: profile summary and links to settings, rules, help and
/// about.
class MeScreen extends ConsumerWidget {
  /// Creates the screen.
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(meControllerProvider);
    return TabScaffold(
      tab: AppTab.me,
      body: ListView(
        padding: const EdgeInsets.all(BkSpacing.s4),
        children: [
          AsyncBody(
            value: value,
            onRetry: () => ref.invalidate(meControllerProvider),
            data: (s) => _Body(state: s),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final MeState state;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final s = state;
    void go(String route) => context.go(route);
    final greeting = s.summary.displayName == null
        ? s.summary.greeting.word
        : '${s.summary.greeting.word}, ${s.summary.displayName}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const BkGap(BkSpacing.s2),
        Row(
          children: [
            BkAvatar(initial: s.summary.avatarInitial),
            const BkGap(BkSpacing.s4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: bk.type.title2.copyWith(color: bk.colors.ink),
                  ),
                  Text(
                    l.meEditProfile,
                    style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
                  ),
                ],
              ),
            ),
            BkIconButton(
              icon: BkIcons.chevronRight,
              semanticLabel: l.meEditProfile,
              onPressed: () => go(Routes.meProfile),
            ),
          ],
        ),
        _Section(l.meMoney),
        BkListGroup(
          children: [
            _Link(l.meIncomeSources, () => go(Routes.meIncome)),
            _Link(l.meBills, () => go(Routes.meBills)),
            for (final i in s.incomes)
              _Link(l.meSplitOf(i.name), () => go(Routes.meSplit(i.id))),
            _Link(l.meBucketsAccounts, () => go(Routes.meAccounts)),
            _Link(l.meRules, () => go(Routes.meRules)),
          ],
        ),
        _Section(l.meSettingsSection),
        BkListGroup(
          children: [
            BkSettingsRow(
              title: l.meSettings,
              leadingIcon: BkIcons.clock,
              onTap: () => go(Routes.meSettings),
            ),
          ],
        ),
        _Section(l.meSupport),
        BkListGroup(
          children: [
            BkSettingsRow(
              title: l.meHelp,
              leadingIcon: BkIcons.info,
              onTap: () => go(Routes.help),
            ),
            BkSettingsRow(
              title: l.meReport,
              leadingIcon: BkIcons.warning,
              onTap: () => go(Routes.helpReport),
            ),
            BkSettingsRow(title: l.meAboutApp, onTap: () => go(Routes.meAbout)),
          ],
        ),
        const BkGap(BkSpacing.s8),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return Padding(
      padding: const EdgeInsets.only(top: BkSpacing.s5, bottom: BkSpacing.s2),
      child: BkHeading(
        child: Text(
          title.toUpperCase(),
          style: bk.type.overline.copyWith(color: bk.colors.inkMuted),
        ),
      ),
    );
  }
}

class _Link extends StatelessWidget {
  const _Link(this.title, this.onTap);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) =>
      BkListRow(title: title, chevron: true, onTap: onTap);
}
