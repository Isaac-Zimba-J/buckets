import 'dart:async';

import 'package:buckets/features/me/presentation/controllers/me_controller.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Payday snoozes, wish cooling-off, the wish threshold and auto-file
/// (Me tab; R-PAY-4, R-PLAN-1, R-PLAN-2, R-SPEND-3).
class HabitSettings extends ConsumerWidget {
  /// Creates the card.
  const HabitSettings({required this.state, super.key});

  /// The current settings.
  final MeState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final s = state;
    final notifier = ref.read(meControllerProvider.notifier);
    Widget label(String text, [String? sub]) => Padding(
      padding: const EdgeInsets.only(bottom: BkSpacing.s2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: bk.type.callout.copyWith(
              color: bk.colors.ink,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (sub != null)
            Text(
              sub,
              style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
            ),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              label(l.meSnoozes, l.meSnoozesBody),
              BkSegmented<int>(
                options: [
                  for (final n in [0, 1, 2, 3]) BkSegment(n, '$n'),
                ],
                selected: s.snoozeLimit,
                onChanged: (n) => unawaited(notifier.setSnoozeLimit(n)),
              ),
              const BkGap(BkSpacing.s4),
              label(l.meCoolingOff),
              BkSegmented<int>(
                options: [
                  for (final h in [24, 48, 72]) BkSegment(h, l.meHours(h)),
                ],
                selected: s.coolingOffHours,
                onChanged: (h) => unawaited(notifier.setCoolingOffHours(h)),
              ),
            ],
          ),
        ),
        const BkGap(BkSpacing.s3),
        BkListGroup(
          children: [
            BkListRow(
              title: l.meThreshold,
              trailing: Text(
                money(s.coolingOffThreshold),
                style: bk.type.amountM.copyWith(color: bk.colors.ink),
              ),
              chevron: true,
              onTap: () => _editThreshold(context, ref),
            ),
            BkToggleRow(
              title: l.meAutoFile,
              subtitle: l.meAutoFileBody,
              value: s.autoFile,
              onChanged: (v) => unawaited(notifier.setAutoFile(enabled: v)),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _editThreshold(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    var ngwee = state.coolingOffThreshold.ngwee;
    await showBkSheet<void>(
      context,
      title: l.meThreshold,
      child: BkAmountField(ngwee: ngwee, onChanged: (v) => ngwee = v ?? 0),
      actions: [
        Builder(
          builder: (sheet) => BkButton.primary(
            label: l.save,
            onPressed: () async {
              final ok = await ref
                  .read(meControllerProvider.notifier)
                  .setCoolingOffThreshold(Money(ngwee));
              if (sheet.mounted) Navigator.of(sheet).pop();
              if (ok && context.mounted) {
                showBkToast(context, message: l.meSaved);
              }
            },
          ),
        ),
      ],
    );
  }
}
