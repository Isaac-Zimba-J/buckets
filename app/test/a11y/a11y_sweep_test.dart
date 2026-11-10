import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets/main.dart';
import 'package:buckets/routing/router_provider.dart';
import 'package:buckets/routing/routes.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/setup/screens/screen_harness.dart';

/// AGENTS.md §8: touch targets ≥ 44 logical px.
const _tapTargets = MinimumTapTargetGuideline(
  size: Size(44, 44),
  link: 'AGENTS.md §8',
);

/// S-09: every screen on the demo data, at text scale 1.0 and 1.3, with
/// no layout overflow, 44 px tap targets, labelled tap targets and
/// readable text (flutter_test guidelines).
void main() {
  Future<Map<String, String>> routes(ProviderContainer c) async {
    final payday = (await c.read(paydayRepositoryProvider).getAll())
        .orThrow()
        .single;
    final bucket = (await c.read(bucketRepositoryProvider).getAll())
        .orThrow()
        .firstWhere((b) => b.kind == BucketKind.living);
    final income = (await c.read(incomeRepositoryProvider).getAll())
        .orThrow()
        .first;
    (await c
            .read(alertRepositoryProvider)
            .save(
              PaymentAlert.create(
                id: 'in',
                rawText: null,
                source: AlertSource.airtelMoney,
                receivedAt: c.read(clockProvider).now(),
                parsed: ParsedMessage(
                  confidence: 1,
                  direction: MessageDirection.incoming,
                  amount: const Money.kwacha(2000),
                  counterparty: '[CUSTOMER]',
                ),
              ).orThrow(),
            ))
        .orThrow();
    return {
      'home': Routes.home,
      'bucket': Routes.bucket(bucket.id),
      'goals': Routes.goals,
      'plan': Routes.plan,
      'me': Routes.me,
      'payday': Routes.payday(payday.id),
      'proof': Routes.proof(payday.id, payday.transfers.first.id),
      'done': Routes.paydayDone(payday.id),
      'income received': Routes.incomeReceived('in'),
      'sort': Routes.sort,
      'log': Routes.log,
      'scan': Routes.scan,
      'check-in': Routes.checkIn,
      'me income': Routes.meIncome,
      'me bills': Routes.meBills,
      'me split': Routes.meSplit(income.id),
      'me accounts': Routes.meAccounts,
      'me notifications': Routes.meNotifications,
    };
  }

  for (final scale in [1.0, 1.3]) {
    testWidgets('every screen at text scale $scale', (tester) async {
      final handle = tester.ensureSemantics();
      final c = fakeContainer();
      addTearDown(c.dispose);
      (await seedDemo(c)).orThrow();
      (await c.read(completeSetupProvider)()).orThrow();
      final all = await routes(c);
      await tester.binding.setSurfaceSize(const Size(400, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: c,
          child: MediaQuery(
            data: MediaQueryData(
              size: const Size(400, 900),
              textScaler: TextScaler.linear(scale),
            ),
            child: const BucketsApp(),
          ),
        ),
      );
      await settleStreams(tester);
      for (final MapEntry(key: name, value: route) in all.entries) {
        c.read(routerProvider).go(route);
        await settleStreams(tester);
        expect(tester.takeException(), isNull, reason: '$name overflowed');
        await expectLater(
          tester,
          meetsGuideline(_tapTargets),
          reason: '$name: tap targets under 44 px',
        );
        await expectLater(
          tester,
          meetsGuideline(labeledTapTargetGuideline),
          reason: '$name: a tap target without a label',
        );
        await expectLater(
          tester,
          meetsGuideline(textContrastGuideline),
          reason: '$name: text contrast',
        );
      }
      handle.dispose();
    });
  }
}
