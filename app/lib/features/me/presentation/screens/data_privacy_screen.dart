import 'package:buckets/features/me/presentation/controllers/data_privacy_controller.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 27 Data & privacy.
class DataPrivacyScreen extends ConsumerWidget {
  /// Creates the screen.
  const DataPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(dataPrivacyControllerProvider);
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.go(Routes.meSettings),
        ),
        title: l.settingsData,
      ),
      children: [
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(dataPrivacyControllerProvider),
          data: (s) => _Body(state: s),
        ),
      ],
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.state});

  final DataPrivacyState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final s = state.storage;
    final n = ref.read(dataPrivacyControllerProvider.notifier);

    Future<void> clear() async {
      final yes = await BkConfirmDialog.show(
        context,
        title: l.dataClearAlerts,
        message: l.dataClearConfirm,
        confirmLabel: l.dataClearAlerts,
        destructive: true,
      );
      if (yes) await n.clearAlertHistory();
    }

    Future<void> deleteAll() async {
      final yes = await BkConfirmDialog.show(
        context,
        title: l.dataDeleteAll,
        message: l.dataDeleteConfirm,
        confirmLabel: l.dataDeleteAll,
        typedConfirmation: l.dataDeleteKeyword,
        destructive: true,
      );
      if (yes && await n.deleteAll(l.dataDeleteKeyword) && context.mounted) {
        context.go(Routes.welcome);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkBanner(tone: BkTone.positive, message: l.dataPositive),
        const BkGap(BkSpacing.s4),
        BkListGroup(
          children: [
            BkListRow(
              title: l.dataStorageAlerts,
              trailing: Text('${s.alertCount}', style: _value(context)),
            ),
            BkListRow(
              title: l.dataStorageReceipts,
              trailing: Text('${s.receiptCount}', style: _value(context)),
            ),
            BkListRow(
              title: l.dataStorageSize,
              trailing: Text(
                '${(s.databaseBytes / 1024).round()} KB',
                style: _value(context),
              ),
            ),
          ],
        ),
        const BkGap(BkSpacing.s4),
        BkListGroup(
          children: [
            BkSettingsRow(
              title: l.dataClearAlerts,
              subtitle: l.dataClearAlertsBody,
              onTap: clear,
            ),
            BkSettingsRow(
              title: l.dataDeleteAll,
              subtitle: l.dataDeleteAllBody,
              destructive: true,
              onTap: deleteAll,
            ),
          ],
        ),
      ],
    );
  }

  TextStyle _value(BuildContext context) =>
      context.bk.type.callout.copyWith(color: context.bk.colors.inkMuted);
}
