import 'package:buckets/features/setup/presentation/controllers/bills_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/income_setup_controller.dart';
import 'package:buckets/features/setup/presentation/widgets/bill_sheet.dart';
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

/// Screen 03 Fixed bills.
class BillsScreen extends ConsumerWidget {
  /// Creates the screen; [fromMe] when opened from the Me tab.
  const BillsScreen({this.fromMe = false, super.key});

  /// Opened from Me rather than setup.
  final bool fromMe;

  void _continue(BuildContext context, WidgetRef ref) {
    final incomes = ref.read(incomeSetupControllerProvider).value?.incomes;
    final income =
        incomes?.where((i) => i.kind == IncomeKind.salary).firstOrNull ??
        incomes?.firstOrNull;
    context.go(
      income == null ? Routes.setupIncome : Routes.setupSplit(income.id),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(billsControllerProvider);
    ref.watch(incomeSetupControllerProvider);
    return ScreenFrame(
      header: setupHeader(
        context,
        step: 2,
        fromMe: fromMe,
        title: l.billsTitle,
        onBack: () => context.go(fromMe ? Routes.me : Routes.setupIncome),
      ),
      actions: [
        if (!fromMe)
          BkButton.primary(
            label: l.continueLabel,
            onPressed: () => _continue(context, ref),
          ),
      ],
      children: [
        if (!fromMe) SetupTitle(l.billsTitle, intro: l.billsIntro),
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(billsControllerProvider),
          data: (s) => switch (s) {
            BillsEmpty() => BkEmptyState(
              icon: BkIcons.plan,
              title: l.billsEmptyTitle,
              message: l.billsEmptyBody,
              actionLabel: l.billsAdd,
              onAction: () => openBillSheet(context),
            ),
            BillsReady(:final bills, :final total) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BkListGroup(
                  children: [
                    for (final b in bills)
                      BkListRow(
                        title: b.name,
                        subtitle: b.everyMonths == 1
                            ? l.billEach(money(b.amount))
                            : l.billPutAside(
                                money(b.putAside),
                                money(b.amount),
                              ),
                        trailing: BkMoneyText(ngwee: b.reservation.ngwee),
                        chevron: true,
                        onTap: () => openBillSheet(context, bill: b),
                      ),
                  ],
                ),
                const BkGap(BkSpacing.s3),
                BkCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          l.billsTotal,
                          style: context.bk.type.headline.copyWith(
                            color: context.bk.colors.ink,
                          ),
                        ),
                      ),
                      BkMoneyText(ngwee: total.ngwee),
                    ],
                  ),
                ),
                const BkGap(BkSpacing.s4),
                BkButton.secondary(
                  label: l.billsAdd,
                  icon: BkIcons.plus,
                  onPressed: () => openBillSheet(context),
                ),
              ],
            ),
          },
        ),
      ],
    );
  }
}
