import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';
import '../../support/world.dart';

// A synthetic message format for the engine; real provider templates come
// from redacted fixtures (AGENTS.md §5).
final SmsParser testParser = SmsParser([
  MessageTemplate(
    source: AlertSource.unknown,
    name: 'test-sent',
    direction: MessageDirection.outgoing,
    pattern: RegExp(
      r'^TEST SENT K(?<amount>[\d,.]+) TO (?<counterparty>.+?) '
      r'REF (?<reference>\w+) AT (?<date>\d{4}-\d{2}-\d{2} \d{2}:\d{2})$',
    ),
    parseDate: (raw, offset) {
      final p = raw.split(RegExp('[- :]')).map(int.parse).toList();
      return DateTime.utc(p[0], p[1], p[2], p[3], p[4]).subtract(offset);
    },
  ),
]);

String sent(String amount, String ref) =>
    'TEST SENT K$amount TO acc ****4521 REF $ref AT 2026-10-25 09:00';

class PaydayWorld extends World {
  PaydayWorld() {
    accounts.store.items['savings'] = ok(
      Account.create(
        id: 'savings',
        name: 'Savings',
        kind: AccountKind.bank,
        matchKeys: [ok(MatchKey.create('4521'))],
      ),
    );
    buckets.store.items['laptop'] = ok(
      Bucket.create(
        id: 'laptop',
        name: 'Laptop',
        kind: BucketKind.goal,
        color: BucketColor.goal,
        accountId: 'savings',
        sortOrder: 5,
      ),
    );
  }

  late final reservations = GetBillReservations(
    bills,
    ledger,
    incomes,
    clock,
    zone,
  );
  late final start = StartPayday(
    incomes: incomes,
    profiles: profiles,
    buckets: buckets,
    reservations: reservations,
    ledger: ledger,
    paydays: paydays,
    ids: ids,
    clock: clock,
  );
  late final prove = ProveTransfer(paydays, accounts, testParser, clock, zone);

  /// Salary with the canvas split and K 4,300 of bills.
  Future<IncomeSource> canvasSetup() async {
    final salary = ok(
      await SaveIncomeSource(incomes, profiles, buckets, settings, ids)(
        name: 'Salary',
        kind: IncomeKind.salary,
        landsInAccountId: 'momo',
        expectedAmount: const Money.kwacha(12000),
        schedule: const MonthlyPay(25),
        payerKeys: ['[EMPLOYER]'],
      ),
    );
    final saveBill = SaveBill(bills, buckets, ids);
    for (final (name, kwacha) in [
      ('Rent', 2500),
      ('ZESCO', 400),
      ('Water', 600),
    ]) {
      await saveBill(
        name: name,
        amount: Money.kwacha(kwacha),
        frequency: BillFrequency.monthly,
        dueDay: 1,
      );
    }
    await saveBill(
      name: 'School fees',
      amount: const Money.kwacha(2400),
      frequency: BillFrequency.termly,
      nextDueDate: DateTime.utc(2027, 1, 10),
    );
    return salary;
  }

  Future<Payday> startSalary(IncomeSource salary) async => ok(
    await start(incomeSourceId: salary.id, amount: const Money.kwacha(12000)),
  );
}

