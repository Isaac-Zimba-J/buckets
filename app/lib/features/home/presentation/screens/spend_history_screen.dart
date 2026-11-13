import 'package:buckets/features/home/presentation/controllers/spend_history_controller.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Spending history: all-time total and per-calendar-month breakdown.
class SpendHistoryScreen extends ConsumerWidget {
  /// Creates the screen.
  const SpendHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.pop(),
        ),
        title: l.spendHistoryTitle,
      ),
      children: [
        AsyncBody(
          value: ref.watch(spendHistoryControllerProvider),
          onRetry: () => ref.invalidate(spendHistoryControllerProvider),
          data: (h) => _Body(history: h),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.history});

  final SpendHistory history;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkHeroCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.spendHistoryAllTime,
                style: bk.type.callout.copyWith(color: bk.colors.onHeroMuted),
              ),
              BkMoneyText(
                ngwee: history.allTime.ngwee,
                size: BkAmountSize.xl,
                color: bk.colors.onHero,
              ),
            ],
          ),
        ),
        if (history.months.isEmpty) ...[
          const BkGap(BkSpacing.s6),
          BkEmptyState(
            icon: BkIcons.plan,
            title: l.spendHistoryEmptyTitle,
            message: l.spendHistoryEmptyBody,
          ),
        ] else ...[
          const BkGap(BkSpacing.s6),
          Text(
            l.spendHistorySubtitle.toUpperCase(),
            style: bk.type.overline.copyWith(color: bk.colors.inkMuted),
          ),
          const BkGap(BkSpacing.s2),
          for (final m in history.months) ...[
            _MonthCard(month: m),
            const BkGap(BkSpacing.s3),
          ],
        ],
      ],
    );
  }
}

class _MonthCard extends StatelessWidget {
  const _MonthCard({required this.month});

  final MonthSpend month;

  static final _dayFmt = DateFormat('d MMM');

  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final monthLabel = '${_months[month.month - 1]} ${month.year}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(monthLabel, style: bk.type.headline)),
            BkMoneyText(ngwee: month.total.ngwee),
          ],
        ),
        const BkGap(BkSpacing.s2),
        if (month.entries.isEmpty)
          Text(
            'No entries',
            style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
          )
        else
          BkListGroup(
            children: [
              for (final e in month.entries)
                _EntryRow(entry: e, dayFmt: _dayFmt),
            ],
          ),
      ],
    );
  }
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({required this.entry, required this.dayFmt});

  final LedgerEntry entry;
  final DateFormat dayFmt;

  @override
  Widget build(BuildContext context) {
    final bk = context.bk;
    final dateStr = dayFmt.format(entry.occurredAt.toLocal());
    final label = entry.note?.isNotEmpty == true ? entry.note! : 'Expense';
    final ngwee = entry.amount.ngwee.abs();
    final kwacha = ngwee ~/ 100;
    final cents = ngwee % 100;
    final centsStr = cents.toString().padLeft(2, '0');
    final amountStr = cents == 0 ? 'K $kwacha' : 'K $kwacha.$centsStr';

    return BkListRow(
      title: label,
      subtitle: dateStr,
      trailing: Text(
        '-$amountStr',
        style: bk.type.amountM.copyWith(color: bk.colors.danger),
      ),
    );
  }
}
