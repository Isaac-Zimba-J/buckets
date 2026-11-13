import 'dart:async';

import 'package:buckets/features/bills/presentation/bills_format.dart';
import 'package:buckets/features/bills/presentation/controllers/fee_rates_controller.dart';
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

/// Screen 37 Fee rates: the bands the app uses to estimate fees (R-FEE-3).
class FeeRatesScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const FeeRatesScreen({super.key});

  @override
  ConsumerState<FeeRatesScreen> createState() => _FeeRatesScreenState();
}

class _FeeRatesScreenState extends ConsumerState<FeeRatesScreen> {
  AlertSource _provider = AlertSource.mtnMomo;

  static const List<AlertSource> _providers = [
    AlertSource.mtnMomo,
    AlertSource.airtelMoney,
    AlertSource.bank,
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.back,
          semanticLabel: l.back,
          onPressed: () => context.go(Routes.fees),
        ),
        title: l.feeRatesTitle,
      ),
      children: [
        BkSegmented<AlertSource>(
          options: [for (final p in _providers) BkSegment(p, p.label(l))],
          selected: _provider,
          onChanged: (p) => setState(() => _provider = p),
        ),
        const BkGap(BkSpacing.s4),
        BkBanner(
          tone: BkTone.info,
          title: l.feeRatesLearnedTitle,
          message: l.feeRatesLearnedBody,
        ),
        const BkGap(BkSpacing.s4),
        AsyncBody(
          value: ref.watch(feeRatesControllerProvider),
          onRetry: () => ref.invalidate(feeRatesControllerProvider),
          data: (s) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final p in s.pending.where((p) => p.provider == _provider))
                _Prompt(pending: p),
              _Bands(
                provider: _provider,
                tariffs: s.tariffs
                    .where((t) => t.provider == _provider)
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A learned fee that differs from a saved band: update it or keep it.
class _Prompt extends ConsumerWidget {
  const _Prompt({required this.pending});

  final PendingFeeChange pending;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final band = pending.change.band;
    Future<void> resolve({required bool accept}) async {
      await ref
          .read(feeRatesControllerProvider.notifier)
          .resolve(
            provider: pending.provider,
            feeType: pending.feeType,
            change: pending.change,
            accept: accept,
          );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: BkSpacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BkBanner(
            tone: BkTone.warning,
            title: l.feeRatesChangeTitle,
            message: l.feeRatesChangeBody(
              money(pending.change.newFee),
              l.feeRatesRange(money(band.minAmount), money(band.maxAmount)),
              money(band.fee),
            ),
          ),
          const BkGap(BkSpacing.s2),
          Row(
            children: [
              Expanded(
                child: BkButton.secondary(
                  label: l.feeRatesChangeDecline,
                  onPressed: () => unawaited(resolve(accept: false)),
                ),
              ),
              const BkGap(BkSpacing.s3),
              Expanded(
                child: BkButton.primary(
                  label: l.feeRatesChangeAccept,
                  onPressed: () => unawaited(resolve(accept: true)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Bands extends ConsumerWidget {
  const _Bands({required this.provider, required this.tariffs});

  final AlertSource provider;
  final List<FeeTariff> tariffs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (tariffs.every((t) => t.bands.isEmpty))
          BkEmptyState(
            icon: BkIcons.plan,
            title: l.feeRatesEmptyTitle,
            message: l.feeRatesEmptyBody,
          ),
        for (final t in tariffs.where((t) => t.bands.isNotEmpty)) ...[
          Text(
            t.feeType.label(l).toUpperCase(),
            style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
          ),
          const BkGap(BkSpacing.s2),
          BkListGroup(
            children: [
              for (final b in t.bands)
                BkListRow(
                  title: l.feeRatesRange(
                    money(b.minAmount),
                    money(b.maxAmount),
                  ),
                  subtitle: b.source == FeeBandSource.learned
                      ? l.feeRatesLearned(b.observations)
                      : l.feeRatesEntered,
                  trailing: BkMoneyText(ngwee: b.fee.ngwee),
                  onTap: () => unawaited(_edit(context, t, band: b)),
                ),
            ],
          ),
          const BkGap(BkSpacing.s4),
        ],
        BkButton.secondary(
          icon: BkIcons.plus,
          label: l.feeRatesAdd,
          onPressed: () => unawaited(_edit(context, null)),
        ),
        const BkGap(BkSpacing.s3),
        Text(
          l.feeRatesFootnote,
          textAlign: TextAlign.center,
          style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
        ),
      ],
    );
  }

  Future<void> _edit(
    BuildContext context,
    FeeTariff? tariff, {
    FeeBand? band,
  }) => showBkSheet<void>(
    context,
    title: AppLocalizations.of(context).feeRatesAdd,
    child: _BandForm(provider: provider, feeType: tariff?.feeType, band: band),
  );
}

class _BandForm extends ConsumerStatefulWidget {
  const _BandForm({required this.provider, this.feeType, this.band});

  final AlertSource provider;
  final FeeType? feeType;
  final FeeBand? band;

  @override
  ConsumerState<_BandForm> createState() => _BandFormState();
}

class _BandFormState extends ConsumerState<_BandForm> {
  late FeeType _type = widget.feeType ?? FeeType.send;
  late int? _min = widget.band?.minAmount.ngwee;
  late int? _max = widget.band?.maxAmount.ngwee;
  late int? _fee = widget.band?.fee.ngwee;
  String? _error;

  FeeRatesController get _ctrl => ref.read(feeRatesControllerProvider.notifier);

  Future<void> _save() async {
    final code = await _ctrl.saveBand(
      provider: widget.provider,
      feeType: _type,
      min: Money(_min ?? 0),
      max: Money(_max ?? 0),
      fee: Money(_fee ?? 0),
    );
    if (!mounted) return;
    if (code == null) {
      Navigator.of(context).pop();
    } else {
      setState(() => _error = code);
    }
  }

  Future<void> _delete() async {
    await _ctrl.deleteBand(
      provider: widget.provider,
      feeType: _type,
      min: Money(_min ?? 0),
    );
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_error case final code?) ...[
          BkBanner(tone: BkTone.danger, message: errorText(l, code)),
          const BkGap(BkSpacing.s3),
        ],
        if (widget.feeType == null) ...[
          BkSegmented<FeeType>(
            options: [for (final t in FeeType.values) BkSegment(t, t.label(l))],
            selected: _type,
            onChanged: (t) => setState(() => _type = t),
          ),
          const BkGap(BkSpacing.s3),
        ],
        Text(l.feeRatesFrom, style: bk.type.headline),
        BkAmountField(ngwee: _min, onChanged: (v) => setState(() => _min = v)),
        const BkGap(BkSpacing.s3),
        Text(l.feeRatesTo, style: bk.type.headline),
        BkAmountField(ngwee: _max, onChanged: (v) => setState(() => _max = v)),
        const BkGap(BkSpacing.s3),
        Text(l.feeRatesFee, style: bk.type.headline),
        BkAmountField(ngwee: _fee, onChanged: (v) => setState(() => _fee = v)),
        const BkGap(BkSpacing.s4),
        BkButton.primary(label: l.save, onPressed: _save),
        if (widget.band != null) ...[
          const BkGap(BkSpacing.s2),
          BkButton.destructive(label: l.feeRatesDelete, onPressed: _delete),
        ],
      ],
    );
  }
}
