import 'dart:async';

import 'package:buckets/features/home/presentation/controllers/bucket_detail_controller.dart';
import 'package:buckets/features/home/presentation/controllers/home_view_models.dart';
import 'package:buckets/features/home/presentation/widgets/bucket_action_sheets.dart';
import 'package:buckets/features/home/presentation/widgets/bucket_entries.dart';
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

/// Screen 09 Bucket detail: what is left and this cycle's entries; when
/// overspent, "K x over" and the ways to cover it (R-OVER-1…5).
class BucketDetailScreen extends ConsumerStatefulWidget {
  /// Creates the screen for [bucketId].
  const BucketDetailScreen({required this.bucketId, super.key});

  /// The bucket.
  final String bucketId;

  @override
  ConsumerState<BucketDetailScreen> createState() => _BucketDetailScreenState();
}

class _BucketDetailScreenState extends ConsumerState<BucketDetailScreen> {
  CoverOptionVm? _picked;

  BucketDetailControllerProvider get _provider =>
      bucketDetailControllerProvider(widget.bucketId);

  CoverOptionVm? _choice(BucketOverspent s) =>
      s.options.contains(_picked) ? _picked : s.options.firstOrNull;

  Future<void> _cover(BucketOverspent s, CoverOptionVm option) async {
    final l = AppLocalizations.of(context);
    final ok = await ref.read(_provider.notifier).cover(option);
    if (ok && mounted) {
      showBkToast(
        context,
        message: l.bucketCovered(
          money(s.overspentBy),
          _optionName(l, s, option),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(_provider);
    final s = value.value;
    final title = switch (s) {
      BucketNormal(:final bucket) ||
      BucketOverspent(:final bucket) => bucket.name,
      null => null,
    };
    final choice = s is BucketOverspent ? _choice(s) : null;
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.pop(),
        ),
        title: title,
      ),
      actions: [
        if (s is BucketOverspent && choice != null)
          BkButton.primary(
            label: l.bucketMove(money(s.overspentBy)),
            loading: s.covering,
            onPressed: () => unawaited(_cover(s, choice)),
          ),
      ],
      children: [
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(_provider),
          data: (s) => switch (s) {
            BucketNormal() => _normal(context, s),
            BucketOverspent() => _overspent(context, s),
          },
        ),
      ],
    );
  }

  Widget _normal(BuildContext context, BucketNormal s) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.bucketLeft,
                style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
              ),
              const BkGap(BkSpacing.s1),
              BkMoneyText(ngwee: s.leftToSpend.ngwee, size: BkAmountSize.l),
            ],
          ),
        ),
        const BkGap(BkSpacing.s6),
        BucketEntries(entries: s.entries),
        const BkGap(BkSpacing.s6),
        _manage(context, s.actions),
      ],
    );
  }

  Widget _manage(BuildContext context, BucketActionsVm actions) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkHeading(
          child: Text(
            l.manageBucket.toUpperCase(),
            style: bk.type.overline.copyWith(color: bk.colors.inkMuted),
          ),
        ),
        const BkGap(BkSpacing.s2),
        BkListGroup(
          children: [
            BkSettingsRow(
              title: l.moveMoney,
              onTap: () => openMoveSheet(
                context,
                ref,
                ref.read(_provider.notifier),
                actions,
              ),
            ),
            BkSettingsRow(
              title: l.moneyAlreadyIn,
              onTap: () => openStartingBalanceSheet(
                context,
                bucketName: _bucketName(),
                onSave: ref.read(_provider.notifier).setStartingBalance,
              ),
            ),
            if (actions.isRemovable)
              BkSettingsRow(
                title: l.removeBucket,
                destructive: true,
                onTap: () => unawaited(_remove(actions)),
              ),
          ],
        ),
      ],
    );
  }

  String _bucketName() => switch (ref.read(_provider).value) {
    BucketNormal(:final bucket) ||
    BucketOverspent(:final bucket) => bucket.name,
    _ => '',
  };

  Future<void> _remove(BucketActionsVm actions) async {
    final l = AppLocalizations.of(context);
    final s = ref.read(_provider).value;
    final balance = switch (s) {
      BucketNormal(:final bucket) ||
      BucketOverspent(:final bucket) => bucket.balance,
      _ => Money.zero,
    };
    final code = await runRemoveBucket(
      context,
      bucketName: _bucketName(),
      balance: balance,
      destinations: actions.destinations,
      onRemove: ref.read(_provider.notifier).remove,
    );
    if (!mounted) return;
    if (code == null) {
      context.go(Routes.home);
    } else {
      showBkToast(context, message: errorText(l, code));
    }
  }

  Widget _overspent(BuildContext context, BucketOverspent s) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final choice = _choice(s);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkCard(
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: BkSpacing.s3,
            runSpacing: BkSpacing.s2,
            children: [
              BkMoneyText(ngwee: s.bucket.balance.ngwee, size: BkAmountSize.l),
              BkBadge(
                label: l.bucketOver(money(s.overspentBy)),
                tone: BkTone.danger,
              ),
            ],
          ),
        ),
        if (s.splitTooTight) ...[
          const BkGap(BkSpacing.s4),
          BkBanner(
            tone: BkTone.warning,
            title: l.bucketTightTitle,
            message: l.bucketTightBody(s.bucket.name),
          ),
          BkButton.text(
            label: l.bucketChangeSplit,
            onPressed: () => context.go(Routes.meIncome),
          ),
        ],
        const BkGap(BkSpacing.s6),
        BkHeading(
          child: Text(
            l.bucketCoverFrom(money(s.overspentBy)),
            style: bk.type.headline.copyWith(color: bk.colors.ink),
          ),
        ),
        const BkGap(BkSpacing.s3),
        if (s.options.isEmpty)
          Text(
            l.bucketNoCover,
            style: bk.type.body.copyWith(color: bk.colors.inkMuted),
          ),
        for (final o in s.options) ...[
          BkRadioCard(
            title: _optionName(l, s, o),
            subtitle: switch (o.fromBalance) {
              _ when o.nextCycle => l.bucketNextCycleNote(s.bucket.name),
              final b? => l.bucketCoverChange(
                money(b),
                money(b - s.overspentBy),
              ),
              null => null,
            },
            selected: o == choice,
            onTap: () => setState(() => _picked = o),
          ),
          const BkGap(BkSpacing.s2),
        ],
        const BkGap(BkSpacing.s2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BkIcon(BkIcons.lock, size: 16, color: bk.colors.inkMuted),
            const BkGap(BkSpacing.s2),
            Expanded(
              child: Text(
                l.bucketLockNote,
                style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
              ),
            ),
          ],
        ),
        const BkGap(BkSpacing.s6),
        BucketEntries(entries: s.entries),
      ],
    );
  }

  static String _optionName(
    AppLocalizations l,
    BucketOverspent s,
    CoverOptionVm o,
  ) => o.nextCycle ? l.bucketNextCycle(s.bucket.name) : o.fromName;
}
