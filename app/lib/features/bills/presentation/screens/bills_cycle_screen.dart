import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/bills/presentation/bills_format.dart';
import 'package:buckets/features/bills/presentation/controllers/bills_cycle_controller.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/tab_scaffold.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 33 Plan · Bills this cycle: set aside, paid and still to pay, the
/// bills due, and the ones being saved up for (R-BILL-6…8).
class BillsCycleScreen extends ConsumerWidget {
  /// Creates the screen.
  const BillsCycleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return TabScaffold(
      tab: AppTab.plan,
      body: ListView(
        padding: const EdgeInsets.all(BkSpacing.s4),
        children: [
          BkHeading(
            child: Text(
              l.planTitle,
              style: bk.type.title1.copyWith(color: bk.colors.ink),
            ),
          ),
          const BkGap(BkSpacing.s4),
          BkSegmented<String>(
            options: [
              BkSegment('buy', l.planToBuy),
              BkSegment('bills', l.planBills),
              BkSegment('wishes', l.planWishes),
            ],
            selected: 'bills',
            onChanged: (t) => context.go(switch (t) {
              'wishes' => '${Routes.plan}?tab=wishes',
              'buy' => Routes.plan,
              _ => Routes.planBills,
            }),
          ),
          const BkGap(BkSpacing.s4),
          AsyncBody(
            value: ref.watch(billsCycleControllerProvider),
            onRetry: () => ref.invalidate(billsCycleControllerProvider),
            data: (s) => s.isEmpty ? const _Empty() : _Body(state: s),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return BkEmptyState(
      icon: BkIcons.plan,
      title: l.billsEmptyTitle,
      message: l.billsEmptyBody,
      actionLabel: l.billsEmptyAction,
      onAction: () => context.go(Routes.meBills),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.state});

  final BillsCycleState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final v = state.view!;
    final zone = ref.watch(localTimeZoneProvider);
    final today = wallTime(ref.watch(clockProvider).now(), zone);
    final first = DateFormatter.date(wallDate(v.start), today: today);
    final last = DateFormatter.date(wallDate(v.end.addDays(-1)), today: today);
    final range = '$first – $last';
    final paidLine = l.billsPaidOf(
      v.paidCount,
      v.totalCount,
      money(v.paidTotal),
    );
    final saving = v.savingUp.isEmpty
        ? ''
        : ' · ${l.billsSavingUpTotal(money(v.savingUpTotal))}';
    final fraction = v.totalCount == 0 ? 0.0 : v.paidCount / v.totalCount;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkHeroCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '${l.billsHeroTitle(range)} · '
                '${l.billsSetAside(money(v.setAside))}',
                style: bk.type.callout.copyWith(color: bk.colors.onHeroMuted),
              ),
              const BkGap(BkSpacing.s3),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: BkSpacing.s2,
                children: [
                  BkMoneyText(
                    ngwee: v.toPay.ngwee,
                    size: BkAmountSize.xl,
                    color: bk.colors.accent,
                  ),
                  Text(
                    l.billsStillToPay,
                    style: bk.type.body.copyWith(color: bk.colors.onHero),
                  ),
                ],
              ),
              const BkGap(BkSpacing.s3),
              BkProgressBar(value: fraction, onHero: true),
              const BkGap(BkSpacing.s3),
              Text(
                '$paidLine$saving',
                style: bk.type.callout.copyWith(color: bk.colors.onHero),
              ),
            ],
          ),
        ),
        if (v.rows.isNotEmpty) ...[
          const BkGap(BkSpacing.s4),
          _Heading(l.billsDueThisCycle),
          BkListGroup(
            children: [for (final r in v.rows) _row(context, r, today, zone)],
          ),
        ],
        if (v.savingUp.isNotEmpty) ...[
          const BkGap(BkSpacing.s4),
          _Heading(l.billsSavingUp),
          for (final s in v.savingUp) ...[
            _SavingUp(row: s),
            const BkGap(BkSpacing.s2),
          ],
        ],
        const BkGap(BkSpacing.s4),
        BkListGroup(
          children: [
            BkListRow(
              title: l.billsFeesCardTitle,
              subtitle: l.billsFeesCardBody,
              trailing: BkMoneyText(ngwee: state.feesTotal.ngwee),
              chevron: true,
              onTap: () => context.go(Routes.fees),
            ),
          ],
        ),
      ],
    );
  }

  Widget _row(
    BuildContext context,
    BillCycleRow r,
    DateTime today,
    LocalTimeZone zone,
  ) {
    final l = AppLocalizations.of(context);
    final o = r.occurrence;
    final due = wallDate(o.dueDate);
    final (status, label) = switch (o.status) {
      BillStatus.paid => (BkBillStatus.paid, l.billsBadgePaid),
      BillStatus.skipped => (BkBillStatus.due, l.billsBadgeSkipped),
      BillStatus.due when r.isOverdue => (
        BkBillStatus.overdue,
        l.billsBadgeOverdue,
      ),
      BillStatus.due when due.difference(today).inDays <= 3 => (
        BkBillStatus.dueSoon,
        l.billsBadgeDueSoon,
      ),
      BillStatus.due => (BkBillStatus.due, l.billsBadgeDue),
    };
    final fee = r.fee;
    final subtitle = o.status == BillStatus.paid
        ? [
            l.billsPaidOn(
              DateFormatter.date(wallTime(o.paidAt!, zone), today: today),
            ),
            if (fee != null && fee.isPositive) l.billsFee(money(fee)),
          ].join(' · ')
        : l.billsDueOn(DateFormatter.date(due, today: today));
    return BkBillRow(
      title: r.bill.name,
      subtitle: subtitle,
      amountText: money(o.paidAmount ?? o.expectedAmount),
      status: status,
      statusLabel: label,
      onTick: o.status == BillStatus.due
          ? () => context.go(Routes.billPay(r.bill.id))
          : null,
      onTap: () => context.go(Routes.billHistory(r.bill.id)),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: BkSpacing.s2),
    child: Text(
      text.toUpperCase(),
      style: context.bk.type.caption.copyWith(
        color: context.bk.colors.inkMuted,
      ),
    ),
  );
}

class _SavingUp extends StatelessWidget {
  const _SavingUp({required this.row});

  final SavingUpRow row;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final total = row.bill.amount;
    return BkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  row.bill.name,
                  style: bk.type.headline.copyWith(color: bk.colors.ink),
                ),
              ),
              Text(
                l.billsSavedOf(money(row.putAside), money(total)),
                style: bk.type.headline.copyWith(color: bk.colors.ink),
              ),
            ],
          ),
          const BkGap(BkSpacing.s2),
          BkProgressBar(
            value: total.isPositive ? row.putAside.ngwee / total.ngwee : 0,
            color: BkBucketColor.short,
          ),
          const BkGap(BkSpacing.s2),
          Text(
            l.billsSetAsideCycle(money(row.reservation)),
            style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
          ),
        ],
      ),
    );
  }
}
