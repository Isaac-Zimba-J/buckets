import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../fakes/fakes_bills.dart';
import '../../fakes/fakes_planning.dart';
import '../../helpers.dart';
import '../../support/payday_world.dart';

class HomeWorld extends PaydayWorld {
  final planning = InMemoryPlanningRepository();
  final checkIns = InMemoryCheckInRepository();
  final scheduler = FakeNotificationScheduler();

  late final cycle = GetCurrentCycle(incomes, paydays, settings, clock, zone);
  late final writer = SpendWriter(transactions, ledger, ids);
  late final checkInContext = CheckInContext(
    alerts: alerts,
    accounts: accounts,
    transactions: transactions,
    checkIns: checkIns,
    clock: clock,
  );

  Future<void> spend(int kwacha, {BucketKind kind = BucketKind.living}) async {
    await LogCashPayment(accounts, writer, ids, clock)(
      amount: Money.kwacha(kwacha),
      category: Category.food,
      bucketId: bucketOf(kind),
    );
  }
}

void main() {
  late HomeWorld w;
  setUp(() => w = HomeWorld());

  group('Home (screens 07–08)', () {
    WatchHome home() => WatchHome(
      ledger: w.ledger,
      buckets: w.buckets,
      paydays: w.paydays,
      alerts: w.alerts,
      transactions: w.transactions,
      cycle: w.cycle,
    );

    test(
      'before the first payday: first-run variant with a countdown',
      () async {
        await w.canvasSetup();
        final data = ok(await home()().first);
        expect(data.cycle.hadPayday, isFalse);
        expect(data.livingLeft, Money.zero);
        final (date, days) = ok(await GetNextPayday(w.cycle)())!;
        // Now is 25 Oct 08:00 local, so the next 25th is in November.
        expect(date, LocalDate(2026, 11, 25));
        expect(days, 31);
      },
    );

    test('mid-cycle: left, per day, alarm banner and unlock', () async {
      final payday = await w.startSalary(await w.canvasSetup());
      await w.spend(80);
      final data = ok(await home()().first);
      expect(data.cycle.hadPayday, isTrue);
      expect(data.livingLeft, const Money.kwacha(3000));
      expect(data.perDay, const Money(9677)); // 3,000 over 31 days
      expect(data.guiltFreeLeft, const Money.kwacha(770));
      expect(data.openPayday?.id, payday.id);
      expect(data.unlocked, isFalse);
      expect(data.recent.single.amount, const Money.kwacha(80));
      expect(data.buckets, hasLength(6));
    });

    test('updates live when money moves', () async {
      await w.startSalary(await w.canvasSetup());
      final stream = home()();
      final seen = <Money>[];
      final sub = stream.listen((r) => seen.add(ok(r).livingLeft));
      await Future<void>.delayed(Duration.zero);
      await w.spend(100);
      await Future<void>.delayed(const Duration(milliseconds: 10));
      await sub.cancel();
      expect(seen.last, const Money.kwacha(2980));
    });
  });

  group('Bucket detail and overspend (screen 09)', () {
    test('overspent Living is covered from Guilt-free first', () async {
      await w.startSalary(await w.canvasSetup());
      await w.spend(3390); // K 310 over
      final living = w.bucketOf(BucketKind.living);
      final detail = ok(await WatchBucket(w.buckets, w.ledger)(living).first);
      // Bill money is in the balance, so it isn't negative yet.
      expect(detail.leftToSpend, const Money.kwacha(-310));
      await w.spend(4300); // spend the bill money too
      final options = ok(
        await GetCoverOptions(
          w.buckets,
          w.ledger,
          w.paydays,
          w.incomes,
          w.clock,
        )(living),
      )!;
      expect(options.$2, const Money.kwacha(310));
      expect(
        options.$1.first,
        CoverFromBucket(w.bucketOf(BucketKind.guiltFree)),
      );
      expect(options.$3, isFalse);
      ok(
        await CoverOverspend(w.ledger, w.ids, w.clock)(
          living,
          options.$1.first,
        ),
      );
      final after = ok(await WatchBucket(w.buckets, w.ledger)(living).first);
      expect(after.balance, Money.zero);
      expect(after.overspentBy, isNull);
      expect(
        await CoverOverspend(w.ledger, w.ids, w.clock)(
          living,
          options.$1.first,
        ),
        isErr('bucket.notOverspent'),
      );
    });

    test('no options for a bucket that is not overspent', () async {
      await w.startSalary(await w.canvasSetup());
      expect(
        ok(
          await GetCoverOptions(
            w.buckets,
            w.ledger,
            w.paydays,
            w.incomes,
            w.clock,
          )(w.bucketOf(BucketKind.living)),
        ),
        isNull,
      );
    });
  });

  group('Goals (screen 10)', () {
    test('CreateGoal adds a goal bucket that is in no split yet', () async {
      final goal = ok(
        await CreateGoal(w.buckets, w.goals, w.ids)(
          name: 'Phone',
          target: const Money.kwacha(3000),
          accountId: 'savings',
        ),
      );
      final bucket = ok(await w.buckets.get(goal.bucketId));
      expect(bucket.kind, BucketKind.goal);
      expect(
        await CreateGoal(w.buckets, w.goals, w.ids)(
          name: 'phone',
          target: const Money(1),
          accountId: 'savings',
        ),
        isErr('buckets.duplicateName'),
      );
    });

    test('WatchGoals shows balance, contribution and ETA', () async {
      await w.startSalary(await w.canvasSetup());
      await w.goals.save(
        ok(Goal.create(bucketId: 'laptop', target: const Money.kwacha(9000))),
      );
      final views = ok(
        await WatchGoals(
          goals: w.goals,
          buckets: w.buckets,
          ledger: w.ledger,
          incomes: w.incomes,
          profiles: w.profiles,
          paydays: w.paydays,
          reservations: w.reservations,
          clock: w.clock,
          zone: w.zone,
        )().first,
      );
      final laptop = views.single;
      expect(laptop.name, 'Laptop');
      expect(laptop.balance, const Money.kwacha(770));
      expect(laptop.monthlyContribution, const Money.kwacha(770));
      // 8,230 left / 770 = 10.7 → 11 months.
      expect(laptop.eta.months, 11);
      expect(laptop.celebrate, isFalse);
    });

    test('GetSavingsStats', () async {
      await w.startSalary(await w.canvasSetup());
      final stats = ok(await GetSavingsStats(w.buckets, w.ledger, w.cycle)());
      expect(stats.savedThisCycle, const Money.kwacha(3850));
      expect(stats.totalSaved, const Money.kwacha(3850));
    });
  });

  group('Plan (screen 11)', () {
    test('planned buys: add, tick with a transaction, untick', () async {
      final p = ok(
        await AddPlannedPurchase(w.planning, w.ids)(
          name: 'Gas',
          amount: const Money.kwacha(350),
          bucketId: 'living',
        ),
      );
      final toggle = TogglePlannedPurchase(w.planning);
      final done = ok(await toggle(p.id, transactionId: 'tx'));
      expect(done.done, isTrue);
      expect(done.transactionId, 'tx');
      expect(ok(await toggle(p.id)).done, isFalse);
      expect(await WatchPlannedPurchases(w.planning)().first, hasLength(1));
      expect(await toggle('nope'), isErr('planned.notFound'));
    });

    test('wishes: add, approve only after the timer, drop', () async {
      final wish = ok(
        await AddWish(w.planning, w.settings, w.ids, w.clock)(
          name: 'Speaker',
          amount: const Money.kwacha(700),
          bucketId: 'short',
        ),
      );
      expect(wish.endsAt, w.clock.now().add(const Duration(hours: 48)));
      expect(
        await ApproveWish(w.planning, w.clock)(wish.id),
        isErr('wish.stillCoolingOff'),
      );
      w.clock.now_ = wish.endsAt;
      expect(
        ok(await ApproveWish(w.planning, w.clock)(wish.id)).status,
        WishStatus.approved,
      );
      expect(
        ok(await DropWish(w.planning)(wish.id)).status,
        WishStatus.dropped,
      );
      expect(
        (await WatchWishes(w.planning)().first).single.status,
        WishStatus.dropped,
      );
    });
  });

  group('Check-in (screen 22)', () {
    test('steps, expected cash, count with a gap, Untracked', () async {
      await w.startSalary(await w.canvasSetup());
      await w.spend(40);
      w.alerts.store.items['a'] = ok(
        PaymentAlert.create(
          id: 'a',
          rawText: null,
          source: AlertSource.mtnMomo,
          receivedAt: w.clock.now(),
          parsed: ParsedMessage.unparsed,
        ),
      );
      final state = ok(await GetCheckInState(w.checkInContext)());
      expect(state.steps.first, CheckInStep.sort);
      expect(state.unsorted, 1);
      expect(state.expected, const Money.kwacha(-40));

      final (first, firstPrompt) = ok(
        await CountCash(w.checkInContext, w.ids)(const Money.kwacha(500)),
      );
      expect(first.gap, const Money.kwacha(-540));
      expect(firstPrompt, GapPrompt.receivedCash);
      ok(
        await RecordReceivedCash(w.buckets, w.ledger, w.ids, w.clock)(
          const Money.kwacha(540),
          intoLiving: false,
        ),
      );

      w.clock.now_ = w.clock.now_.add(const Duration(days: 7));
      await w.spend(100);
      final (second, prompt) = ok(
        await CountCash(w.checkInContext, w.ids)(const Money.kwacha(350)),
      );
      expect(second.expectedCash, const Money.kwacha(400));
      expect(prompt, GapPrompt.missingCash);
      ok(
        await RecordUntrackedCash(
          accounts: w.accounts,
          buckets: w.buckets,
          transactions: w.transactions,
          ledger: w.ledger,
          ids: w.ids,
          clock: w.clock,
        )(second.gap),
      );
      final summary = ok(
        await GetWeekSummary(
          w.ledger,
          w.transactions,
          w.buckets,
          w.cycle,
          w.clock,
        )(),
      );
      expect(summary.untrackedTotal, const Money.kwacha(50));
      expect(
        summary.spentByBucket[w.bucketOf(BucketKind.living)],
        const Money.kwacha(100),
      );
    });

    test('received cash can go to Living', () async {
      await w.startSalary(await w.canvasSetup());
      ok(
        await RecordReceivedCash(w.buckets, w.ledger, w.ids, w.clock)(
          const Money.kwacha(50),
          intoLiving: true,
        ),
      );
      final entries = ok(await w.ledger.getEntries());
      expect(
        BalanceCalculator.leftToSpend(entries, w.bucketOf(BucketKind.living)),
        const Money.kwacha(3130),
      );
    });
  });

  test('ScheduleNotifications gathers state into the scheduler', () async {
    final payday = await w.startSalary(await w.canvasSetup());
    ok(
      await CompleteSetup(
        w.accounts,
        w.buckets,
        w.incomes,
        w.settings,
        w.clock,
      )(),
    );
    await AddWish(w.planning, w.settings, w.ids, w.clock)(
      name: 'Speaker',
      amount: const Money.kwacha(700),
      bucketId: 'short',
    );
    final occurrences = InMemoryBillOccurrenceRepository();
    final due = w.clock.now().add(const Duration(days: 3));
    ok(
      await occurrences.save(
        ok(
          BillOccurrence.create(
            id: 'o1',
            billId: 'zesco',
            cycleStart: LocalDate(due.year, due.month, due.day),
            dueDate: LocalDate(due.year, due.month, due.day),
            expectedAmount: const Money.kwacha(400),
          ),
        ),
      ),
    );
    final plan = ok(
      await ScheduleNotifications(
        scheduler: w.scheduler,
        paydays: w.paydays,
        alerts: w.alerts,
        bills: w.bills,
        occurrences: occurrences,
        planning: w.planning,
        settings: w.settings,
        ledger: w.ledger,
        buckets: w.buckets,
        cycle: w.cycle,
        clock: w.clock,
        zone: w.zone,
      )(),
    );
    expect(w.scheduler.scheduled, plan);
    final kinds = plan.map((n) => n.kind).toSet();
    expect(
      kinds,
      containsAll([
        NotificationKind.billDueToday,
        NotificationKind.payday,
        NotificationKind.bill,
        NotificationKind.wish,
        NotificationKind.checkIn,
      ]),
    );
    expect(plan.first.deepLink, 'buckets://payday/${payday.id}');
    expect(plan.first.args, {'pending': '4'});
  });
}
