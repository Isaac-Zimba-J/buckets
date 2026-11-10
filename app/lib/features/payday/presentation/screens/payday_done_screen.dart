import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_done_controller.dart';
import 'package:buckets/features/shared/presentation/ui_mapping.dart';
import 'package:buckets/features/shared/presentation/widgets/async_body.dart';
import 'package:buckets/l10n/app_localizations.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_ui_kit/buckets_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Screen 16 Payday complete: a full-bleed hero with what moved, what is
/// unlocked, the streak and the top goal.
class PaydayDoneScreen extends ConsumerWidget {
  /// Creates the screen for [paydayId].
  const PaydayDoneScreen({required this.paydayId, super.key});

  /// The finished payday.
  final String paydayId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final c = context.bk.colors;
    final provider = paydayDoneControllerProvider(paydayId);
    return Scaffold(
      backgroundColor: c.hero,
      body: SafeArea(
        child: DefaultTextStyle.merge(
          style: TextStyle(color: c.onHero),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BkSpacing.s5,
                    ),
                    child: AsyncBody(
                      value: ref.watch(provider),
                      onRetry: () => ref.invalidate(provider),
                      data: (s) => _Summary(state: s),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  BkSpacing.s4,
                  BkSpacing.s3,
                  BkSpacing.s4,
                  BkSpacing.s8,
                ),
                child: BkButton.accent(
                  label: l.doneGoHome,
                  onPressed: () => context.go(Routes.home),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Summary extends ConsumerWidget {
  const _Summary({required this.state});

  final PaydayDoneState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final bk = context.bk;
    final c = bk.colors;
    final s = state;
    final zone = ref.watch(localTimeZoneProvider);
    final today = wallTime(ref.watch(clockProvider).now(), zone);
    final perDay = s.perDay;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: c.accent,
              borderRadius: BorderRadius.circular(bk.radius.full),
            ),
            child: Center(
              child: BkIcon(BkIcons.check, size: 44, color: c.onAccent),
            ),
          ),
        ),
        const BkGap(BkSpacing.s6),
        if (s.startedAt case final at?)
          Text(
            l.paydayDate(DateFormatter.date(wallTime(at, zone), today: today)),
            style: bk.type.body.copyWith(color: c.onHeroMuted),
          ),
        const BkGap(BkSpacing.s2),
        BkHeading(
          child: Text(
            l.doneMoved(money(s.moved)),
            style: bk.type.display.copyWith(color: c.onHero),
          ),
        ),
        const BkGap(BkSpacing.s3),
        Text(
          [
            if (s.allProven)
              l.doneAllProven(s.transfers)
            else
              l.doneAllDone(s.transfers),
            if (perDay != null)
              l.doneUnlockedPerDay(
                money(s.livingLeft),
                money(perDay),
                money(s.guiltFreeLeft),
              )
            else
              l.doneUnlocked(money(s.livingLeft), money(s.guiltFreeLeft)),
          ].join(' '),
          style: bk.type.body.copyWith(color: c.onHero),
        ),
        const BkGap(BkSpacing.s6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BkHeroStat(
                icon: BkIcons.streak,
                label: l.doneStreak,
                value: l.doneStreakValue(s.streak),
              ),
            ),
            if (s.goalName case final goal?) ...[
              const BkGap(BkSpacing.s3),
              Expanded(
                child: BkHeroStat(
                  icon: BkIcons.goals,
                  label: goal,
                  value: l.doneGoalValue((s.goalProgress ?? 0) ~/ 100),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
