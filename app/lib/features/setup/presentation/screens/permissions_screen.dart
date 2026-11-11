import 'package:buckets/features/setup/presentation/controllers/permissions_controller.dart';
import 'package:buckets/features/setup/presentation/widgets/setup_header.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 06 Alarms & alerts: the last setup step.
class PermissionsScreen extends ConsumerWidget {
  /// Creates the screen; [fromMe] when opened from the Me tab.
  const PermissionsScreen({this.fromMe = false, super.key});

  /// Opened from Me rather than setup.
  final bool fromMe;

  Future<void> _finish(BuildContext context, WidgetRef ref) async {
    final ok = await ref
        .read(permissionsControllerProvider.notifier)
        .complete();
    if (ok && context.mounted) context.go(Routes.home);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(permissionsControllerProvider);
    final notifier = ref.read(permissionsControllerProvider.notifier);
    return ScreenFrame(
      header: setupHeader(
        context,
        step: 6,
        fromMe: fromMe,
        title: l.permsTitle,
        onBack: () => context.go(fromMe ? Routes.me : Routes.setupAccounts),
      ),
      actions: [
        if (!fromMe)
          BkButton.primary(
            label: l.permsFinish,
            loading: value.value?.completing ?? false,
            onPressed: () => _finish(context, ref),
          ),
      ],
      children: [
        if (!fromMe) SetupTitle(l.permsTitle),
        BkBanner(tone: BkTone.info, message: l.permsInfo),
        const BkGap(BkSpacing.s4),
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(permissionsControllerProvider),
          data: (s) {
            final blocked = s.permissions.entries
                .where((e) => e.value == PermissionState.blocked)
                .map((e) => e.key)
                .firstOrNull;
            final rows = [
              (
                AppPermission.notifications,
                l.permNotifications,
                l.permNotificationsSub,
                BkIcons.notifications,
              ),
              (
                AppPermission.notificationAccess,
                l.permAccess,
                l.permAccessSub,
                BkIcons.info,
              ),
              (
                AppPermission.exactAlarms,
                l.permExact,
                l.permExactSub,
                BkIcons.clock,
              ),
            ];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (s.errorCode case final code?) ...[
                  BkBanner(tone: BkTone.danger, message: errorText(l, code)),
                  const BkGap(BkSpacing.s3),
                ],
                if (blocked != null) ...[
                  BkBanner(tone: BkTone.warning, message: l.permsDenied),
                  const BkGap(BkSpacing.s2),
                  BkButton.secondary(
                    label: l.permsOpenSettings,
                    onPressed: () => notifier.openSettings(blocked),
                  ),
                  const BkGap(BkSpacing.s3),
                ],
                BkCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (final (p, title, sub, icon) in rows)
                        if (s.permissions[p] case final state?)
                          BkToggleRow(
                            title: title,
                            subtitle: sub,
                            leadingIcon: icon,
                            value: state == PermissionState.granted,
                            onChanged: state == PermissionState.granted
                                ? null
                                : (_) => notifier.request(p),
                          ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
