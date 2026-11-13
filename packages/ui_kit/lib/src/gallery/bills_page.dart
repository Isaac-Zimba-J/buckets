import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// Gallery page: Bills and fees components in light or dark.
class BillsPage extends StatelessWidget {
  /// Creates the page.
  const BillsPage({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.bk.colors.bg,
    child: const Padding(
      padding: EdgeInsets.all(BkSpacing.s4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BkListGroup(
            children: [
              BkBillRow(
                title: 'ZESCO units',
                subtitle: 'Due 20 Nov',
                amountText: 'K 400',
                status: BkBillStatus.dueSoon,
                statusLabel: 'Due soon',
              ),
              BkBillRow(
                title: 'Water',
                subtitle: 'Due 1 Nov',
                amountText: 'K 600',
                status: BkBillStatus.overdue,
                statusLabel: 'Overdue',
              ),
              BkBillRow(
                title: 'Rent',
                subtitle: 'Paid 1 Nov',
                amountText: 'K 2,500',
                status: BkBillStatus.paid,
                statusLabel: 'Paid',
              ),
            ],
          ),
          BkGap(BkSpacing.s4),
          BkMonthGrid(
            months: [
              (label: 'Jun', state: BkMonthState.paid, caption: 'K 420 · 18th'),
              (label: 'Jul', state: BkMonthState.late, caption: 'K 380 · 23rd'),
              (label: 'Aug', state: BkMonthState.due, caption: 'Due 20th'),
              (label: 'Sep', state: BkMonthState.skipped, caption: 'Skipped'),
            ],
          ),
          BkGap(BkSpacing.s4),
          BkCard(
            child: Column(
              children: [
                BkProviderBar(
                  label: 'MTN MoMo',
                  amountText: 'K 52',
                  fraction: 0.6,
                  color: BkBucketColor.fun,
                ),
                BkGap(BkSpacing.s3),
                BkProviderBar(
                  label: 'Airtel Money',
                  amountText: 'K 34',
                  fraction: 0.4,
                  color: BkBucketColor.emergency,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
