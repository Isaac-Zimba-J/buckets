import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/repositories/activity_repositories.dart';
import 'package:buckets_data/src/repositories/money_repositories.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

Transfer transfer(String id, [List<String> refs = const []]) => ok(
  Transfer.create(
    id: id,
    bucketId: 'b',
    toAccountId: 'savings',
    amount: const Money.kwacha(770),
    proofRefs: refs,
  ),
);

Payday payday(String id, DateTime started, {bool complete = false}) => ok(
  Payday.create(
    id: id,
    incomeSourceId: 'salary',
    amount: const Money.kwacha(12000),
    startedAt: started,
    transfers: [
      transfer('$id-t1', const ['ZX98']),
      transfer('$id-t2'),
    ],
    status: complete ? PaydayStatus.complete : PaydayStatus.open,
  ),
);

PaymentAlert alert(String id, {String? ref, DateTime? received}) => ok(
  PaymentAlert.create(
    id: id,
    rawText: '[MESSAGE]',
    source: AlertSource.mtnMomo,
    receivedAt: received ?? at,
    parsed: ParsedMessage(confidence: 1, reference: ref),
  ),
);

Transaction tx(String id, DateTime when) => ok(
  Transaction.create(
    id: id,
    amount: const Money.kwacha(185),
    bucketId: 'living',
    category: Category.food,
    accountId: 'momo',
    occurredAt: when,
    source: TransactionSource.cash,
    lines: const [
      TransactionLine('living', Money.kwacha(100)),
      TransactionLine('family', Money.kwacha(85)),
    ],
  ),
);

