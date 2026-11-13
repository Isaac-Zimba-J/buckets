import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_controller.dart';
import 'package:buckets/features/payday/presentation/widgets/payday_hero.dart';
import 'package:buckets/features/payday/presentation/widgets/transfer_rows.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 13 Payday transfers: the alarm hero, one row per transfer, the
/// lock note and the snooze button. Goes to 16 once the payday is done.
class PaydayScreen extends ConsumerWidget {
  /// Creates the screen for [paydayId].
  const PaydayScreen({required this.paydayId, super.key});

  /// The payday to show.
  final String paydayId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final provider = paydayControllerProvider(paydayId);
    final value = ref.watch(provider);
    if (value.value?.complete ?? false) {
      // Done, whether it just finished or was already done on arrival.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go(Routes.paydayDone(paydayId));
      });
    }
    final zone = ref.watch(localTimeZoneProvider);
    final today = wallTime(ref.watch(clockProvider).now(), zone);
    final s = value.value;
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.close,
          semanticLabel: l.close,
          onPressed: () => context.go(Routes.home),
        ),
        title: switch (s?.startedAt) {
          final at? => l.paydayDate(
            DateFormatter.date(wallTime(at, zone), today: today),
          ),
          null => null,
        },
      ),
      actions: [if (s != null && !s.complete) _SnoozeButton(state: s)],
      children: [
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(provider),
          data: (s) => _Body(state: s),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final PaydayState state;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final s = state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (s.errorCode case final code?) ...[
          BkBanner(tone: BkTone.danger, message: errorText(l, code)),
          const BkGap(BkSpacing.s4),
        ],
        PaydayHero(left: s.left, total: s.total, fees: s.fees.total),
        const BkGap(BkSpacing.s4),
        TransferRows(paydayId: s.paydayId, rows: s.transfers, fees: s.fees),
        const BkGap(BkSpacing.s4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BkIcon(BkIcons.lock, size: 16, color: bk.colors.inkMuted),
            const BkGap(BkSpacing.s2),
            Expanded(
              child: Text(
                s.snoozed ? l.paydayUnlockedNote : l.paydayLockNote,
                style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// "Snooze until 20:00 · 1 left"; disabled with a reason when none are
/// left or it is after 21:00 (R-PAY-4).
class _SnoozeButton extends ConsumerWidget {
  const _SnoozeButton({required this.state});

  final PaydayState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final zone = ref.watch(localTimeZoneProvider);
    final until = state.snoozeUntil;
    final reason = state.snoozesLeft == 0
        ? l.paydaySnoozeNoneLeft
        : until == null
        ? l.paydaySnoozeTooLate
        : null;
    Future<void> snooze() async {
      final ok = await ref
          .read(paydayControllerProvider(state.paydayId).notifier)
          .snooze();
      if (ok && context.mounted && until != null) {
        showBkToast(
          context,
          message: l.paydaySnoozedUntil(
            DateFormatter.time(wallTime(until, zone)),
          ),
        );
      }
    }

    return BkButton.secondary(
      icon: BkIcons.clock,
      label: until == null || reason != null
          ? l.paydaySnoozeLabel
          : l.paydaySnooze(
              state.snoozesLeft,
              DateFormatter.time(wallTime(until, zone)),
            ),
      onPressed: reason == null ? snooze : null,
      disabledReason: reason,
    );
  }
}
