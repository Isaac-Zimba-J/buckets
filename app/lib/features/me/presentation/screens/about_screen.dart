import 'dart:async';

import 'package:buckets/features/me/presentation/controllers/about_controller.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 32 About.
class AboutScreen extends ConsumerWidget {
  /// Creates the screen.
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(aboutControllerProvider);
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.go(Routes.me),
        ),
        title: l.meAboutApp,
      ),
      children: [
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(aboutControllerProvider),
          data: (info) => _Body(info: info),
        ),
      ],
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.info});

  final AppInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const BkGap(BkSpacing.s5),
        Center(
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: bk.colors.hero,
              borderRadius: BorderRadius.circular(bk.radius.xl),
            ),
            child: Icon(Icons.account_balance_wallet, color: bk.colors.accent),
          ),
        ),
        const BkGap(BkSpacing.s4),
        Text(
          l.appName,
          textAlign: TextAlign.center,
          style: bk.type.title1.copyWith(color: bk.colors.ink),
        ),
        const BkGap(BkSpacing.s1),
        Text(
          l.aboutVersion(info.appVersion, info.buildNumber),
          textAlign: TextAlign.center,
          style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
        ),
        const BkGap(BkSpacing.s2),
        Text(
          l.aboutTagline,
          textAlign: TextAlign.center,
          style: bk.type.body.copyWith(color: bk.colors.inkMuted),
        ),
        const BkGap(BkSpacing.s5),
        BkListGroup(
          children: [
            BkSettingsRow(
              title: l.aboutPrivacy,
              subtitle: l.aboutPrivacyBody,
              leadingIcon: BkIcons.lock,
              onTap: () => context.go(Routes.helpArticle('your-data')),
            ),
            BkSettingsRow(
              title: l.aboutHow,
              subtitle: l.aboutHowBody,
              leadingIcon: BkIcons.info,
              onTap: () => context.go(Routes.helpArticle('how-payday-works')),
            ),
            BkSettingsRow(
              title: l.aboutRate,
              leadingIcon: BkIcons.streak,
              onTap: () => unawaited(
                ref.read(aboutControllerProvider.notifier).openStoreListing(),
              ),
            ),
            BkSettingsRow(
              title: l.aboutLicences,
              leadingIcon: BkIcons.plan,
              onTap: () => showLicensePage(
                context: context,
                applicationName: l.appName,
                applicationVersion: info.appVersion,
              ),
            ),
          ],
        ),
        const BkGap(BkSpacing.s4),
        Text(
          l.aboutDisclaimer,
          textAlign: TextAlign.center,
          style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
        ),
        const BkGap(BkSpacing.s6),
      ],
    );
  }
}
