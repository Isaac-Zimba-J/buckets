import 'package:buckets/features/setup/presentation/controllers/bucket_accounts_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/income_setup_controller.dart';
import 'package:buckets/features/setup/presentation/widgets/account_picker_sheet.dart';
import 'package:buckets/features/setup/presentation/widgets/setup_header.dart';
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

/// Screen 02 Income: the incomes saved so far and a form to add one.
class IncomeScreen extends ConsumerStatefulWidget {
  /// Creates the screen; [fromMe] when opened from the Me tab.
  const IncomeScreen({this.fromMe = false, super.key});

  /// Opened from Me rather than setup.
  final bool fromMe;

  @override
  ConsumerState<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends ConsumerState<IncomeScreen> {
  String _name = '';
  IncomeKind _kind = IncomeKind.salary;
  int? _expected;
  String _payday = '';
  String? _accountId;

  Future<void> _save() async {
    final accountId = _accountId;
    final ok = await ref
        .read(incomeSetupControllerProvider.notifier)
        .save(
          name: _name,
          kind: _kind,
          landsInAccountId: accountId!,
          expected: _expected == null ? null : Money(_expected!),
          paydayOfMonth: _kind == IncomeKind.salary
              ? int.tryParse(_payday)
              : null,
        );
    if (ok && mounted) {
      setState(() {
        _name = '';
        _expected = null;
        _payday = '';
        _kind = IncomeKind.sideHustle;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(incomeSetupControllerProvider);
    final hasIncome = value.value?.incomes.isNotEmpty ?? false;
    return ScreenFrame(
      header: setupHeader(
        context,
        step: 2,
        fromMe: widget.fromMe,
        title: l.incomeTitle,
        onBack: () =>
            context.go(widget.fromMe ? Routes.me : Routes.setupProfile),
      ),
      actions: [
        if (!widget.fromMe)
          BkButton.primary(
            label: l.continueLabel,
            onPressed: hasIncome ? () => context.go(Routes.setupBills) : null,
            disabledReason: hasIncome ? null : l.errNoIncome,
          ),
      ],
      children: [
        if (!widget.fromMe) SetupTitle(l.incomeTitle),
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(incomeSetupControllerProvider),
          data: (s) => _form(context, s),
        ),
      ],
    );
  }

  Widget _form(BuildContext context, IncomeSetupState s) {
    final l = AppLocalizations.of(context);
    final accounts = ref.watch(bucketAccountsControllerProvider).value;
    final account = accounts?.accounts
        .where((a) => a.id == _accountId)
        .firstOrNull;
    final error = s.errorCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (s.incomes.isNotEmpty) ...[
          BkListGroup(
            children: [
              for (final i in s.incomes)
                BkListRow(
                  title: i.name,
                  subtitle: i.paydayOfMonth == null
                      ? l.incomeIrregular
                      : l.incomePaydayOn(i.paydayOfMonth!),
                  trailing: i.expected == null
                      ? null
                      : BkMoneyText(ngwee: i.expected!.ngwee),
                ),
            ],
          ),
          const BkGap(BkSpacing.s6),
        ],
        if (error != null) ...[
          BkBanner(tone: BkTone.danger, message: errorText(l, error)),
          const BkGap(BkSpacing.s4),
        ],
        BkSegmented<IncomeKind>(
          options: [
            BkSegment(IncomeKind.salary, l.incomeKindSalary),
            BkSegment(IncomeKind.sideHustle, l.incomeKindSideHustle),
          ],
          selected: _kind,
          onChanged: (k) => setState(() => _kind = k),
        ),
        const BkGap(BkSpacing.s4),
        BkTextField(
          label: l.incomeName,
          hint: l.incomeNameHint,
          value: _name,
          onChanged: (v) => _name = v,
        ),
        const BkGap(BkSpacing.s4),
        Text(
          l.incomeExpected,
          style: context.bk.type.callout.copyWith(
            color: context.bk.colors.ink,
            fontWeight: FontWeight.w600,
          ),
        ),
        BkAmountField(ngwee: _expected, onChanged: (v) => _expected = v),
        if (_kind == IncomeKind.salary) ...[
          const BkGap(BkSpacing.s4),
          BkTextField(
            label: l.incomePayday,
            hint: l.incomePaydayHint,
            value: _payday,
            keyboardType: TextInputType.number,
            onChanged: (v) => _payday = v.trim(),
          ),
        ],
        const BkGap(BkSpacing.s2),
        BkRowPicker(
          label: l.incomeLandsIn,
          value: account?.name ?? l.choose,
          onTap: () async {
            final id = await pickAccount(
              context,
              title: l.accountSheetTitle,
              selected: _accountId,
            );
            if (id != null) setState(() => _accountId = id);
          },
        ),
        const BkGap(BkSpacing.s4),
        BkButton.secondary(
          label: l.incomeSave,
          loading: s.saving,
          onPressed: _accountId == null ? null : _save,
          disabledReason: _accountId == null ? l.incomeNeedAccount : null,
        ),
      ],
    );
  }
}
