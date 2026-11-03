import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/demo_seed.dart';
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
      await spend(c, BucketKind.living, 7690);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      final over = c.read(provider).value! as BucketOverspent;
      expect(over.overspentBy, const Money.kwacha(310));
      expect(over.options.first.fromName, 'Guilt-free');
      expect(over.options.last.nextCycle, isTrue);
      expect(await c.read(provider.notifier).cover(over.options.first), isTrue);
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(c.read(provider).value, isA<BucketNormal>());
    });
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
