import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/setup/presentation/controllers/bucket_accounts_controller.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Opens the account picker; completes with the chosen account's ID.
Future<String?> pickAccount(
  BuildContext context, {
  required String title,
  String? selected,
}) => showBkSheet<String>(
  context,
  title: title,
  child: AccountPicker(selected: selected),
);

/// Accounts as radio cards, then a form to add one (screens 02 and 05).
class AccountPicker extends ConsumerStatefulWidget {
  /// Creates the picker.
  const AccountPicker({this.selected, super.key});

  /// The current account, if any.
  final String? selected;

  @override
  ConsumerState<AccountPicker> createState() => _AccountPickerState();
}

class _AccountPickerState extends ConsumerState<AccountPicker> {
  bool _adding = false;
  String _name = '';
  String _matchKey = '';
  AccountKind _kind = AccountKind.mtnMomo;
  bool _spending = false;

  Future<void> _save() async {
    final id = ref.read(idsProvider).newId();
    final ok = await ref
        .read(bucketAccountsControllerProvider.notifier)
        .saveAccount(
          id: id,
          name: _name,
          kind: _kind,
          matchKeys: [if (_matchKey.isNotEmpty) _matchKey],
          isSpending: _spending,
        );
    if (ok && mounted) Navigator.of(context).pop(id);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final state = ref.watch(bucketAccountsControllerProvider).value;
    final error = state?.errorCode;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final a in state?.accounts ?? const <Never>[]) ...[
            BkRadioCard(
              title: a.name,
              subtitle: a.kind.label(l),
              selected: a.id == widget.selected,
              onTap: () => Navigator.of(context).pop(a.id),
            ),
            const BkGap(BkSpacing.s2),
          ],
          if (!_adding)
            BkButton.secondary(
              label: l.accountAdd,
              icon: BkIcons.plus,
              onPressed: () => setState(() => _adding = true),
            )
          else ...[
            if (error != null) ...[
              BkBanner(tone: BkTone.danger, message: errorText(l, error)),
              const BkGap(BkSpacing.s3),
            ],
            BkTextField(
              label: l.accountName,
              hint: l.accountNameHint,
              value: _name,
              onChanged: (v) => _name = v,
            ),
            const BkGap(BkSpacing.s3),
            BkChipGroup<AccountKind>(
              options: [
                for (final k in const [
                  AccountKind.mtnMomo,
                  AccountKind.airtelMoney,
                  AccountKind.bank,
                  AccountKind.other,
                ])
                  BkChipOption(k, k.label(l)),
              ],
              selected: _kind,
              onChanged: (k) => setState(() => _kind = k),
            ),
            const BkGap(BkSpacing.s3),
            BkTextField(
              label: l.accountMatchKey,
              hint: l.accountMatchKeyHint,
              value: _matchKey,
              keyboardType: TextInputType.number,
              onChanged: (v) => _matchKey = v.trim(),
            ),
            BkToggleRow(
              title: l.accountSpending,
              subtitle: l.accountSpendingSub,
              value: _spending,
              onChanged: (v) => setState(() => _spending = v),
            ),
            const BkGap(BkSpacing.s3),
            BkButton.primary(label: l.save, onPressed: _save),
          ],
        ],
      ),
    );
  }
}
