import 'package:buckets/features/home/presentation/controllers/bucket_detail_controller.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Lets the user pick one of [destinations]; completes with its id.
Future<String?> _pickDestination(
  BuildContext context,
  String title,
  List<DestinationVm> destinations,
) => showBkSheet<String>(
  context,
  title: title,
  child: SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final d in destinations) ...[
          BkRadioCard(
            title: d.name,
            selected: false,
            onTap: () => Navigator.of(context).pop(d.id),
          ),
          const BkGap(BkSpacing.s2),
        ],
      ],
    ),
  ),
);

/// The move-money sheet (R-MOVE-1/2) for the bucket behind [notifier].
Future<void> openMoveSheet(
  BuildContext context,
  WidgetRef ref,
  BucketDetailController notifier,
  BucketActionsVm actions,
) async {
  final l = AppLocalizations.of(context);
  await showBkSheet<void>(
    context,
    title: l.moveTitle,
    child: _MoveForm(notifier: notifier, actions: actions),
  );
}

class _MoveForm extends StatefulWidget {
  const _MoveForm({required this.notifier, required this.actions});

  final BucketDetailController notifier;
  final BucketActionsVm actions;

  @override
  State<_MoveForm> createState() => _MoveFormState();
}

class _MoveFormState extends State<_MoveForm> {
  String? _toId;
  int? _amount;
  String? _error;

  DestinationVm? get _dest =>
      widget.actions.destinations.where((d) => d.id == _toId).firstOrNull;

  Future<void> _submit() async {
    final l = AppLocalizations.of(context);
    final to = _toId;
    final amount = _amount;
    if (to == null || amount == null || amount <= 0) {
      setState(() => _error = l.movePickDestination);
      return;
    }
    var result = await widget.notifier.move(
      toBucketId: to,
      amount: Money(amount),
    );
    if (result is MoveConfirmNeeded && mounted) {
      final ok = await _confirm(result.warning);
      if (!ok) return;
      result = await widget.notifier.move(
        toBucketId: to,
        amount: Money(amount),
        confirmed: true,
      );
    }
    if (!mounted) return;
    switch (result) {
      case MoveMade():
        Navigator.of(context).pop();
        showBkToast(
          context,
          message: l.moveDone(money(Money(amount)), _dest?.name ?? ''),
        );
      case MoveFailed(:final code):
        setState(() => _error = errorText(l, code));
      case MoveConfirmNeeded():
        break;
    }
  }

  Future<bool> _confirm(MoveWarning warning) {
    final l = AppLocalizations.of(context);
    final name = _dest?.name ?? '';
    final (title, body) = switch (warning) {
      MoveWarning.fromProtected => (
        l.moveConfirmProtectedTitle,
        l.moveConfirmProtectedBody(name),
      ),
      MoveWarning.belowCycleStart => (
        l.moveConfirmBelowTitle,
        l.moveConfirmBelowBody(name),
      ),
    };
    return BkConfirmDialog.show(
      context,
      title: title,
      message: body,
      confirmLabel: l.moveConfirmYes,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_error case final e?) ...[
            BkBanner(tone: BkTone.danger, message: e),
            const BkGap(BkSpacing.s3),
          ],
          BkRowPicker(
            label: l.moveTo,
            value: _dest?.name ?? l.movePickDestination,
            onTap: () async {
              final id = await _pickDestination(
                context,
                l.movePickDestination,
                widget.actions.destinations,
              );
              if (id != null) setState(() => _toId = id);
            },
          ),
          const BkGap(BkSpacing.s3),
          BkAmountField(
            ngwee: _amount,
            onChanged: (v) => _amount = v,
            effectCaption: l.moveMost(money(widget.actions.available)),
          ),
          const BkGap(BkSpacing.s4),
          BkButton.primary(label: l.moveAction, onPressed: _submit),
        ],
      ),
    );
  }
}

/// The starting-balance sheet (R-LEDGER-6). [onSave] records the amount.
Future<void> openStartingBalanceSheet(
  BuildContext context, {
  required String bucketName,
  required Future<bool> Function(Money amount) onSave,
}) async {
  final l = AppLocalizations.of(context);
  await showBkSheet<void>(
    context,
    title: l.startingTitle,
    child: _StartingForm(bucketName: bucketName, onSave: onSave),
  );
}

class _StartingForm extends StatefulWidget {
  const _StartingForm({required this.bucketName, required this.onSave});

  final String bucketName;
  final Future<bool> Function(Money amount) onSave;

  @override
  State<_StartingForm> createState() => _StartingFormState();
}

class _StartingFormState extends State<_StartingForm> {
  int? _amount;

  Future<void> _submit() async {
    final l = AppLocalizations.of(context);
    final ok = await widget.onSave(Money(_amount ?? 0));
    if (ok && mounted) {
      Navigator.of(context).pop();
      showBkToast(context, message: l.startingSaved);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l.startingBody(widget.bucketName),
          style: context.bk.type.body.copyWith(
            color: context.bk.colors.inkMuted,
          ),
        ),
        const BkGap(BkSpacing.s4),
        BkAmountField(ngwee: _amount, onChanged: (v) => _amount = v),
        const BkGap(BkSpacing.s4),
        BkButton.primary(label: l.startingAction, onPressed: _submit),
      ],
    );
  }
}

/// The remove-bucket flow (R-BUCKET-6): pick a destination for any money,
/// confirm, then remove. [onRemove] returns a failure code or null.
Future<String?> runRemoveBucket(
  BuildContext context, { // ignore_runRemoveBucket
  required String bucketName,
  required Money balance,
  required List<DestinationVm> destinations,
  required Future<String?> Function({String? moveTo}) onRemove,
}) async {
  final l = AppLocalizations.of(context);
  String? moveTo;
  if (balance.isPositive) {
    moveTo = await _pickDestination(context, l.removeMoveWhere, destinations);
    if (moveTo == null) return null;
  }
  if (!context.mounted) return null;
  final destName =
      destinations.where((d) => d.id == moveTo).firstOrNull?.name ?? '';
  final confirmed = await BkConfirmDialog.show(
    context,
    title: l.removeTitle(bucketName),
    message: balance.isPositive
        ? l.removeBodyMoney(money(balance), destName)
        : l.removeBodyEmpty,
    confirmLabel: l.removeConfirm,
    destructive: true,
  );
  if (!confirmed) return null;
  return await onRemove(moveTo: moveTo);
}
