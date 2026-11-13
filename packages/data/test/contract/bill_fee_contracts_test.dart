import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/fakes.dart';
import 'package:buckets_data/src/repositories/bill_fee_repositories.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support.dart';

BillOccurrence occurrence(
  String id,
  String billId, {
  required LocalDate cycle,
  required LocalDate due,
  BillStatus status = BillStatus.due,
}) => ok(
  BillOccurrence.create(
    id: id,
    billId: billId,
    cycleStart: cycle,
    dueDate: due,
    expectedAmount: const Money.kwacha(2500),
    status: status,
    paidAmount: status == BillStatus.paid ? const Money.kwacha(2400) : null,
    paidAt: status == BillStatus.paid ? at : null,
    accountId: status == BillStatus.paid ? 'momo' : null,
    feeTransactionId: status == BillStatus.paid ? 'fee-1' : null,
    proofRef: status == BillStatus.paid ? 'REF' : null,
  ),
);

FeeBand band(int min, int max, int fee, {int n = 0}) => ok(
  FeeBand.create(
    minAmount: Money.kwacha(min),
    maxAmount: Money.kwacha(max),
    fee: Money.kwacha(fee),
    source: FeeBandSource.learned,
    observations: n,
  ),
);

FeeTariff tariff(AlertSource p, FeeType t, [List<FeeBand> bands = const []]) =>
    ok(FeeTariff.create(provider: p, feeType: t, bands: bands));

void main() {
  final oct = LocalDate(2026, 10, 25);
  final nov = LocalDate(2026, 11, 25);

  runContract<BillOccurrenceRepository>(
    'BillOccurrenceRepository',
    {
      'in memory': (_) => InMemoryBillOccurrenceRepository(),
      'drift': DriftBillOccurrenceRepository.new,
    },
    (repo) {
      test('save round-trips every field, and saving again replaces', () async {
        final paid = occurrence(
          'o1',
          'rent',
          cycle: oct,
          due: LocalDate(2026, 11, 1),
          status: BillStatus.paid,
        );
        ok(
          await repo().save(
            occurrence('o1', 'rent', cycle: oct, due: LocalDate(2026, 11, 1)),
          ),
        );
        ok(await repo().save(paid));
        expect(ok(await repo().getAll()), [paid]);
      });

      test(
        'getAll is oldest cycle first; getForCycle and getForBill filter',
        () async {
          final a = occurrence(
            'a',
            'rent',
            cycle: nov,
            due: LocalDate(2026, 12, 1),
          );
          final b = occurrence(
            'b',
            'rent',
            cycle: oct,
            due: LocalDate(2026, 11, 1),
          );
          final c = occurrence(
            'c',
            'zesco',
            cycle: oct,
            due: LocalDate(2026, 10, 28),
          );
          for (final o in [a, b, c]) {
            ok(await repo().save(o));
          }
          expect(ok(await repo().getAll()).map((o) => o.id), ['c', 'b', 'a']);
          expect(ok(await repo().getForCycle(oct)).map((o) => o.id), [
            'c',
            'b',
          ]);
          expect(ok(await repo().getForBill('rent')).map((o) => o.id), [
            'b',
            'a',
          ]);
        },
      );

      test('watchAll emits after a save', () async {
        final seen = <int>[];
        final sub = repo().watchAll().listen((x) => seen.add(x.length));
        await pumpEventQueue();
        ok(
          await repo().save(
            occurrence('a', 'rent', cycle: oct, due: LocalDate(2026, 11, 1)),
          ),
        );
        await pumpEventQueue();
        await sub.cancel();
        expect(seen.last, 1);
      });
    },
  );

  runContract<FeeTariffRepository>(
    'FeeTariffRepository',
    {
      'in memory': (_) => InMemoryFeeTariffRepository(),
      'drift': DriftFeeTariffRepository.new,
    },
    (repo) {
      test('starts empty and finds nothing', () async {
        expect(ok(await repo().getAll()), isEmpty);
        expect(
          ok(await repo().find(AlertSource.mtnMomo, FeeType.send)),
          isNull,
        );
      });

      test('save round-trips bands, and saving again replaces them', () async {
        final first = tariff(AlertSource.mtnMomo, FeeType.send, [
          band(1, 100, 1, n: 3),
        ]);
        ok(await repo().save(first));
        expect(ok(await repo().find(AlertSource.mtnMomo, FeeType.send)), first);
        final second = tariff(AlertSource.mtnMomo, FeeType.send, [
          band(101, 500, 5),
        ]);
        ok(await repo().save(second));
        expect(
          ok(await repo().find(AlertSource.mtnMomo, FeeType.send)),
          second,
        );
      });

      test(
        'a tariff with no bands still exists; tariffs stay separate',
        () async {
          ok(
            await repo().save(
              tariff(AlertSource.mtnMomo, FeeType.send, [band(1, 9, 1)]),
            ),
          );
          ok(await repo().save(tariff(AlertSource.airtelMoney, FeeType.send)));
          ok(await repo().save(tariff(AlertSource.mtnMomo, FeeType.send)));
          expect(ok(await repo().getAll()), hasLength(2));
          expect(
            ok(await repo().find(AlertSource.mtnMomo, FeeType.send))!.bands,
            isEmpty,
          );
        },
      );

      test('watchAll emits after a save', () async {
        final seen = <int>[];
        final sub = repo().watchAll().listen((x) => seen.add(x.length));
        await pumpEventQueue();
        ok(await repo().save(tariff(AlertSource.mtnMomo, FeeType.send)));
        await pumpEventQueue();
        await sub.cancel();
        expect(seen.last, 1);
      });
    },
  );
}
