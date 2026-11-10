import 'dart:async';
import 'dart:io';

import 'package:buckets/features/logging/presentation/controllers/receipt_review_controller.dart';
import 'package:buckets/features/logging/presentation/widgets/pickers.dart';
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

/// Screen 21 Receipt review: check what was read, pick a category and
/// bucket, save.
class ReceiptReviewScreen extends ConsumerStatefulWidget {
  /// Creates the screen for the scanned receipt [receiptId].
  const ReceiptReviewScreen({required this.receiptId, super.key});

  /// The receipt draft.
  final String receiptId;

  @override
  ConsumerState<ReceiptReviewScreen> createState() =>
      _ReceiptReviewScreenState();
}

class _ReceiptReviewScreenState extends ConsumerState<ReceiptReviewScreen> {
  Category? _category;
  String? _bucketId;
  int? _fixedTotal;

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    final ok = await ref
        .read(receiptReviewControllerProvider(widget.receiptId).notifier)
        .save(category: _category!, bucketId: _bucketId!);
    if (ok && mounted) {
      showBkToast(context, message: l.logSaved);
      context.go(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final provider = receiptReviewControllerProvider(widget.receiptId);
    final value = ref.watch(provider);
    final s = value.value;
    final ready =
        _category != null &&
        _bucketId != null &&
        s != null &&
        s.total != null &&
        !s.totalNeedsCheck;
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.close,
          semanticLabel: l.close,
          onPressed: () => context.go(Routes.home),
        ),
        title: l.receiptTitle,
      ),
      actions: [
        BkButton.primary(
          label: l.save,
          loading: s?.saving ?? false,
          onPressed: ready ? _save : null,
          disabledReason: ready ? null : l.receiptNotReady,
        ),
        BkButton.text(
          label: l.scanRetake,
          onPressed: () => context.go(Routes.scan),
        ),
      ],
      children: [
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(provider),
          data: (s) => _body(context, s),
        ),
      ],
    );
  }

  Widget _body(BuildContext context, ReceiptReviewState s) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final notifier = ref.read(
      receiptReviewControllerProvider(widget.receiptId).notifier,
    );
    final off = s.itemsOff;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(bk.radius.sm),
              child: Image.file(
                File(s.imagePath),
                width: 64,
                height: 64,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    const BkSkeleton(width: 64, height: 64),
              ),
            ),
            const BkGap(BkSpacing.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.merchant ?? l.receiptUnknownShop,
                    style: bk.type.headline.copyWith(color: bk.colors.ink),
                  ),
                  if (s.total case final t? when !s.totalNeedsCheck)
                    BkMoneyText(
                      ngwee: t.ngwee,
                      size: BkAmountSize.l,
                      showNgwee: true,
                    ),
                ],
              ),
            ),
          ],
        ),
        if (s.totalNeedsCheck) ...[
          const BkGap(BkSpacing.s4),
          BkBanner(tone: BkTone.warning, message: l.receiptCheckTotal),
          BkAmountField(
            ngwee: _fixedTotal ?? s.total?.ngwee,
            onChanged: (v) => _fixedTotal = v,
          ),
          BkButton.secondary(
            label: l.receiptUseTotal,
            onPressed: () {
              final t = _fixedTotal ?? s.total?.ngwee;
              if (t != null && t > 0) unawaited(notifier.setTotal(Money(t)));
            },
          ),
        ],
        if (s.items.isNotEmpty) ...[
          const BkGap(BkSpacing.s4),
          BkListGroup(
            children: [
              for (final i in s.items)
                BkListRow(
                  title: i.name,
                  trailing: BkMoneyText(ngwee: i.amount.ngwee, showNgwee: true),
                ),
            ],
          ),
          const BkGap(BkSpacing.s2),
          if (off != null && !s.itemsMatch)
            Text(
              l.receiptItemsOff(money(off.abs(), showNgwee: true)),
              style: bk.type.caption.copyWith(color: bk.colors.danger),
            )
          else if (s.itemsMatch)
            Text(
              l.receiptItemsMatch,
              style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
            ),
        ],
        if (s.errorCode case final code?) ...[
          const BkGap(BkSpacing.s3),
          BkBanner(tone: BkTone.danger, message: errorText(l, code)),
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
      ],
    );
  }
}
