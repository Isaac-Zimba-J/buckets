import 'package:buckets/features/logging/presentation/controllers/check_in_controller.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';

/// The three check-in steps with where the user is (screen 22).
class CheckInStepList extends StatelessWidget {
  /// Creates the list.
  const CheckInStepList({required this.state, super.key});

  /// The check-in.
  final CheckInState state;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final s = state;
    return BkStepList(
      steps: [
        for (final (i, step) in s.steps.indexed)
          BkStep(
            switch (step) {
              CheckInStep.sort => l.checkInStepSort,
              CheckInStep.count => l.checkInStepCount,
              CheckInStep.summary => l.checkInStepSummary,
            },
            i < s.stepIndex
                ? BkStepState.done
                : i == s.stepIndex
                ? BkStepState.active
                : BkStepState.todo,
            subtitle: switch (step) {
              CheckInStep.sort => l.checkInToSort(s.unsorted),
              CheckInStep.count => i == s.stepIndex ? l.checkInNow : null,
              CheckInStep.summary => l.checkInMinute,
            },
          ),
      ],
    );
  }
}

/// Step 1: unsorted payments, with a link to the sort sheet.
class SortStep extends StatelessWidget {
  /// Creates the step.
  const SortStep({required this.unsorted, super.key});

  /// How many alerts still need a bucket.
  final int unsorted;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    return Text(
      unsorted == 0 ? l.checkInAllSorted : l.checkInSortBody(unsorted),
      style: bk.type.body.copyWith(color: bk.colors.ink),
    );
  }
}

/// Step 2: expected cash, the counted amount, then the gap (R-CASH-1…3).
class CountStep extends StatelessWidget {
  /// Creates the step.
  const CountStep({
    required this.state,
    required this.counted,
    required this.onCounted,
    super.key,
  });

  /// The check-in.
  final CheckInState state;

  /// What the user typed, in ngwee.
  final int? counted;

  /// Called as the user types.
  final ValueChanged<int?> onCounted;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final gap = state.gap;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkListGroup(
          children: [
            BkListRow(
              title: l.checkInShouldHave,
              trailing: BkMoneyText(
                ngwee: state.expected.ngwee,
                size: BkAmountSize.l,
              ),
            ),
          ],
        ),
        const BkGap(BkSpacing.s4),
        Text(
          l.checkInWallet,
          style: bk.type.callout.copyWith(
            color: bk.colors.ink,
            fontWeight: FontWeight.w600,
          ),
        ),
        BkAmountField(ngwee: counted, onChanged: onCounted),
        if (state.errorCode case final code?)
          BkBanner(tone: BkTone.danger, message: errorText(l, code)),
        if (gap != null) ...[
          const BkGap(BkSpacing.s3),
          switch (state.prompt) {
            GapPrompt.missingCash => BkBanner(
              tone: BkTone.warning,
              title: l.checkInMissingTitle(money(gap)),
              message: l.checkInMissingBody,
            ),
            GapPrompt.receivedCash => BkBanner(
              tone: BkTone.info,
              title: l.checkInReceivedTitle(money(-gap)),
              message: l.checkInReceivedBody,
            ),
            GapPrompt.none || null =>
              gap.isZero
                  ? BkBanner(tone: BkTone.positive, message: l.checkInSpotOn)
                  : const SizedBox.shrink(),
          },
        ],
      ],
    );
  }
}

/// Step 3: the week (spent per bucket, saved, untracked).
class SummaryStep extends StatelessWidget {
  /// Creates the step.
  const SummaryStep({required this.state, super.key});

  /// The check-in, with its summary.
  final CheckInState state;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final summary = state.summary;
    if (summary == null) return const SizedBox.shrink();
    final spent = summary.spentByBucket.entries
        .where((e) => !e.value.isZero)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BkHeading(
          child: Text(
            l.checkInSpent,
            style: bk.type.headline.copyWith(color: bk.colors.ink),
          ),
        ),
        const BkGap(BkSpacing.s2),
        if (spent.isEmpty)
          Text(
            l.checkInNothingSpent,
            style: bk.type.body.copyWith(color: bk.colors.inkMuted),
          )
        else
          BkListGroup(
            children: [
              for (final e in spent)
                BkListRow(
                  title: state.bucketNames[e.key] ?? '',
                  trailing: BkMoneyText(ngwee: e.value.ngwee),
                ),
            ],
          ),
        const BkGap(BkSpacing.s4),
        BkListGroup(
          children: [
            BkListRow(
              title: l.checkInSaved,
              trailing: BkMoneyText(ngwee: summary.savedThisCycle.ngwee),
            ),
            BkListRow(
              title: l.checkInUntracked,
              trailing: BkMoneyText(ngwee: summary.untrackedTotal.ngwee),
            ),
          ],
        ),
      ],
    );
  }
}
