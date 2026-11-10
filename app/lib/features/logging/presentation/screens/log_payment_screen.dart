import 'dart:async';

import 'package:buckets/features/logging/presentation/controllers/log_payment_controller.dart';
import 'package:buckets/features/logging/presentation/widgets/pickers.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/screen_frame.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 19 Log a payment: cash, or a pasted payment message.
class LogPaymentScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const LogPaymentScreen({super.key});

  @override
  ConsumerState<LogPaymentScreen> createState() => _LogPaymentScreenState();
}

class _LogPaymentScreenState extends ConsumerState<LogPaymentScreen> {
  int? _amount;
  String _message = '';
  String _note = '';
  Category? _category;
  String? _bucketId;

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    final notifier = ref.read(logPaymentControllerProvider.notifier);
    final cash = ref.read(logPaymentControllerProvider).tab == LogTab.cash;
    final ok = await notifier.save(
      category: _category!,
      bucketId: _bucketId!,
      amount: cash ? Money(_amount ?? 0) : null,
      note: _note.isEmpty ? null : _note,
    );
    if (ok && mounted) {
      showBkToast(context, message: l.logSaved);
      context.go(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final s = ref.watch(logPaymentControllerProvider);
    final notifier = ref.read(logPaymentControllerProvider.notifier);
    final ready = _category != null && _bucketId != null;
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.close,
          semanticLabel: l.close,
          onPressed: () => context.go(Routes.home),
        ),
        title: l.logTitle,
        trailing: BkIconButton(
          icon: BkIcons.camera,
          semanticLabel: l.logScan,
          onPressed: () => context.go(Routes.scan),
        ),
      ),
      actions: [
        BkButton.primary(
          label: l.save,
          loading: s.saving,
          onPressed: ready ? _save : null,
          disabledReason: ready ? null : l.sortPickBoth,
        ),
      ],
      children: [
        BkSegmented<LogTab>(
          options: [
            BkSegment(LogTab.cash, l.logCash, icon: BkIcons.plus),
            BkSegment(LogTab.paste, l.logPaste, icon: BkIcons.plan),
          ],
          selected: s.tab,
          onChanged: notifier.setTab,
        ),
        const BkGap(BkSpacing.s4),
        if (s.errorCode case final code?) ...[
          BkBanner(tone: BkTone.danger, message: errorText(l, code)),
          const BkGap(BkSpacing.s3),
        ],
        if (s.tab == LogTab.cash)
          BkAmountField(
            ngwee: _amount,
            onChanged: (v) {
              _amount = v;
              if (v != null) unawaited(notifier.amountChanged(Money(v)));
            },
          )
        else ...[
          BkTextField(
            label: l.logMessage,
            hint: l.logMessageHint,
            value: _message,
            onChanged: (v) {
              _message = v;
              notifier.paste(v);
            },
          ),
          if (s.parsedAmount case final a?) ...[
            const BkGap(BkSpacing.s3),
            BkCard(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      s.parsedCounterparty ?? l.logReadAmount,
                      style: context.bk.type.body.copyWith(
                        color: context.bk.colors.ink,
                      ),
                    ),
                  ),
                  BkMoneyText(ngwee: -a.ngwee),
                ],
              ),
            ),
          ],
        ],
        if (s.suggestWish) ...[
          const BkGap(BkSpacing.s3),
          BkBanner(
            tone: BkTone.info,
            title: l.logWishTitle,
            message: l.logWishBody,
          ),
        ],
        FieldLabel(l.logCategory),
        CategoryChips(
          selected: _category,
          onChanged: (c) => setState(() => _category = c),
        ),
        FieldLabel(l.logBucket),
        BucketChips(
          selected: _bucketId,
          onChanged: (b) => setState(() => _bucketId = b),
        ),
        const BkGap(BkSpacing.s4),
        BkTextField(
          label: l.logNote,
          hint: l.logNoteHint,
          value: _note,
          onChanged: (v) => _note = v,
        ),
      ],
    );
  }
}
