import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/bills/presentation/bills_format.dart';
import 'package:buckets/features/bills/presentation/controllers/bill_history_controller.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 35 Bill history: budget, average, on-time count and the last six
/// cycles (R-BILL-9).
class BillHistoryScreen extends ConsumerWidget {
  /// Creates the screen for [billId].
  const BillHistoryScreen({required this.billId, super.key});

  /// The bill to show.
  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final provider = billHistoryControllerProvider(billId);
    final s = ref.watch(provider).value;
    final due = s?.occurrences
        .where((o) => o.status == BillStatus.due)
        .firstOrNull;
    final today = wallTime(
      ref.watch(clockProvider).now(),
      ref.watch(localTimeZoneProvider),
    );
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.go(Routes.planBills),
        ),
        title: l.billHistoryTitle,
      ),
      actions: [
        if (due != null)
          BkButton.primary(
            label: l.billHistoryMarkPaid(
              DateFormatter.month(wallDate(due.dueDate), today: today),
            ),
            onPressed: () => context.go(Routes.billPay(billId)),
          ),
      ],
      children: [
        AsyncBody(
          value: ref.watch(provider),
          onRetry: () => ref.invalidate(provider),
          data: (s) => _Body(state: s, today: today),
        ),
      ],
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.state, required this.today});

  final BillHistoryState state;
  final DateTime today;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final zone = ref.watch(localTimeZoneProvider);
    final stats = state.stats;
    final newest = state.occurrences.firstOrNull;
    final last = state.occurrences.take(6).toList().reversed.toList();
    BkMonth month(BillOccurrence o) {
      final due = wallDate(o.dueDate);
      final label = DateFormatter.month(due, today: today);
      final paidAt = o.paidAt;
      if (o.status == BillStatus.paid && paidAt != null) {
        final paid = wallTime(paidAt, zone);
        return (
          label: label,
          state: DateTime.utc(paid.year, paid.month, paid.day).isAfter(due)
              ? BkMonthState.late
              : BkMonthState.paid,
          caption: l.billHistoryPaidCaption(
            money(o.paidAmount ?? o.expectedAmount),
            '${paid.day}',
          ),
        );
      }
      return (
        label: label,
        state: o.status == BillStatus.skipped
            ? BkMonthState.skipped
            : BkMonthState.due,
        caption: o.status == BillStatus.skipped
            ? l.billsBadgeSkipped
            : l.billHistoryDueCaption('${due.day}'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkHeading(
          child: Text(
            state.billName,
            style: bk.type.title1.copyWith(color: bk.colors.ink),
          ),
        ),
        const BkGap(BkSpacing.s4),
        Row(
          children: [
            _Stat(
              l.billHistoryBudget,
              newest == null ? '–' : money(newest.expectedAmount),
            ),
            const BkGap(BkSpacing.s2),
            _Stat(
              l.billHistoryAverage,
              stats.averagePaid == null ? '–' : money(stats.averagePaid!),
            ),
            const BkGap(BkSpacing.s2),
            _Stat(
              l.billHistoryOnTime,
              l.billHistoryOnTimeValue(
                stats.onTimeOfLastFive,
                stats.lastFiveCount,
              ),
            ),
          ],
        ),
        const BkGap(BkSpacing.s4),
        Text(
          l.billHistoryLastCycles(last.length).toUpperCase(),
          style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
        ),
        const BkGap(BkSpacing.s2),
        BkMonthGrid(months: [for (final o in last) month(o)]),
        const BkGap(BkSpacing.s4),
        BkBanner(
          tone: BkTone.info,
          message: state.isFirstCycle
              ? l.billHistoryFirstCycle
              : l.billHistoryNote,
        ),
        const BkGap(BkSpacing.s4),
        BkListGroup(
          children: [
            BkListRow(
              title: l.billHistoryEdit,
              subtitle: l.billHistoryEditBody,
              chevron: true,
              onTap: () => context.go(Routes.meBills),
            ),
            BkListRow(
              title: l.billHistoryFees,
              trailing: Text(
                l.billHistoryFeesValue(money(state.feesThisYear)),
                style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    return Expanded(
      child: BkCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
            ),
            Text(value, style: bk.type.headline.copyWith(color: bk.colors.ink)),
          ],
        ),
      ),
    );
  }
}
