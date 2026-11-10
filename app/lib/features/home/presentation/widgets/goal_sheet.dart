import 'package:buckets/features/home/presentation/controllers/goals_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/bucket_accounts_controller.dart';
import 'package:buckets/features/setup/presentation/widgets/account_picker_sheet.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Opens the new goal sheet (screen 10).
Future<void> openGoalSheet(BuildContext context) => showBkSheet<void>(
  context,
  title: AppLocalizations.of(context).goalsNew,
  child: const GoalForm(),
);

/// Name, target and where the goal's money lives.
class GoalForm extends ConsumerStatefulWidget {
  /// Creates the form.
  const GoalForm({super.key});

  @override
  ConsumerState<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends ConsumerState<GoalForm> {
  String _name = '';
  int? _target;
  String? _accountId;
  bool _failed = false;

  bool get _ready =>
      _name.trim().isNotEmpty && (_target ?? 0) > 0 && _accountId != null;

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    final ok = await ref
        .read(goalsControllerProvider.notifier)
        .create(
          name: _name.trim(),
          target: Money(_target!),
          accountId: _accountId!,
        );
    if (!mounted) return;
    if (ok) {
      Navigator.of(context).pop();
      showBkToast(context, message: l.goalSaved);
    } else {
      setState(() => _failed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final accounts = ref.watch(bucketAccountsControllerProvider).value;
    final account = accounts?.accounts
        .where((a) => a.id == _accountId)
        .firstOrNull;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_failed) ...[
            BkBanner(tone: BkTone.danger, message: l.errGeneric),
            const BkGap(BkSpacing.s3),
          ],
          BkTextField(
            label: l.goalName,
            hint: l.goalNameHint,
            value: _name,
            onChanged: (v) => setState(() => _name = v),
          ),
          const BkGap(BkSpacing.s3),
          Text(l.goalTarget, style: context.bk.type.callout),
          BkAmountField(
            ngwee: _target,
            onChanged: (v) => setState(() => _target = v),
          ),
          BkRowPicker(
            label: l.goalAccount,
            value: account?.name ?? l.goalPickAccount,
            onTap: () async {
              final id = await pickAccount(
                context,
                title: l.goalAccount,
                selected: _accountId,
              );
              if (id != null && mounted) setState(() => _accountId = id);
            },
          ),
          const BkGap(BkSpacing.s4),
          BkButton.primary(label: l.save, onPressed: _ready ? _save : null),
        ],
      ),
    );
  }
}
