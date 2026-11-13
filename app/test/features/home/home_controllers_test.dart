import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/me_use_cases.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/home/presentation/controllers/bucket_detail_controller.dart';
import 'package:buckets/features/home/presentation/controllers/goals_controller.dart';
import 'package:buckets/features/home/presentation/controllers/home_controller.dart';
import 'package:buckets/features/home/presentation/controllers/plan_controller.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderListenable;
import 'package:flutter_test/flutter_test.dart';

final clock = FakeClock(DateTime.utc(2026, 10, 25, 6));

ProviderContainer container() => ProviderContainer(
  overrides: fakePortOverrides(clock: clock),
  retry: retryUnlessFailure,
);

/// Keeps an auto-dispose provider alive and returns its next data value.
Future<T> next<T>(
  ProviderContainer c,
  ProviderListenable<AsyncValue<T>> p,
) async {
  c.listen(p, (_, _) {});
  for (var i = 0; i < 50; i++) {
    final v = c.read(p);
    if (v case AsyncData(:final value)) return value;
    if (v case AsyncError(:final error)) fail('$p failed: $error');
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  throw StateError('no value for $p');
}

String bucketId(ProviderContainer c, BucketKind kind) =>
    (c.read(bucketRepositoryProvider) as InMemoryBucketRepository)
        .store
        .items
        .values
        .firstWhere((b) => b.kind == kind)
        .id;

Future<void> spend(ProviderContainer c, BucketKind kind, int kwacha) async =>
    (await c.read(logCashPaymentProvider)(
      amount: Money.kwacha(kwacha),
      category: Category.food,
      bucketId: bucketId(c, kind),
    )).orThrow();

void main() {
  late ProviderContainer c;
  setUp(() => c = container());
  tearDown(() => c.dispose());

  group('07–08 Home', () {
    test('first run: countdown before the first payday', () async {
      (await c.read(firstRunSeedProvider)()).orThrow();
      (await c.read(saveIncomeSourceProvider)(
        name: 'Salary',
        kind: IncomeKind.salary,
        landsInAccountId: 'momo',
        schedule: const MonthlyPay(25),
      )).orThrow();
      final home = await next(c, homeControllerProvider);
      expect(home, isA<HomeFirstRun>());
      home as HomeFirstRun;
      expect(home.nextPayday, LocalDate(2026, 11, 25));
      expect(home.buckets, hasLength(5));
    });

    test('first run: salary preview fills name, amounts and tile %', () async {
      (await c.read(firstRunSeedProvider)()).orThrow();
      (await c.read(saveProfileProvider)(
        now: clock.now(),
        displayName: 'Isaac',
      )).orThrow();
      (await c.read(saveIncomeSourceProvider)(
        name: 'Salary',
        kind: IncomeKind.salary,
        landsInAccountId: 'momo',
        expectedAmount: const Money.kwacha(12000),
        schedule: const MonthlyPay(25),
      )).orThrow();
      final home = await next(c, homeControllerProvider) as HomeFirstRun;
      expect(home.displayName, 'Isaac');
      expect(home.income, const Money.kwacha(12000));
      // Something must move to the savings account (non-spending buckets).
      expect(home.toMoveToSavings, isNotNull);
      expect(home.toMoveToSavings!.ngwee, greaterThan(0));
      final living = home.buckets.firstWhere(
        (b) => b.kind == BucketKind.living,
      );
      expect(living.sharePercent, 40);
    });

    test('active: canvas numbers, alarm banner, locked', () async {
      (await seedDemo(c)).orThrow();
      final home = await next(c, homeControllerProvider) as HomeActive;
      expect(home.livingLeft, const Money.kwacha(3080));
      expect(home.guiltFreeLeft, const Money.kwacha(770));
      expect(home.banner?.pending, 4);
      expect(home.banner?.pendingAmount, const Money.kwacha(3850));
      expect(home.unlocked, isFalse);
      expect(home.perDay, isNotNull);
    });

    test('updates live after a payment', () async {
      (await seedDemo(c)).orThrow();
      await next(c, homeControllerProvider);
      await spend(c, BucketKind.living, 80);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      final home = c.read(homeControllerProvider).value! as HomeActive;
      expect(home.livingLeft, const Money.kwacha(3000));
      expect(home.recent.single.amount, const Money.kwacha(80));
    });
  });

  group('09 Bucket detail', () {
    test('normal, then overspent with options, then covered', () async {
      (await seedDemo(c)).orThrow();
      final living = bucketId(c, BucketKind.living);
      final provider = bucketDetailControllerProvider(living);
      expect(await next(c, provider), isA<BucketNormal>());
      // Spend the bill money too, so the balance itself goes below K 0.
      await spend(c, BucketKind.living, 3390);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      final over = c.read(provider).value! as BucketOverspent;
      expect(over.overspentBy, const Money.kwacha(310));
      expect(over.options.first.fromName, 'Guilt-free');
      expect(over.options.last.nextCycle, isTrue);
      expect(await c.read(provider.notifier).cover(over.options.first), isTrue);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(c.read(provider).value, isA<BucketNormal>());
    });

    test('actions: removable goal, destinations, available cap', () async {
      (await seedDemo(c)).orThrow();
      final laptop = bucketId(c, BucketKind.goal);
      final living = bucketId(c, BucketKind.living);
      final normal =
          await next(c, bucketDetailControllerProvider(laptop)) as BucketNormal;
      expect(normal.actions.isRemovable, isTrue);
      expect(
        normal.actions.destinations.map((d) => d.id),
        isNot(contains(laptop)),
      );
      // Living is a spending bucket: a default one is never removable.
      final livingState =
          await next(c, bucketDetailControllerProvider(living)) as BucketNormal;
      expect(livingState.actions.isRemovable, isFalse);
    });

    test('move needs confirm from protected, then completes', () async {
      (await seedDemo(c)).orThrow();
      final long = bucketId(c, BucketKind.longTerm);
      final laptop = bucketId(c, BucketKind.goal);
      await next(c, bucketDetailControllerProvider(long));
      final notifier = c.read(bucketDetailControllerProvider(long).notifier);
      final first = await notifier.move(
        toBucketId: laptop,
        amount: const Money.kwacha(100),
      );
      expect(first, isA<MoveConfirmNeeded>());
      expect((first as MoveConfirmNeeded).warning, MoveWarning.fromProtected);
      final done = await notifier.move(
        toBucketId: laptop,
        amount: const Money.kwacha(100),
        confirmed: true,
      );
      expect(done, isA<MoveMade>());
    });

    test('starting balance adds then corrects', () async {
      (await seedDemo(c)).orThrow();
      final laptop = bucketId(c, BucketKind.goal);
      final p = bucketDetailControllerProvider(laptop);
      var s = await next(c, p) as BucketNormal;
      final start = s.bucket.balance;
      final notifier = c.read(p.notifier);
      expect(
        await notifier.setStartingBalance(const Money.kwacha(500)),
        isTrue,
      );
      await Future<void>.delayed(const Duration(milliseconds: 50));
      s = c.read(p).value! as BucketNormal;
      expect(s.bucket.balance, start + const Money.kwacha(500));
    });

    test(
      'remove: default refused, goal with money needs destination',
      () async {
        (await seedDemo(c)).orThrow();
        final living = bucketId(c, BucketKind.living);
        final laptop = bucketId(c, BucketKind.goal);
        await next(c, bucketDetailControllerProvider(living));
        expect(
          await c
              .read(bucketDetailControllerProvider(living).notifier)
              .remove(),
          'bucket.notRemovable',
        );
        final p = bucketDetailControllerProvider(laptop);
        await next(c, p);
        await c.read(p.notifier).setStartingBalance(const Money.kwacha(200));
        await Future<void>.delayed(const Duration(milliseconds: 50));
        expect(await c.read(p.notifier).remove(), 'bucket.transferOpen');
      },
    );
  });

  group('10 Goals', () {
    test('empty, then ready; celebrate once when reached', () async {
      (await c.read(firstRunSeedProvider)()).orThrow();
      expect(await next(c, goalsControllerProvider), isA<GoalsEmpty>());
      final notifier = c.read(goalsControllerProvider.notifier);
      expect(
        await notifier.create(
          name: 'Phone',
          target: const Money(100),
          accountId: 'savings',
        ),
        isTrue,
      );
      await Future<void>.delayed(const Duration(milliseconds: 50));
      var ready = c.read(goalsControllerProvider).value! as GoalsReady;
      final phone = ready.goals.single;
      expect(phone.eta, GoalEtaKind.notInSplit);
      (await c.read(ledgerRepositoryProvider).append([
        LedgerEntry.create(
          id: 'gift',
          occurredAt: clock.now(),
          kind: LedgerEntryKind.adjustment,
          bucketId: phone.bucketId,
          amount: const Money(100),
        ).orThrow(),
      ])).orThrow();
      await Future<void>.delayed(const Duration(milliseconds: 50));
      ready = c.read(goalsControllerProvider).value! as GoalsReady;
      expect(ready.goals.single.celebrate, isTrue);
      await notifier.celebrated(phone.bucketId);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      ready = c.read(goalsControllerProvider).value! as GoalsReady;
      expect(ready.goals.single.celebrate, isFalse);
      expect(ready.goals.single.eta, GoalEtaKind.reached);
    });
  });

  group('11 Plan', () {
    test('empty tabs, then planned buys and a wish timer', () async {
      var plan = await next(c, planControllerProvider);
      expect(plan.planned, isEmpty);
      expect(plan.wishes, isEmpty);
      final notifier = c.read(planControllerProvider.notifier);
      await notifier.addPlanned(
        name: 'Gas',
        amount: const Money.kwacha(350),
        bucketId: 'living',
      );
      await notifier.addWish(
        name: 'Speaker',
        amount: const Money.kwacha(700),
        bucketId: 'short',
      );
      await pumpEventQueue();
      plan = await next(c, planControllerProvider);
      expect(plan.planned.single.done, isFalse);
      final wish = plan.wishes.single;
      expect(wish.timeLeft, const Duration(hours: 48));
      expect(await notifier.approve(wish.id), isFalse);
      expect(
        c.read(planControllerProvider).value!.errorCode,
        'wish.stillCoolingOff',
      );
      await notifier.toggle(plan.planned.single.id);
      clock.now_ = clock.now_.add(const Duration(hours: 48));
      expect(await notifier.approve(wish.id), isTrue);
      await pumpEventQueue();
      plan = await next(c, planControllerProvider);
      expect(plan.planned.single.done, isTrue);
      expect(plan.wishes.single.timeLeft, Duration.zero);
      expect(await notifier.drop(wish.id), isTrue);
      await pumpEventQueue();
      plan = await next(c, planControllerProvider);
      expect(plan.wishes, isEmpty);
      clock.now_ = DateTime.utc(2026, 10, 25, 6);
    });
  });
}
