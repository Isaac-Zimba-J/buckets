import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/setup/presentation/controllers/bills_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/setup_view_models.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Opens the add / edit bill sheet; [bill] edits an existing one.
Future<void> openBillSheet(BuildContext context, {BillVm? bill}) =>
    showBkSheet<void>(
      context,
      title: AppLocalizations.of(context).billsAdd,
      child: BillForm(bill: bill),
    );

/// Name, amount, how often, and when it is due (screen 03).
class BillForm extends ConsumerStatefulWidget {
  /// Creates the form.
  const BillForm({this.bill, super.key});

  /// The bill being edited, if any.
  final BillVm? bill;

  @override
  ConsumerState<BillForm> createState() => _BillFormState();
}

class _BillFormState extends ConsumerState<BillForm> {
  late String _name = widget.bill?.name ?? '';
  late int? _amount = widget.bill?.amount.ngwee;
  late int _every = widget.bill?.everyMonths ?? 1;
  String _dueDay = '';
  DateTime? _nextDue;

  BillFrequency get _frequency => switch (_every) {
    4 => BillFrequency.termly,
    12 => BillFrequency.yearly,
    _ => BillFrequency.monthly,
  };

  Future<void> _pickDate() async {
    final now = wallTime(
      ref.read(clockProvider).now(),
      ref.read(localTimeZoneProvider),
    );
    final picked = await showDatePicker(
      context: context,
      initialDate: _nextDue ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2, now.month, now.day),
    );
    if (picked != null) setState(() => _nextDue = picked);
  }

  Future<void> _save() async {
    final next = _nextDue;
    final ok = await ref
        .read(billsControllerProvider.notifier)
        .save(
          id: widget.bill?.id,
          name: _name,
          amount: Money(_amount ?? 0),
          frequency: _frequency,
          dueDay: _every == 1 ? int.tryParse(_dueDay) : null,
          nextDueDate: _every == 1 || next == null
              ? null
              : DateTime.utc(next.year, next.month, next.day),
        );
    if (ok && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final state = ref.watch(billsControllerProvider).value;
    final error = switch (state) {
      BillsEmpty(:final errorCode) || BillsReady(:final errorCode) => errorCode,
      null => null,
    };
    final today = wallTime(
      ref.watch(clockProvider).now(),
      ref.watch(localTimeZoneProvider),
    );
    final next = _nextDue;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (error != null) ...[
            BkBanner(tone: BkTone.danger, message: errorText(l, error)),
            const BkGap(BkSpacing.s3),
          ],
          BkTextField(
            label: l.billName,
            hint: l.billNameHint,
            value: _name,
            onChanged: (v) => _name = v,
          ),
          BkAmountField(ngwee: _amount, onChanged: (v) => _amount = v),
          BkSegmented<int>(
            options: [
              BkSegment(1, l.billMonthly),
              BkSegment(4, l.billTermly),
              BkSegment(12, l.billYearly),
            ],
            selected: _every,
            onChanged: (v) => setState(() => _every = v),
          ),
          const BkGap(BkSpacing.s3),
          if (_every == 1)
            BkTextField(
              label: l.billDueDay,
              hint: l.billDueDayHint,
              value: _dueDay,
              keyboardType: TextInputType.number,
              onChanged: (v) => _dueDay = v.trim(),
            )
          else
            BkRowPicker(
              label: l.billNextDue,
              value: next == null
                  ? l.billPickDate
                  : DateFormatter.date(next, today: today),
              onTap: _pickDate,
            ),
          const BkGap(BkSpacing.s4),
          BkButton.primary(label: l.save, onPressed: _save),
          if (widget.bill case final b?)
            BkButton.destructive(
              label: l.remove,
              onPressed: () async {
                await ref.read(billsControllerProvider.notifier).delete(b.id);
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
        ],
      ),
    );
  }
}
