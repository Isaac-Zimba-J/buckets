import 'dart:async';

import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/payday/presentation/controllers/income_received_controller.dart';
import 'package:buckets/features/payday/presentation/widgets/hustle_split.dart';
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

/// Screen 17 Side hustle received: which side hustle it is and its split,
/// then split it now or hold it until month end; or salary, or leave it
/// out (R-PARSE-5, R-SPLIT-5, R-PAY-6).
class IncomeReceivedScreen extends ConsumerStatefulWidget {
  /// Creates the screen for the incoming alert [alertId].
  const IncomeReceivedScreen({required this.alertId, super.key});

  /// The alert.
  final String alertId;

  @override
  ConsumerState<IncomeReceivedScreen> createState() =>
      _IncomeReceivedScreenState();
}

class _IncomeReceivedScreenState extends ConsumerState<IncomeReceivedScreen> {
  /// The chosen side hustle; null is "Something else".
  String? _hustleId;
  bool _chosen = false;
  bool _notSalary = false;
  int? _typedAmount;

  IncomeReceivedControllerProvider get _provider =>
      incomeReceivedControllerProvider(widget.alertId);

  void _home() => context.go(Routes.home);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    ref.listen(_provider, (_, next) {
      switch (next.value) {
        case IncomeSplit(:final paydayId):
          context.go(Routes.payday(paydayId));
        case IncomeDismissed():
          showBkToast(context, message: l.incomeLeftOut);
          _home();
        default:
      }
    });
    final value = ref.watch(_provider);
    final s = value.value;
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.close,
          semanticLabel: l.close,
          onPressed: _home,
        ),
      ),
      actions: switch (s) {
        IncomeReady() => _actions(l, s),
        IncomeHolding() => [BkButton.primary(label: l.done, onPressed: _home)],
        _ => const [],
      },
      children: [
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(_provider),
          data: (s) => switch (s) {
            IncomeReady() => _ready(context, s),
            IncomeHolding(:final releaseAt) => _holding(context, releaseAt),
            IncomeSplit() || IncomeDismissed() => const SizedBox.shrink(),
          },
        ),
      ],
    );
  }

  bool _salaryMode(IncomeReady s) =>
      s.suggestion == IncomeSuggestion.salaryLanded &&
      s.salaryId != null &&
      !_notSalary;

  String? _selected(IncomeReady s) =>
      _chosen ? _hustleId : s.sideHustles.firstOrNull?.id;

  Money? _amount(IncomeReady s) => switch (_typedAmount) {
    final ngwee? => Money(ngwee),
    null => s.amount,
  };

  Widget _ready(BuildContext context, IncomeReady s) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final amount = _amount(s);
    final selected = _selected(s);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SourceBadge(source: s.source, receivedAt: s.receivedAt),
        const BkGap(BkSpacing.s4),
        if (s.from case final who?)
          Text(
            l.incomeFrom(who),
            style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
          ),
        if (s.amount case final a?)
          BkMoneyText(
            ngwee: a.ngwee,
            size: BkAmountSize.xl,
            showSign: true,
            color: bk.colors.positive,
          )
        else ...[
          BkBanner(tone: BkTone.warning, message: l.incomeAmountMissing),
          BkAmountField(
            ngwee: _typedAmount,
            onChanged: (v) => setState(() => _typedAmount = v),
          ),
        ],
        if (s.errorCode case final code?) ...[
          const BkGap(BkSpacing.s3),
          BkBanner(tone: BkTone.danger, message: errorText(l, code)),
        ],
        const BkGap(BkSpacing.s5),
        if (_salaryMode(s))
          BkBanner(
            tone: BkTone.info,
            title: l.incomeSalaryTitle,
            message: l.incomeSalaryBody,
          )
        else if (s.sideHustles.isEmpty)
          BkEmptyState(
            icon: BkIcons.plus,
            title: l.incomeNoHustlesTitle,
            message: l.incomeNoHustlesBody,
            actionLabel: l.incomeAddHustle,
            onAction: () => context.go(Routes.meIncome),
          )
        else
          HustleSplit(
            hustles: [for (final h in s.sideHustles) (h.id, h.name)],
            selected: selected,
            onSelected: (id) => setState(() {
              _chosen = true;
              _hustleId = id;
            }),
            shares: selected == null || amount == null
                ? const []
                : ref.read(_provider.notifier).sharesFor(selected, amount),
          ),
      ],
    );
  }

  List<Widget> _actions(AppLocalizations l, IncomeReady s) {
    final notifier = ref.read(_provider.notifier);
    final typed = _typedAmount == null ? null : Money(_typedAmount!);
    if (_salaryMode(s)) {
      return [
        BkButton.primary(
          label: l.incomeSalaryStart,
          onPressed: () => unawaited(notifier.salaryLanded(amount: typed)),
        ),
        BkButton.text(
          label: l.incomeNotSalary,
          onPressed: () => setState(() => _notSalary = true),
        ),
      ];
    }
    final selected = _selected(s);
    if (selected == null) {
      return [
        if (s.sideHustles.isNotEmpty) _Caption(l.incomeNotHustleBody),
        BkButton.secondary(
          label: l.incomeNotHustle,
          onPressed: () => unawaited(notifier.dismiss()),
        ),
      ];
    }
    final ready = _amount(s) != null;
    return [
      BkButton.primary(
        label: l.incomeSplitIt,
        onPressed: ready
            ? () => unawaited(notifier.splitNow(selected, amount: typed))
            : null,
        disabledReason: ready ? null : l.incomeAmountMissing,
      ),
      BkButton.secondary(
        label: l.incomeHold,
        onPressed: ready
            ? () => unawaited(notifier.hold(selected, amount: typed))
            : null,
      ),
    ];
  }

  Widget _holding(BuildContext context, DateTime releaseAt) {
    final l = AppLocalizations.of(context);
    final zone = ref.watch(localTimeZoneProvider);
    final today = wallTime(ref.watch(clockProvider).now(), zone);
    final at = wallTime(releaseAt, zone);
    return BkEmptyState(
      icon: BkIcons.clock,
      title: l.incomeHoldingTitle,
      message: l.incomeHoldingBody(
        DateFormatter.date(at, today: today),
        DateFormatter.time(at),
      ),
    );
  }
}

class _SourceBadge extends ConsumerWidget {
  const _SourceBadge({required this.source, required this.receivedAt});

  final AlertSource? source;
  final DateTime? receivedAt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final name = switch (source) {
      AlertSource.mtnMomo => l.incomeSourceMtn,
      AlertSource.airtelMoney => l.incomeSourceAirtel,
      AlertSource.bank => l.incomeSourceBank,
      AlertSource.unknown || null => l.incomeSourceOther,
    };
    final at = receivedAt;
    final label = at == null
        ? name
        : l.incomeSourceAt(
            name,
            DateFormatter.time(wallTime(at, ref.watch(localTimeZoneProvider))),
          );
    return Align(
      alignment: Alignment.centerLeft,
      child: BkBadge(label: label, tone: BkTone.neutral),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    textAlign: TextAlign.center,
    style: context.bk.type.caption.copyWith(color: context.bk.colors.inkMuted),
  );
}
