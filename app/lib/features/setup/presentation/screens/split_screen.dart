import 'package:buckets/features/setup/presentation/controllers/setup_view_models.dart';
import 'package:buckets/features/setup/presentation/controllers/split_controller.dart';
import 'package:buckets/features/setup/presentation/widgets/setup_header.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// `40%`, or `12.5%` for shares that aren't whole percents.
String percent(int basisPoints) => basisPoints % 100 == 0
    ? '${basisPoints ~/ 100}%'
    : '${(basisPoints / 100).toStringAsFixed(basisPoints % 10 == 0 ? 1 : 2)}%';

/// Screen 04 Split what's left, for one income.
class SplitScreen extends ConsumerWidget {
  /// Creates the screen; [fromMe] when opened from the Me tab.
  const SplitScreen({required this.incomeId, this.fromMe = false, super.key});

  /// The income being split.
  final String incomeId;

  /// Opened from Me rather than setup.
  final bool fromMe;

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    final ok = await ref
        .read(splitControllerProvider(incomeId).notifier)
        .save();
    if (ok && context.mounted) {
      context.go(fromMe ? Routes.me : Routes.setupAccounts);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final provider = splitControllerProvider(incomeId);
    final value = ref.watch(provider);
    final s = value.value;
    final valid = s?.status == SplitStatus.valid;
    return ScreenFrame(
      header: setupHeader(
        context,
        step: 3,
        fromMe: fromMe,
        title: l.splitTitle,
        onBack: () => context.go(fromMe ? Routes.me : Routes.setupBills),
      ),
      actions: [
        BkButton.primary(
          label: fromMe ? l.save : l.continueLabel,
          loading: s?.saving ?? false,
          onPressed: valid ? () => _save(context, ref) : null,
          disabledReason: s == null || valid ? null : l.errSplitTotal,
        ),
      ],
      children: [
        if (!fromMe) SetupTitle(l.splitTitle),
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(provider),
          data: (s) => _body(context, ref, s),
        ),
      ],
    );
  }

  Widget _body(BuildContext context, WidgetRef ref, SplitState s) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final total = s.totalBasisPoints ~/ 100;
    final (caption, color) = switch (s.totalBasisPoints) {
      10000 => (l.splitTotalOk(total), bk.colors.positive),
      > 10000 => (l.splitTooMuch(total), bk.colors.danger),
      _ => (l.splitTooLittle(total), bk.colors.danger),
    };
    final toSplit = s.amountToSplit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (s.status == SplitStatus.billsExceedIncome) ...[
          BkBanner(tone: BkTone.danger, message: l.splitBillsExceed),
          const BkGap(BkSpacing.s4),
        ],
        BkHeroCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (toSplit != null)
                Text(
                  l.splitToSplit(money(toSplit)),
                  style: bk.type.headline.copyWith(color: bk.colors.onHero),
                ),
              const BkGap(BkSpacing.s3),
              BkSplitBar(
                segments: [for (final r in s.rows) (r.color.bk, r.basisPoints)],
              ),
            ],
          ),
        ),
        const BkGap(BkSpacing.s4),
        BkListGroup(
          children: [
            for (final r in s.rows)
              BkListRow(
                leading: BkBucketDot(color: r.color.bk),
                title: r.name,
                subtitle: r.share == null
                    ? null
                    : l.splitPerPayday(money(r.share!)),
                trailing: Text(
                  percent(r.basisPoints),
                  style: bk.type.amountM.copyWith(color: bk.colors.ink),
                ),
                chevron: true,
                onTap: () => _editShare(context, ref, r),
              ),
          ],
        ),
        const BkGap(BkSpacing.s3),
        Semantics(
          liveRegion: true,
          child: Text(
            caption,
            textAlign: TextAlign.center,
            style: bk.type.callout.copyWith(color: color),
          ),
        ),
      ],
    );
  }

  Future<void> _editShare(
    BuildContext context,
    WidgetRef ref,
    AllocationVm row,
  ) async {
    final l = AppLocalizations.of(context);
    var text = percent(row.basisPoints).replaceAll('%', '');
    await showBkSheet<void>(
      context,
      title: row.name,
      child: BkTextField(
        label: l.splitShare,
        value: text,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (v) => text = v.trim(),
      ),
      actions: [
        Builder(
          builder: (sheet) => BkButton.primary(
            label: l.save,
            onPressed: () {
              // "12.5" → 1250 basis points, the same shape as kwacha → ngwee.
              final bp = bkParseKwacha(text);
              if (bp != null) {
                ref
                    .read(splitControllerProvider(incomeId).notifier)
                    .setShare(row.bucketId, bp);
              }
              Navigator.of(sheet).pop();
            },
          ),
        ),
      ],
    );
  }
}
