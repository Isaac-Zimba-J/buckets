import 'dart:async';

import 'package:buckets/features/me/presentation/controllers/settings_controller.dart';
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

/// Screen 25 Settings.
class SettingsScreen extends ConsumerWidget {
  /// Creates the screen.
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(settingsControllerProvider);
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.go(Routes.me),
        ),
        title: l.meSettings,
      ),
      children: [
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(settingsControllerProvider),
          data: (s) => _Body(state: s),
        ),
      ],
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.state});

  final SettingsState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final s = state.settings;
    final n = ref.read(settingsControllerProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Section(l.settingsReminders),
        BkListGroup(
          children: [
            BkListRow(
              title: l.meSnoozes,
              subtitle: l.meSnoozesBody,
              trailing: Text('${s.snoozeLimit}', style: _value(context)),
            ),
            BkListRow(
              title: l.settingsQuietHours,
              trailing: Text(
                '${_time(s.quietHours.start)}–${_time(s.quietHours.end)}',
                style: _value(context),
              ),
            ),
            BkListRow(
              title: l.settingsCheckIn,
              trailing: Text(_time(s.checkInTime), style: _value(context)),
            ),
            BkToggleRow(
              title: l.settingsBillReminders,
              subtitle: l.settingsBillRemindersBody,
              value: s.billReminders,
              onChanged: (v) => unawaited(n.setBillReminders(enabled: v)),
            ),
          ],
        ),
        const BkGap(BkSpacing.s3),
        BkSegmented<int>(
          options: [
            for (final x in [0, 1, 2, 3]) BkSegment(x, '$x'),
          ],
          selected: s.snoozeLimit,
          onChanged: (x) => unawaited(n.setSnoozeLimit(x)),
        ),
        _Section(l.meHabits),
        BkListGroup(
          children: [
            BkListRow(
              title: l.meThreshold,
              trailing: Text(
                money(s.coolingOffThreshold),
                style: _value(context),
              ),
            ),
            BkToggleRow(
              title: l.meAutoFile,
              subtitle: l.meAutoFileBody,
              value: s.autoFile,
              onChanged: (v) => unawaited(n.setAutoFile(enabled: v)),
            ),
          ],
        ),
        const BkGap(BkSpacing.s3),
        BkSegmented<int>(
          options: [
            for (final h in [24, 48, 72]) BkSegment(h, l.meHours(h)),
          ],
          selected: s.coolingOffHours,
          onChanged: (h) => unawaited(n.setCoolingOffHours(h)),
        ),
        _Section(l.settingsPrivacy),
        BkListGroup(
          children: [
            BkSettingsRow(
              title: l.meSecurity,
              leadingIcon: BkIcons.lock,
              onTap: () => context.go(Routes.meSecurity),
            ),
            BkSettingsRow(
              title: l.settingsData,
              leadingIcon: BkIcons.info,
              onTap: () => context.go(Routes.meData),
            ),
            BkSettingsRow(
              title: l.settingsAppearance,
              subtitle: l.settingsAppearanceBody,
              value: l.settingsComingSoon,
            ),
          ],
        ),
        const BkGap(BkSpacing.s8),
      ],
    );
  }

  TextStyle _value(BuildContext context) =>
      context.bk.type.callout.copyWith(color: context.bk.colors.inkMuted);

  String _time(LocalTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title);
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: BkSpacing.s5, bottom: BkSpacing.s2),
    child: BkHeading(
      child: Text(
        title.toUpperCase(),
        style: context.bk.type.overline.copyWith(
          color: context.bk.colors.inkMuted,
        ),
      ),
    ),
  );
}
