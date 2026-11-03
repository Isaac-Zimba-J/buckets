import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_data/src/repositories/money_repositories.dart';
import 'package:buckets_data/src/repositories/setup_repositories.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

Account account(String id, {String name = 'Zanaco', bool spending = false}) =>
    ok(
      Account.create(
        id: id,
        name: name,
        kind: AccountKind.bank,
        matchKeys: [ok(MatchKey.create('4521'))],
        isSpending: spending,
      ),
    );

Bucket bucket(String id, int order) => ok(
  Bucket.create(
    id: id,
    name: 'Bucket $id',
    kind: BucketKind.custom,
    color: BucketColor.goal,
    accountId: 'a',
    sortOrder: order,
  ),
);

void main() {
  runContract<AccountRepository>(
    'AccountRepository',
    {
      'in memory': (_) => InMemoryAccountRepository(),
      'drift': DriftAccountRepository.new,
    },
    (repo) {
      test('save, get, getAll and replace', () async {
        ok(await repo().save(account('a')));
        ok(await repo().save(account('a', name: 'Renamed', spending: true)));
        ok(await repo().save(account('b')));
        expect(ok(await repo().get('a')).name, 'Renamed');
        expect(ok(await repo().get('a')).matchKeys.single.value, '4521');
        expect(ok(await repo().getAll()), hasLength(2));
      });

      test('a missing account is NotFound', () async {
        expect(await repo().get('nope'), isErr('notFound'));
      });

      test('watchAll emits now and after a change', () async {
        final seen = <int>[];
        final sub = repo().watchAll().listen((a) => seen.add(a.length));
        await pumpEventQueue();
        ok(await repo().save(account('a')));
        await pumpEventQueue();
        await sub.cancel();
        expect(seen.first, 0);
        expect(seen.last, 1);
      });
    },
  );

  runContract<BucketRepository>(
    'BucketRepository',
    {
      'in memory': (_) => InMemoryBucketRepository(),
      'drift': DriftBucketRepository.new,
    },
    (repo) {
      test('saveAll, sort order, get', () async {
        ok(
          await repo().saveAll([
            bucket('z', 2),
            bucket('a', 0),
            bucket('m', 1),
          ]),
        );
        expect(ok(await repo().getAll()).map((b) => b.id), ['a', 'm', 'z']);
        expect(ok(await repo().get('m')).sortOrder, 1);
        expect(await repo().get('nope'), isErr('notFound'));
        expect((await repo().watchAll().first).map((b) => b.id), [
          'a',
          'm',
          'z',
        ]);
      });
    },
  );

  runContract<IncomeRepository>(
    'IncomeRepository',
    {
      'in memory': (_) => InMemoryIncomeRepository(),
      'drift': DriftIncomeRepository.new,
    },
    (repo) {
      test('save, get, getAll', () async {
        final income = ok(
          IncomeSource.create(
            id: 'i',
            name: 'Salary',
            kind: IncomeKind.salary,
            schedule: const MonthlyPay(25),
            landsInAccountId: 'a',
            splitProfileId: 'p',
          ),
        );
        ok(await repo().save(income));
        expect(ok(await repo().get('i')), income);
        expect(ok(await repo().getAll()), [income]);
        expect(await repo().get('nope'), isErr('notFound'));
      });
    },
  );

  runContract<SplitProfileRepository>(
    'SplitProfileRepository',
    {
      'in memory': (_) => InMemorySplitProfileRepository(),
      'drift': DriftSplitProfileRepository.new,
    },
    (repo) {
      test('save and replace keep allocation order', () async {
        SplitProfile p(List<(String, int)> a) => ok(
          SplitProfile.create(
            id: 'p',
            allocations: [
              for (final (b, bp) in a) Allocation(b, BasisPoints(bp)),
            ],
          ),
        );
        ok(await repo().save(p([('a', 5000), ('b', 5000)])));
        final replaced = p([('c', 2000), ('a', 8000)]);
        ok(await repo().save(replaced));
        expect(ok(await repo().get('p')), replaced);
        expect(await repo().get('nope'), isErr('notFound'));
      });
    },
  );

  runContract<BillRepository>(
    'BillRepository',
    {
      'in memory': (_) => InMemoryBillRepository(),
      'drift': DriftBillRepository.new,
    },
    (repo) {
      test('save, delete, watchAll', () async {
        final bill = ok(
          Bill.create(
            id: 'b',
            name: 'Rent',
            amount: const Money.kwacha(2500),
            frequency: BillFrequency.monthly,
            dueDay: 1,
            paidFromBucketId: 'living',
          ),
        );
        ok(await repo().save(bill));
        expect(await repo().watchAll().first, [bill]);
        ok(await repo().delete('b'));
        expect(ok(await repo().getAll()), isEmpty);
      });
    },
  );

  runContract<SettingsRepository>(
    'SettingsRepository',
    {
      'in memory': (_) => InMemorySettingsRepository(),
      'drift': DriftSettingsRepository.new,
    },
    (repo) {
      test('defaults until saved, then the saved settings', () async {
        expect(ok(await repo().get()), Settings.defaults);
        final changed = ok(Settings.defaults.copyWith(snoozeLimit: 3));
        ok(await repo().save(changed));
        expect(ok(await repo().get()), changed);
        expect(await repo().watch().first, changed);
      });
    },
  );

  runContract<LedgerRepository>(
    'LedgerRepository',
    {
      'in memory': (_) => InMemoryLedgerRepository(),
      'drift': DriftLedgerRepository.new,
    },
    (repo) {
      LedgerEntry e(String id, String bucket, DateTime when, int ngwee) => ok(
        LedgerEntry.create(
          id: id,
          occurredAt: when,
          kind: LedgerEntryKind.allocation,
          bucketId: bucket,
          amount: Money(ngwee),
        ),
      );

      test('append, order, filter by bucket and window', () async {
        ok(
          await repo().append([
            e('2', 'living', at.add(const Duration(hours: 2)), 2),
            e('1', 'living', at, 1),
            e('3', 'fun', at.add(const Duration(hours: 1)), 3),
          ]),
        );
        expect(ok(await repo().getEntries()).map((x) => x.id), ['1', '3', '2']);
        expect(
          ok(await repo().getEntries(bucketId: 'living')).map((x) => x.id),
          ['1', '2'],
        );
        final window = ok(
          DateWindow.create(at, at.add(const Duration(hours: 2))),
        );
        expect(ok(await repo().getEntries(window: window)).map((x) => x.id), [
          '1',
          '3',
        ]);
      });

      test('watchEntries emits after an append', () async {
        final seen = <int>[];
        final sub = repo().watchEntries().listen((x) => seen.add(x.length));
        await pumpEventQueue();
        ok(await repo().append([e('1', 'living', at, 1)]));
        await pumpEventQueue();
        await sub.cancel();
        expect(seen.last, 1);
      });
    },
  );
}
