import 'dart:async';

import 'package:buckets/features/me/presentation/controllers/me_controller.dart';
import 'package:buckets/features/me/presentation/widgets/habit_settings.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/tab_scaffold.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The Me tab: income, bills, splits, buckets and accounts, alerts, the
/// app lock, payday and spending habits, about and privacy (SCREENS.md).
class MeScreen extends ConsumerWidget {
  /// Creates the screen.
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final value = ref.watch(meControllerProvider);
    return TabScaffold(
      tab: AppTab.me,
      body: ListView(
        padding: const EdgeInsets.all(BkSpacing.s4),
        children: [
          BkHeading(
            child: Text(
              l.meTitle,
              style: bk.type.title1.copyWith(color: bk.colors.ink),
            ),
          ),
          const BkGap(BkSpacing.s4),
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

class _Body extends ConsumerWidget {
  const _Body({required this.state});

  final MeState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final s = state;
    final notifier = ref.read(meControllerProvider.notifier);
    void go(String route) => context.go(route);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (s.errorCode case final code?) ...[
          BkBanner(tone: BkTone.danger, message: errorText(l, code)),
          const BkGap(BkSpacing.s4),
        ],
        _Section(l.meMoney),
        BkListGroup(
          children: [
            _Link(l.meIncomeSources, () => go(Routes.meIncome)),
            _Link(l.meBills, () => go(Routes.meBills)),
            for (final i in s.incomes)
              _Link(l.meSplitOf(i.name), () => go(Routes.meSplit(i.id))),
            _Link(l.meBucketsAccounts, () => go(Routes.meAccounts)),
          ],
        ),
        _Section(l.meAlerts),
        BkListGroup(
          children: [
            _Link(l.meNotifications, () => go(Routes.meNotifications)),
          ],
        ),
        _Section(l.meSecurity),
        BkListGroup(
          children: [
            BkToggleRow(
              title: l.meAppLock,
              subtitle: l.meAppLockBody,
              leadingIcon: BkIcons.lock,
              value: s.appLock,
              onChanged: (v) => unawaited(notifier.setAppLock(enabled: v)),
            ),
          ],
        ),
        _Section(l.meHabits),
        HabitSettings(state: s),
        _Section(l.meAbout),
        BkCard(
          child: Text(
            l.meAboutBody,
            style: context.bk.type.body.copyWith(color: context.bk.colors.ink),
          ),
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
