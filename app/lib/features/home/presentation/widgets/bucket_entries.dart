import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/home/presentation/controllers/home_view_models.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// "This cycle": a bucket's ledger entries, newest first (screen 09).
class BucketEntries extends ConsumerWidget {
  /// Creates the list.
  const BucketEntries({required this.entries, super.key});

  /// The entries.
  final List<EntryRowVm> entries;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final zone = ref.watch(localTimeZoneProvider);
    final today = wallTime(ref.watch(clockProvider).now(), zone);
    final sorted = [...entries]
      ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkHeading(
          child: Text(
            l.bucketThisCycle,
            style: bk.type.headline.copyWith(color: bk.colors.ink),
          ),
        ),
        const BkGap(BkSpacing.s3),
        if (sorted.isEmpty)
          Text(
            l.bucketEmpty,
            style: bk.type.body.copyWith(color: bk.colors.inkMuted),
          )
        else
          BkListGroup(
            children: [
              for (final e in sorted)
                BkListRow(
                  title: e.note ?? _label(l, e.kind),
                  subtitle: DateFormatter.relativeDay(
                    wallTime(e.occurredAt, zone),
                    today: today,
                  ),
                  trailing: BkMoneyText(
                    ngwee: e.amount.ngwee,
                    showSign: e.amount.isPositive,
                  ),
                ),
            ],
          ),
      ],
    );
  }

  static String _label(AppLocalizations l, LedgerEntryKind kind) =>
      switch (kind) {
        LedgerEntryKind.allocation => l.bucketEntryPayday,
        LedgerEntryKind.spend => l.bucketEntrySpend,
        LedgerEntryKind.moveIn => l.bucketEntryMoveIn,
        LedgerEntryKind.moveOut => l.bucketEntryMoveOut,
        LedgerEntryKind.adjustment => l.bucketEntryAdjustment,
        LedgerEntryKind.reversal => l.bucketEntryReversal,
      };
}
