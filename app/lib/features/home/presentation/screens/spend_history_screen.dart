import 'package:buckets/features/home/presentation/controllers/spend_history_controller.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
          BkListGroup(
            children: [
              for (final m in history.months)
                BkListRow(
                  title: _monthLabel(m),
                  trailing: BkMoneyText(ngwee: m.total.ngwee),
                ),
            ],
          ),
        ],
      ],
    );
  }

  String _monthLabel(MonthSpend m) {
    const months = [
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
    return '${months[m.month - 1]} ${m.year}';
  }
}
