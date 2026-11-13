import 'package:buckets/features/bills/presentation/bills_format.dart';
import 'package:buckets/features/bills/presentation/controllers/fees_controller.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 36 Fees: this cycle's fees by provider and type, and any that are
/// missing (R-FEE-2, R-FEE-7).
class FeesScreen extends ConsumerWidget {
  /// Creates the screen.
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.go(Routes.planBills),
        ),
        title: l.feesTitle,
      ),
      children: [
        AsyncBody(
          value: ref.watch(feesControllerProvider),
          onRetry: () => ref.invalidate(feesControllerProvider),
          data: (s) => _Body(state: s),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final FeesState state;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final s = state.summary;
    final rates = BkListGroup(
      children: [
        BkListRow(
          title: l.feesRatesTitle,
          subtitle: l.feesRatesBody,
          chevron: true,
          onTap: () => context.go(Routes.feeRates),
        ),
      ],
    );
    if (state.isEmpty || s == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BkEmptyState(
            icon: BkIcons.plan,
            title: l.feesEmptyTitle,
            message: l.feesEmptyBody,
          ),
          const BkGap(BkSpacing.s4),
          rates,
        ],
      );
    }
    final largest = s.byProvider.values.fold(
      0,
      (m, v) => v.ngwee > m ? v.ngwee : m,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l.feesThisCycle,
          style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          spacing: BkSpacing.s2,
          children: [
            BkMoneyText(ngwee: s.total.ngwee, size: BkAmountSize.xl),
            Text(l.feesInFees, style: bk.type.body),
          ],
        ),
        Text(
          l.feesPercentLine(
            percent(s.percentOfMovedBp),
            money(s.previousTotal),
          ),
          style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
        ),
        const BkGap(BkSpacing.s4),
        if (s.byProvider.isNotEmpty)
          BkCard(
            child: Column(
              children: [
                for (final e in s.byProvider.entries) ...[
                  BkProviderBar(
                    label: e.key.label(l),
                    amountText: money(e.value),
                    fraction: largest == 0 ? 0 : e.value.ngwee / largest,
                    color: e.key.color,
                  ),
                  const BkGap(BkSpacing.s3),
                ],
              ],
            ),
          ),
        if (s.byType.isNotEmpty) ...[
          const BkGap(BkSpacing.s4),
          Text(
            l.feesByType.toUpperCase(),
            style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
          ),
          const BkGap(BkSpacing.s2),
          BkListGroup(
            children: [
              for (final e in s.byType.entries)
                BkListRow(
                  title: e.key.label(l),
                  trailing: BkMoneyText(ngwee: e.value.ngwee),
                ),
            ],
          ),
        ],
        if (s.missingCount > 0) ...[
          const BkGap(BkSpacing.s4),
          BkBanner(
            tone: BkTone.warning,
            title: l.feesMissingTitle(s.missingCount),
            message: l.feesMissingBody,
          ),
        ],
        const BkGap(BkSpacing.s4),
        rates,
      ],
    );
  }
}
