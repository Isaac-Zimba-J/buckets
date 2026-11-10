import 'package:buckets/features/home/presentation/controllers/plan_controller.dart';
import 'package:buckets/features/logging/presentation/widgets/pickers.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Opens the add sheet: a planned buy, or a wish when [wish] is true.
Future<void> openPlanItemSheet(BuildContext context, {required bool wish}) {
  final l = AppLocalizations.of(context);
  return showBkSheet<void>(
    context,
    title: wish ? l.planAddWish : l.planAddBuy,
    child: PlanItemForm(wish: wish),
  );
}

/// What, how much and from which bucket.
class PlanItemForm extends ConsumerStatefulWidget {
  /// Creates the form.
  const PlanItemForm({required this.wish, super.key});

  /// A wish rather than a planned buy.
  final bool wish;

  @override
  ConsumerState<PlanItemForm> createState() => _PlanItemFormState();
}

class _PlanItemFormState extends ConsumerState<PlanItemForm> {
  String _name = '';
  int? _amount;
  String? _bucketId;

  bool get _ready =>
      _name.trim().isNotEmpty && (_amount ?? 0) > 0 && _bucketId != null;

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    final notifier = ref.read(planControllerProvider.notifier);
    final add = widget.wish ? notifier.addWish : notifier.addPlanned;
    final ok = await add(
      name: _name.trim(),
      amount: Money(_amount!),
      bucketId: _bucketId!,
    );
    if (ok && mounted) {
      Navigator.of(context).pop();
      showBkToast(context, message: l.planAdded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final error = ref.watch(planControllerProvider).value?.errorCode;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (error != null) ...[
            BkBanner(tone: BkTone.danger, message: errorText(l, error)),
            const BkGap(BkSpacing.s3),
          ],
          BkTextField(
            label: l.planItemName,
            hint: l.planItemNameHint,
            value: _name,
            onChanged: (v) => setState(() => _name = v),
          ),
          BkAmountField(
            ngwee: _amount,
            onChanged: (v) => setState(() => _amount = v),
          ),
          FieldLabel(l.logBucket),
          BucketChips(
            selected: _bucketId,
            onChanged: (b) => setState(() => _bucketId = b),
          ),
          const BkGap(BkSpacing.s4),
          BkButton.primary(label: l.save, onPressed: _ready ? _save : null),
        ],
      ),
    );
  }
}