void main() {
  late PaydayWorld w;
  setUp(() => w = PaydayWorld());

  group('StartPayday', () {
    test('canvas: 4 transfers, K 3,850; Living left K 3,080', () async {
      final payday = await w.startSalary(await w.canvasSetup());
      expect(payday.transfers, hasLength(4));
      expect(
        payday.transfers.fold(Money.zero, (s, t) => s + t.amount),
        const Money.kwacha(3850),
      );
      final entries = ok(await w.ledger.getEntries());
      final living = w.bucketOf(BucketKind.living);
      expect(
        BalanceCalculator.leftToSpend(entries, living),
        const Money.kwacha(3080),
      );
      expect(ok(await w.paydays.get(payday.id)), payday);
    });

    test('one open payday per income', () async {
      final salary = await w.canvasSetup();
      await w.startSalary(salary);
      expect(
        await w.start(incomeSourceId: salary.id, amount: const Money(1)),
        isErr('payday.alreadyOpen'),
      );
    });

    test('a salary payday settles carry-overs (R-OVER-2)', () async {
      final salary = await w.canvasSetup();
      final living = w.bucketOf(BucketKind.living);
      await w.ledger.append(
        ok(
          OverspendPolicy.cover(
            CoverFromNextCycle(living),
            overspentBucketId: living,
            amount: const Money.kwacha(310),
            ids: w.ids,
            at: DateTime.utc(2026, 10, 20),
          ),
        ),
      );
      await w.startSalary(salary);
      final entries = ok(await w.ledger.getEntries());
      expect(OverspendPolicy.pendingCarryOvers(entries), isEmpty);
    });
  });

  group('SnoozePaydayAlarm', () {
    test('uses a snooze and records when the alarm resumes', () async {
      final payday = await w.startSalary(await w.canvasSetup());
      final snoozed = ok(
        await SnoozePaydayAlarm(w.paydays, w.settings, w.clock, w.zone)(
          payday.id,
        ),
      );
      expect(snoozed.snoozesUsed, 1);
      // 08:00 local → 20:00 local.
      expect(snoozed.snoozedUntil, DateTime.utc(2026, 10, 25, 18));
      expect(
        await SnoozePaydayAlarm(w.paydays, w.settings, w.clock, w.zone)(
          payday.id,
        ),
        isErr('snooze.noneLeft'),
      );
      expect(await WatchPayday(w.paydays)(payday.id).first, snoozed);
    });
  });

  group('Proofs', () {
    late Payday payday;
    late Transfer emergency;
    setUp(() async {
      payday = await w.startSalary(await w.canvasSetup());
      emergency = payday.transfers.firstWhere(
        (t) => t.bucketId == w.bucketOf(BucketKind.emergency),
      );
    });

    test('a passing proof marks the transfer proven (R-PROOF-1)', () async {
      final outcome = ok(
        await w.prove(
          paydayId: payday.id,
          transferId: emergency.id,
          text: sent('770.00', 'ZX98'),
        ),
      );
      expect(outcome.result.passed, isTrue);
      final saved = outcome.payday.transfers.firstWhere(
        (t) => t.id == emergency.id,
      );
      expect(saved.status, TransferStatus.proven);
    });

    test('a reused reference fails (R-PROOF-1.4)', () async {
      await w.prove(
        paydayId: payday.id,
        transferId: emergency.id,
        text: sent('770.00', 'ZX98'),
      );
      final short = payday.transfers.firstWhere(
        (t) => t.bucketId == w.bucketOf(BucketKind.shortTerm),
      );
      final outcome = ok(
        await w.prove(
          paydayId: payday.id,
          transferId: short.id,
          text: sent('770.00', 'ZX98'),
        ),
      );
      expect(outcome.result.reference, const CheckFailed('referenceUsed'));
      expect(outcome.payday, ok(await w.paydays.get(payday.id)));
    });

    test('unparsed text fails with every check unknown (R-PROOF-2)', () async {
      final outcome = ok(
        await w.prove(
          paydayId: payday.id,
          transferId: emergency.id,
          text: 'hello',
        ),
      );
      expect(outcome.result.checks, everyElement(const CheckUnknown()));
      expect(outcome.canSavePartial, isFalse);
    });

    test('partial, then the owed amount completes it (R-PROOF-3)', () async {
      final low = sent('700.00', 'AA11');
      final failed = ok(
        await w.prove(paydayId: payday.id, transferId: emergency.id, text: low),
      );
      expect(failed.canSavePartial, isTrue);
      final partial = ok(
        await RecordPartialTransfer(w.prove, w.clock)(
          paydayId: payday.id,
          transferId: emergency.id,
          text: low,
        ),
      );
      final t = partial.transfers.firstWhere((t) => t.id == emergency.id);
      expect(t.owedAmount, const Money.kwacha(70));
      final rest = ok(
        await w.prove(
          paydayId: payday.id,
          transferId: emergency.id,
          text: sent('70.00', 'BB22'),
        ),
      );
      expect(rest.result.passed, isTrue);
    });

    test('self-reporting every transfer completes the payday', () async {
      final mark = MarkTransferSelfReported(w.paydays, w.prove, w.clock);
      Payday? last;
      for (final t in payday.transfers) {
        last = ok(await mark(paydayId: payday.id, transferId: t.id));
      }
      expect(last!.status, PaydayStatus.complete);
      expect(
        await mark(paydayId: payday.id, transferId: 'nope'),
        isErr('transfer.notFound'),
      );
    });

    test('GetPaydaySummary after the payday (screen 16)', () async {
      await w.prove(
        paydayId: payday.id,
        transferId: emergency.id,
        text: sent('770.00', 'ZX98'),
      );
      await w.goals.save(
        ok(Goal.create(bucketId: 'laptop', target: const Money.kwacha(9000))),
      );
      final summary = ok(
        await GetPaydaySummary(
          paydays: w.paydays,
          ledger: w.ledger,
          buckets: w.buckets,
          goals: w.goals,
          incomes: w.incomes,
          clock: w.clock,
          zone: w.zone,
        )(payday.id),
      );
      expect(summary.moved, const Money.kwacha(770));
      expect(summary.livingLeft, const Money.kwacha(3080));
      expect(summary.guiltFreeLeft, const Money.kwacha(770));
      // 3,080 over 31 days (25 Oct – 24 Nov).
      expect(summary.perDay, const Money(9935));
      expect(summary.streak, 0);
      expect(summary.topGoal?.target, const Money.kwacha(9000));
      expect(summary.topGoal?.balance, const Money.kwacha(770));
    });
  });

  group('Side hustle (screen 17)', () {
    late IncomeSource hustle;
    late PaymentAlert alert;
    setUp(() async {
      await w.canvasSetup();
      w.buckets.store.items['restock'] = ok(
        Bucket.create(
          id: 'restock',
          name: 'Restock',
          kind: BucketKind.business,
          color: BucketColor.business,
          accountId: 'momo',
        ),
      );
      hustle = ok(
        await SaveIncomeSource(
          w.incomes,
          w.profiles,
          w.buckets,
          w.settings,
          w.ids,
        )(
          name: 'Tutoring',
          kind: IncomeKind.sideHustle,
          landsInAccountId: 'momo',
        ),
      );
      alert = ok(
        PaymentAlert.create(
          id: 'al',
          rawText: null,
          source: AlertSource.mtnMomo,
          receivedAt: w.clock.now(),
          parsed: ParsedMessage(
            confidence: 1,
            direction: MessageDirection.incoming,
            amount: const Money.kwacha(2000),
            counterparty: '[CUSTOMER]',
          ),
        ),
      );
      await w.alerts.save(alert);
    });

    test('ClassifyIncomingAlert (R-PARSE-5)', () async {
      expect(
        ok(await ClassifyIncomingAlert(w.alerts, w.incomes)('al')),
        IncomeSuggestion.sideHustle,
      );
    });

    test('split it now: a side-hustle payday, alert sorted', () async {
      final payday = ok(
        await SplitSideHustleIncome(w.alerts, w.start)(
          alertId: 'al',
          incomeSourceId: hustle.id,
        ),
      );
      expect(payday.amount, const Money.kwacha(2000));
      expect(ok(await w.alerts.get('al')).status, AlertStatus.sorted);
    });

    test(
      'hold until month end, then release as one payday (R-PAY-6)',
      () async {
        final hold = HoldSideHustleIncome(
          w.alerts,
          w.held,
          w.ids,
          w.clock,
          w.zone,
        );
        final (held, releaseAt) = ok(
          await hold(alertId: 'al', incomeSourceId: hustle.id),
        );
        expect(held.amount, const Money.kwacha(2000));
        expect(releaseAt, DateTime.utc(2026, 10, 31, 16));
        final release = ReleaseHeldIncome(w.held, w.start);
        final payday = ok(await release(hustle.id))!;
        expect(payday.amount, const Money.kwacha(2000));
        expect(ok(await release(hustle.id)), isNull);
      },
    );

    test('a missing amount must be entered', () async {
      final blank = ok(
        PaymentAlert.create(
          id: 'blank',
          rawText: null,
          source: AlertSource.mtnMomo,
          receivedAt: w.clock.now(),
          parsed: ParsedMessage.unparsed,
        ),
      );
      await w.alerts.save(blank);
      expect(
        await SplitSideHustleIncome(w.alerts, w.start)(
          alertId: 'blank',
          incomeSourceId: hustle.id,
        ),
        isErr('amount.missing'),
      );
      expect(
        await HoldSideHustleIncome(w.alerts, w.held, w.ids, w.clock, w.zone)(
          alertId: 'blank',
          incomeSourceId: hustle.id,
        ),
        isErr('amount.missing'),
      );
    });

    test('IgnoreAlert', () async {
      expect(ok(await IgnoreAlert(w.alerts)('al')).status, AlertStatus.ignored);
    });
  });
}
