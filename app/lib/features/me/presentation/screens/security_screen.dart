import 'dart:async';

import 'package:buckets/features/me/presentation/controllers/security_controller.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 26 Security: the phone's own screen lock, timeout and hide amounts.
class SecurityScreen extends ConsumerWidget {
  /// Creates the screen.
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(securityControllerProvider);
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.go(Routes.meSettings),
        ),
        title: l.meSecurity,
      ),
      children: [
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(securityControllerProvider),
          data: (s) => _Body(state: s),
        ),
      ],
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.state});

  final SecurityState state;

  String _timeoutLabel(AppLocalizations l, LockTimeout t) => switch (t) {
    LockTimeout.immediately => l.lockImmediately,
    LockTimeout.oneMinute => l.lockOneMinute,
    LockTimeout.fiveMinutes => l.lockFiveMinutes,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final s = state;
    final n = ref.read(securityControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkListGroup(
          children: [
            BkToggleRow(
              title: l.meAppLock,
              subtitle: s.lockAvailable ? l.meAppLockBody : l.securityNoLock,
              leadingIcon: BkIcons.lock,
              value: s.appLock,
              onChanged: s.lockAvailable
                  ? (v) => unawaited(n.setAppLock(enabled: v))
                  : null,
            ),
            if (s.appLock)
              BkSegmented<LockTimeout>(
                options: [
                  for (final t in LockTimeout.values)
                    BkSegment(t, _timeoutLabel(l, t)),
                ],
                selected: s.lockTimeout,
                onChanged: (t) => unawaited(n.setLockTimeout(t)),
              ),
          ],
        ),
        const BkGap(BkSpacing.s4),
        BkListGroup(
          children: [
            BkToggleRow(
              title: l.securityHideAmounts,
              subtitle: l.securityHideAmountsBody,
              value: s.hideAmounts,
              onChanged: (v) => unawaited(n.setHideAmounts(hidden: v)),
            ),
          ],
        ),
        const BkGap(BkSpacing.s4),
        BkBanner(tone: BkTone.info, message: l.securityInfo),
      ],
    );
  }
}
