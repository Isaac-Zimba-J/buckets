import 'dart:async';

import 'package:buckets/features/logging/presentation/controllers/check_in_controller.dart';
import 'package:buckets/features/logging/presentation/widgets/check_in_steps.dart';
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

/// Screen 22 Sunday check-in: sort payments, count your cash, then the
/// week (R-CHECKIN-1, R-CASH-1…3).
class CheckInScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const CheckInScreen({super.key});

  @override
  ConsumerState<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends ConsumerState<CheckInScreen> {
  int? _counted;

  CheckInController get _notifier =>
      ref.read(checkInControllerProvider.notifier);

  Future<void> _record(Future<bool> Function() action) async {
    final l = AppLocalizations.of(context);
    if (await action() && mounted) {
      showBkToast(context, message: l.checkInRecorded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final value = ref.watch(checkInControllerProvider);
    final s = value.value;
    return ScreenFrame(
      header: BkTopBar(
        leading: BkIconButton(
          icon: BkIcons.close,
          semanticLabel: l.close,
          onPressed: () => context.go(Routes.home),
        ),
        title: l.checkInTitle,
      ),
      actions: s == null ? const [] : _actions(l, s),
      children: [
        AsyncBody(
          value: value,
          onRetry: () => ref.invalidate(checkInControllerProvider),
          data: (s) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CheckInStepList(state: s),
              const BkGap(BkSpacing.s5),
              switch (s.step) {
                CheckInStep.sort => SortStep(unsorted: s.unsorted),
                CheckInStep.count => CountStep(
                  state: s,
                  counted: _counted,
                  onCounted: (v) => setState(() => _counted = v),
                ),
                CheckInStep.summary => SummaryStep(state: s),
              },
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _actions(AppLocalizations l, CheckInState s) {
    final next = BkButton.primary(
      label: l.checkInNext,
      onPressed: () => unawaited(_notifier.nextStep()),
    );
    switch (s.step) {
      case CheckInStep.sort:
        return [
          if (s.unsorted > 0)
            BkButton.secondary(
              label: l.checkInSortNow,
              onPressed: () => context.go(Routes.sort),
            ),
          next,
        ];
      case CheckInStep.count:
        if (s.gap == null) {
          final counted = _counted;
          return [
            BkButton.primary(
              label: l.checkInCount,
              onPressed: counted == null
                  ? null
                  : () => unawaited(_notifier.count(Money(counted))),
            ),
          ];
        }
        return switch (s.prompt) {
          GapPrompt.missingCash => [
            BkButton.secondary(
              label: l.checkInLogNow,
              onPressed: () => context.go(Routes.log),
            ),
            BkButton.primary(
              label: l.checkInMarkUntracked,
              onPressed: () => unawaited(_record(_notifier.recordUntracked)),
            ),
          ],
          GapPrompt.receivedCash => [
            BkButton.secondary(
              label: l.checkInKeepCash,
              onPressed: () => unawaited(
                _record(() => _notifier.recordReceived(intoLiving: false)),
              ),
            ),
            BkButton.primary(
              label: l.checkInIntoLiving,
              onPressed: () => unawaited(
                _record(() => _notifier.recordReceived(intoLiving: true)),
              ),
            ),
          ],
          GapPrompt.none || null => [next],
        };
      case CheckInStep.summary:
        return [
          BkButton.primary(
            label: l.checkInDone,
            onPressed: () => context.go(Routes.home),
          ),
        ];
    }
  }
}
