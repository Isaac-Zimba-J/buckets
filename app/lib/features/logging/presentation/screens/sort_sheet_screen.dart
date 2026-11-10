import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/logging/presentation/controllers/sort_alerts_controller.dart';
import 'package:buckets/features/logging/presentation/widgets/pickers.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 18 "What was this?": a sheet over Home that steps through the
/// unsorted payment alerts.
class SortSheetScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const SortSheetScreen({super.key});

  @override
  ConsumerState<SortSheetScreen> createState() => _SortSheetScreenState();
}

class _SortSheetScreenState extends ConsumerState<SortSheetScreen> {
  String? _alertId;
  Category? _category;
  String? _bucketId;
  bool _always = false;

  void _sync(SortNext s) {
    if (s.alert.id == _alertId) return;
    _alertId = s.alert.id;
    _category = s.category;
    _bucketId = s.bucketId;
    _always = false;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final value = ref.watch(sortAlertsControllerProvider);
    void close() => context.go(Routes.home);
    return Scaffold(
      backgroundColor: bk.colors.scrim,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(sortAlertsControllerProvider),
          data: (s) => switch (s) {
            SortNone() => BkBottomSheet(
              title: l.sortDoneTitle,
              actions: [BkButton.primary(label: l.done, onPressed: close)],
              child: Text(
                l.sortDoneBody,
                style: bk.type.body.copyWith(color: bk.colors.inkMuted),
              ),
            ),
            SortNext() => _next(context, s, close),
          },
        ),
      ),
    );
  }

  Widget _next(BuildContext context, SortNext s, VoidCallback close) {
    // A new alert resets the picks to its suggestion (a merchant rule).
    _sync(s);
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final notifier = ref.read(sortAlertsControllerProvider.notifier);
    final amount = s.alert.amount;
    final who = s.alert.counterparty;
    final today = wallTime(
      ref.watch(clockProvider).now(),
      ref.watch(localTimeZoneProvider),
    );
    final when = wallTime(s.alert.receivedAt, ref.watch(localTimeZoneProvider));
    final category = _category;
    final bucketId = _bucketId;
    return BkBottomSheet(
      title: l.sortTitle,
      actions: [
        BkButton.primary(
          label: l.sortFile,
          onPressed: category == null || bucketId == null
              ? null
              : () async {
                  await notifier.file(
                    category: category,
                    bucketId: bucketId,
                    alwaysFile: _always,
                  );
                },
          disabledReason: category == null || bucketId == null
              ? l.sortPickBoth
              : null,
        ),
        BkButton.text(label: l.sortSkip, onPressed: notifier.skip),
      ],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (amount != null)
              BkMoneyText(ngwee: -amount.ngwee, size: BkAmountSize.xl),
            Text(
              [
                ?who,
                DateFormatter.relativeDay(when, today: today),
                DateFormatter.time(when),
              ].join(' · '),
              style: bk.type.callout.copyWith(color: bk.colors.inkMuted),
            ),
            if (s.errorCode case final code?) ...[
              const BkGap(BkSpacing.s3),
              BkBanner(tone: BkTone.danger, message: errorText(l, code)),
            ],
            FieldLabel(l.logCategory),
            CategoryChips(
              selected: category,
              onChanged: (c) => setState(() => _category = c),
            ),
            FieldLabel(l.logBucket),
            BucketChips(
              selected: bucketId,
              onChanged: (b) => setState(() => _bucketId = b),
            ),
            if (who != null)
              BkToggleRow(
                title: l.sortAlways(who),
                value: _always,
                onChanged: (v) => setState(() => _always = v),
              ),
            Text(
              s.isLast ? l.sortLast : l.sortRemaining(s.remaining - 1),
              textAlign: TextAlign.center,
              style: bk.type.caption.copyWith(color: bk.colors.inkMuted),
            ),
            BkButton.text(label: l.close, onPressed: close),
          ],
        ),
      ),
    );
  }
}
