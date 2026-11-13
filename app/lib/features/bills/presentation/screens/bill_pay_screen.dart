import 'dart:async';

import 'package:buckets/features/bills/presentation/controllers/bill_pay_controller.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 34 Mark bill paid: the amount, what it was paid with, and the fee
/// (R-BILL-7, R-FEE-1/2).
class BillPayScreen extends ConsumerWidget {
  /// Creates the screen for [billId].
  const BillPayScreen({required this.billId, super.key});

  /// The bill being paid.
  final String billId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final provider = billPayControllerProvider(billId);
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.close,
          semanticLabel: l.close,
          onPressed: () => context.go(Routes.planBills),
        ),
        title: l.billPayTitle,
      ),
      children: [
        AsyncBody(
          value: ref.watch(provider),
          onRetry: () => ref.invalidate(provider),
          data: (s) => _Form(billId: billId, state: s),
        ),
      ],
    );
  }
}

class _Form extends ConsumerStatefulWidget {
  const _Form({required this.billId, required this.state});

  final String billId;
  final BillPayState state;

  @override
  ConsumerState<_Form> createState() => _FormState();
}

class _FormState extends ConsumerState<_Form> {
  late int? _amount = widget.state.expected.ngwee;
  late String? _account = widget.state.defaultAccountId;
  int? _fee;
  Money? _estimate;
  bool _editingFee = false;
  String _proof = '';

  BillPayController get _ctrl =>
      ref.read(billPayControllerProvider(widget.billId).notifier);

  bool get _charges =>
      widget.state.accounts.any((a) => a.id == _account && a.chargesFees);

  @override
  void initState() {
    super.initState();
    unawaited(_refreshEstimate());
  }

  Future<void> _refreshEstimate() async {
    final account = _account;
    final amount = _amount;
    if (account == null || amount == null || amount <= 0 || !_charges) {
      if (mounted) setState(() => _estimate = null);
      return;
    }
    final e = await _ctrl.estimateFee(
      amount: Money(amount),
      accountId: account,
    );
    if (mounted) setState(() => _estimate = e);
  }

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;
    if (text != null && mounted) setState(() => _proof = text);
  }

  Future<void> _pay() async {
    final account = _account;
    final amount = _amount;
    if (account == null || amount == null) return;
    final ok = await _ctrl.pay(
      amount: Money(amount),
      accountId: account,
      fee: _editingFee && _fee != null ? Money(_fee!) : null,
      proofText: _proof,
    );
    if (ok && mounted) context.go(Routes.planBills);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final s =
        ref.watch(billPayControllerProvider(widget.billId)).value ??
        widget.state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (s.errorCode case final code?) ...[
          BkBanner(tone: BkTone.danger, message: errorText(l, code)),
          const BkGap(BkSpacing.s3),
        ],
        BkHeading(
          child: Text(
            s.billName,
            style: bk.type.title1.copyWith(color: bk.colors.ink),
          ),
        ),
        const BkGap(BkSpacing.s4),
        Text(l.billPayAmount, style: bk.type.headline),
        const BkGap(BkSpacing.s2),
        BkAmountField(
          ngwee: _amount,
          onChanged: (v) {
            setState(() => _amount = v);
            unawaited(_refreshEstimate());
          },
          effectCaption: l.billPayDifference,
        ),
        const BkGap(BkSpacing.s4),
        Text(l.billPayWith, style: bk.type.headline),
        const BkGap(BkSpacing.s2),
        BkSegmented<String>(
          options: [for (final a in s.accounts) BkSegment(a.id, a.name)],
          selected: _account ?? '',
          onChanged: (id) {
            setState(() => _account = id);
            unawaited(_refreshEstimate());
          },
        ),
        if (_charges) ...[const BkGap(BkSpacing.s4), _feeCard(context)],
        const BkGap(BkSpacing.s4),
        BkSmsField(
          label: l.billPayProof,
          pasteLabel: l.proofPaste,
          hint: l.proofHint,
          value: _proof,
          onChanged: (v) => setState(() => _proof = v),
          onPaste: () => unawaited(_paste()),
        ),
        const BkGap(BkSpacing.s5),
        Row(
          children: [
            Expanded(
              child: BkButton.secondary(
                label: l.cancel,
                onPressed: () => context.go(Routes.planBills),
              ),
            ),
            const BkGap(BkSpacing.s3),
            Expanded(
              flex: 2,
              child: BkButton.primary(
                label: l.billPayConfirm,
                onPressed: s.saving || _amount == null || _account == null
                    ? null
                    : _pay,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _feeCard(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final estimate = _estimate;
    return BkCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  estimate == null
                      ? l.billPayFeeUnknown
                      : l.billPayFeeAbout(money(estimate)),
                  style: bk.type.headline.copyWith(color: bk.colors.ink),
                ),
              ),
              BkButton.text(
                label: estimate == null ? l.billPayAddFee : l.billPayEditFee,
                onPressed: () => setState(() => _editingFee = !_editingFee),
              ),
            ],
          ),
          Text(
            l.billPayFeeNote,
            style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
          ),
          if (_editingFee) ...[
            const BkGap(BkSpacing.s3),
            BkAmountField(
              ngwee: _fee ?? estimate?.ngwee,
              onChanged: (v) => setState(() => _fee = v),
            ),
          ],
        ],
      ),
    );
  }
}