void main() {
  runContract<PaydayRepository>(
    'PaydayRepository',
    {
      'in memory': (_) => InMemoryPaydayRepository(),
      'drift': DriftPaydayRepository.new,
    },
    (repo) {
      test('save, get, newest first, proof references', () async {
        ok(await repo().save(payday('old', at, complete: true)));
        ok(await repo().save(payday('new', at.add(const Duration(days: 30)))));
        expect(ok(await repo().getAll()).map((p) => p.id), ['new', 'old']);
        expect(ok(await repo().get('old')), payday('old', at, complete: true));
        expect(await repo().get('nope'), isErr('notFound'));
        expect(ok(await repo().isProofReferenceUsed('ZX98')), isTrue);
        expect(ok(await repo().isProofReferenceUsed('QQ11')), isFalse);
      });

      test('watchOpen and watch follow saves', () async {
        expect(await repo().watchOpen().first, isNull);
        final open = payday('p', at);
        ok(await repo().save(open));
        expect(await repo().watchOpen().first, open);
        expect(await repo().watch('p').first, open);
        final done = ok(open.copyWith(status: PaydayStatus.complete));
        ok(await repo().save(done));
        expect(await repo().watchOpen().first, isNull);
      });
    },
  );

  runContract<AlertRepository>(
    'AlertRepository',
    {
      'in memory': (_) => InMemoryAlertRepository(),
      'drift': DriftAlertRepository.new,
    },
    (repo) {
      test('save, get, findByReference, getReceivedIn', () async {
        ok(await repo().save(alert('a', ref: 'ZX98')));
        ok(
          await repo().save(
            alert('b', received: at.add(const Duration(hours: 5))),
          ),
        );
        expect(ok(await repo().get('a')).parsed.reference, 'ZX98');
        expect(
          ok(await repo().findByReference(AlertSource.mtnMomo, 'ZX98'))?.id,
          'a',
        );
        expect(
          ok(await repo().findByReference(AlertSource.bank, 'ZX98')),
          isNull,
        );
        final window = ok(
          DateWindow.create(at, at.add(const Duration(hours: 1))),
        );
        expect(ok(await repo().getReceivedIn(window)).map((x) => x.id), ['a']);
      });

      test('R-PRIV-2 clears raw text before the cutoff only', () async {
        ok(await repo().save(alert('old')));
        ok(
          await repo().save(
            alert('new', received: at.add(const Duration(days: 91))),
          ),
        );
        ok(await repo().clearRawTextBefore(at.add(const Duration(days: 1))));
        expect(ok(await repo().get('old')).rawText, isNull);
        expect(ok(await repo().get('old')).parsed, alert('old').parsed);
        expect(ok(await repo().get('new')).rawText, '[MESSAGE]');
      });

      test('watchByStatus, oldest first', () async {
        ok(
          await repo().save(
            alert('b', received: at.add(const Duration(minutes: 1))),
          ),
        );
        ok(await repo().save(alert('a')));
        expect(
          (await repo().watchByStatus(AlertStatus.newAlert).first).map(
            (x) => x.id,
          ),
          ['a', 'b'],
        );
        expect(await repo().watchByStatus(AlertStatus.sorted).first, isEmpty);
      });
    },
  );

  runContract<TransactionRepository>(
    'TransactionRepository',
    {
      'in memory': (_) => InMemoryTransactionRepository(),
      'drift': DriftTransactionRepository.new,
    },
    (repo) {
      test('save with lines, get, getIn, watchRecent', () async {
        ok(await repo().save(tx('1', at)));
        ok(await repo().save(tx('2', at.add(const Duration(days: 1)))));
        expect(ok(await repo().get('1')), tx('1', at));
        expect(await repo().get('nope'), isErr('notFound'));
        final day = ok(DateWindow.create(at, at.add(const Duration(hours: 1))));
        expect(ok(await repo().getIn(day)).map((t) => t.id), ['1']);
        expect((await repo().watchRecent(1).first).map((t) => t.id), ['2']);
      });

      test('withdrawals in a window', () async {
        final w = ok(
          CashWithdrawal.create(
            id: 'w',
            amount: const Money.kwacha(500),
            fromAccountId: 'momo',
            cashAccountId: 'cash',
            occurredAt: at,
          ),
        );
        ok(await repo().saveWithdrawal(w));
        final day = ok(DateWindow.create(at, at.add(const Duration(hours: 1))));
        expect(ok(await repo().getWithdrawalsIn(day)), [w]);
      });
    },
  );

  runContract<MerchantRuleRepository>(
    'MerchantRuleRepository',
    {
      'in memory': (_) => InMemoryMerchantRuleRepository(),
      'drift': DriftMerchantRuleRepository.new,
    },
    (repo) {
      test('one rule per merchant key', () async {
        final key = ok(MerchantKey.create('zesco'));
        MerchantRule rule(String id, Category c) => MerchantRule(
          id: id,
          merchantKey: key,
          category: c,
          bucketId: 'living',
        );
        expect(ok(await repo().findByKey(key)), isNull);
        ok(await repo().save(rule('r1', Category.bill)));
        ok(await repo().save(rule('r2', Category.other)));
        expect(ok(await repo().findByKey(key))?.category, Category.other);
      });

      test('getAll, watchAll and delete', () async {
        MerchantRule rule(String id, String merchant) => MerchantRule(
          id: id,
          merchantKey: ok(MerchantKey.create(merchant)),
          category: Category.food,
          bucketId: 'living',
        );
        ok(await repo().save(rule('r1', 'Shoprite')));
        ok(await repo().save(rule('r2', 'Melissa')));
        expect(ok(await repo().getAll()).map((r) => r.id), ['r2', 'r1']);

        final seen = <int>[];
        final sub = repo().watchAll().listen((rs) => seen.add(rs.length));
        await pumpEventQueue();
        ok(await repo().delete('r1'));
        await pumpEventQueue();
        await sub.cancel();
        expect(seen.last, 1);
        expect(ok(await repo().getAll()).map((r) => r.id), ['r2']);
      });
    },
  );

  runContract<ReceiptRepository>(
    'ReceiptRepository',
    {
      'in memory': (_) => InMemoryReceiptRepository(),
      'drift': DriftReceiptRepository.new,
    },
    (repo) {
      test('save and get a draft', () async {
        final r = StoredReceipt(
          id: 'r',
          imagePath: '/private/r.jpg',
          draft: ReceiptDraft(total: Scored(const Money(41250), 0.7)),
        );
        ok(await repo().save(r));
        expect(ok(await repo().get('r')), r);
        expect(await repo().get('nope'), isErr('notFound'));
      });
    },
  );

  runContract<PlanningRepository>(
    'PlanningRepository',
    {
      'in memory': (_) => InMemoryPlanningRepository(),
      'drift': DriftPlanningRepository.new,
    },
    (repo) {
      test('planned purchases and wishes', () async {
        final p = ok(
          PlannedPurchase.create(
            id: 'p',
            name: 'Gas',
            amount: const Money.kwacha(350),
            bucketId: 'living',
          ),
        );
        final w = ok(
          Wish.create(
            id: 'w',
            name: 'Speaker',
            amount: const Money.kwacha(700),
            bucketId: 'short',
            createdAt: at,
            endsAt: at.add(const Duration(hours: 48)),
          ),
        );
        ok(await repo().savePlanned(p));
        ok(await repo().saveWish(w));
        expect(await repo().watchPlanned().first, [p]);
        expect(await repo().watchWishes().first, [w]);
        expect(ok(await repo().getWish('w')), w);
        expect(await repo().getWish('nope'), isErr('notFound'));
      });
    },
  );

  runContract<GoalRepository>(
    'GoalRepository',
    {
      'in memory': (_) => InMemoryGoalRepository(),
      'drift': DriftGoalRepository.new,
    },
    (repo) {
      test('save, get by bucket, watchAll', () async {
        final g = ok(Goal.create(bucketId: 'laptop', target: const Money(1)));
        expect(ok(await repo().get('laptop')), isNull);
        ok(await repo().save(g));
        expect(ok(await repo().get('laptop')), g);
        expect(await repo().watchAll().first, [g]);
      });
    },
  );

  runContract<CheckInRepository>(
    'CheckInRepository',
    {
      'in memory': (_) => InMemoryCheckInRepository(),
      'drift': DriftCheckInRepository.new,
    },
    (repo) {
      test('latest is the most recent count', () async {
        CheckIn c(String id, int days) => ok(
          CheckIn.create(
            id: id,
            countedAt: at.add(Duration(days: days)),
            expectedCash: Money.zero,
            countedCash: Money.zero,
          ),
        );
        expect(ok(await repo().latest()), isNull);
        ok(await repo().save(c('new', 7)));
        ok(await repo().save(c('old', 0)));
        expect(ok(await repo().latest())?.id, 'new');
      });
    },
  );

  runContract<HeldIncomeRepository>(
    'HeldIncomeRepository',
    {
      'in memory': (_) => InMemoryHeldIncomeRepository(),
      'drift': DriftHeldIncomeRepository.new,
    },
    (repo) {
      test('add, getFor in order, remove', () async {
        HeldIncome h(String id, String income, int minutes) => ok(
          HeldIncome.create(
            id: id,
            incomeSourceId: income,
            amount: const Money.kwacha(100),
            receivedAt: at.add(Duration(minutes: minutes)),
          ),
        );
        ok(await repo().add(h('b', 'hustle', 2)));
        ok(await repo().add(h('a', 'hustle', 1)));
        ok(await repo().add(h('x', 'other', 0)));
        expect(ok(await repo().getFor('hustle')).map((x) => x.id), ['a', 'b']);
        ok(await repo().remove(['a', 'b']));
        expect(ok(await repo().getFor('hustle')), isEmpty);
      });
    },
  );

  test(
    'a database error becomes a StorageFailure, never an exception',
    () async {
      final db = BucketsDatabase(NativeDatabase.memory());
      await db.customStatement('DROP TABLE goals');
      expect(await DriftGoalRepository(db).get('x'), isErr('storage'));
      await db.close();
    },
  );
}
