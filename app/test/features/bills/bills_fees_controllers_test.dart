import 'package:buckets/bootstrap/bills_fees_use_cases.dart';
import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/overrides.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/bills/presentation/controllers/bill_history_controller.dart';
import 'package:buckets/features/bills/presentation/controllers/bill_pay_controller.dart';
import 'package:buckets/features/bills/presentation/controllers/bills_cycle_controller.dart';
import 'package:buckets/features/bills/presentation/controllers/fee_rates_controller.dart';
import 'package:buckets/features/bills/presentation/controllers/fees_controller.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_controller.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show ProviderListenable;
import 'package:flutter_test/flutter_test.dart';

Future<T> next<T>(
  ProviderContainer c,
  ProviderListenable<AsyncValue<T>> p,
) async {
  c.listen(p, (_, _) {});
  for (var i = 0; i < 200; i++) {
    final v = c.read(p);
    if (v case AsyncData(:final value) when !v.isLoading) return value;
    if (v case AsyncError(:final error)) fail('$p failed: $error');
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  fail('no value for $p');
}

void main() {
  late ProviderContainer c;
  setUp(() {
    c = ProviderContainer(overrides: fakePortOverrides());
    addTearDown(c.dispose);
  });

  Future<String> firstBillId() async =>
      (await c.read(billRepositoryProvider).getAll()).orThrow().first.id;

  group('BillsCycleController (33)', () {
    test('no bills: the empty state', () async {
      final s = await next(c, billsCycleControllerProvider);
      expect(s.isEmpty, isTrue);
    });

    test('bills this cycle, none paid yet', () async {
      (await seedDemo(c)).orThrow();
      final s = await next(c, billsCycleControllerProvider);
      expect(s.isEmpty, isFalse);
      expect(s.allPaid, isFalse);
      expect(s.view!.rows, hasLength(4));
      expect(s.view!.paidCount, 0);
      expect(s.view!.setAside, const Money.kwacha(4300));
      expect(s.feesTotal, Money.zero);
    });
  });

  group('BillPayController (34)', () {
    test('pays a bill; fee unknown is booked as missing', () async {
      (await seedDemo(c)).orThrow();
      await next(c, billsCycleControllerProvider);
      final id = await firstBillId();
      final sheet = await next(c, billPayControllerProvider(id));
      expect(sheet.defaultAccountId, 'momo');
      expect(
        sheet.accounts.firstWhere((a) => a.id == 'momo').chargesFees,
        isTrue,
      );

      final ctrl = c.read(billPayControllerProvider(id).notifier);
      expect(
        await ctrl.estimateFee(amount: sheet.expected, accountId: 'momo'),
        isNull,
      );
      expect(await ctrl.pay(amount: sheet.expected, accountId: 'momo'), isTrue);

      final cycle = (await c.read(getBillsCycleProvider)()).orThrow()!;
      expect(cycle.paidCount, 1);
      // The bill is settled, so the sheet has nothing left to pay.
      c
        ..invalidate(billPayControllerProvider(id))
        ..listen(billPayControllerProvider(id), (_, _) {});
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(c.read(billPayControllerProvider(id)).hasError, isTrue);
    });

    test('a saved rate estimates the fee', () async {
      (await seedDemo(c)).orThrow();
      await next(c, billsCycleControllerProvider);
      final id = await firstBillId();
      await next(c, billPayControllerProvider(id));
      (await c.read(saveFeeBandProvider)(
        provider: AlertSource.mtnMomo,
        feeType: FeeType.billPay,
        min: Money.zero,
        max: const Money.kwacha(5000),
        fee: const Money.kwacha(3),
      )).orThrow();
      expect(
        await c
            .read(billPayControllerProvider(id).notifier)
            .estimateFee(amount: const Money.kwacha(2500), accountId: 'momo'),
        const Money.kwacha(3),
      );
    });
  });

  group('FeesController (36) and BillHistoryController (35)', () {
    test('empty, then a missing fee shows after paying', () async {
      (await seedDemo(c)).orThrow();
      await next(c, billsCycleControllerProvider);
      final empty = await next(c, feesControllerProvider);
      expect(empty.isEmpty, isTrue);

      final id = await firstBillId();
      final sheet = await next(c, billPayControllerProvider(id));
      await c
          .read(billPayControllerProvider(id).notifier)
          .pay(amount: sheet.expected, accountId: 'momo');
      await Future<void>.delayed(const Duration(milliseconds: 50));
      final fees = await next(c, feesControllerProvider);
      expect(fees.missing, hasLength(1));
      expect(fees.summary!.missingCount, 1);

      final history = await next(c, billHistoryControllerProvider(id));
      expect(
        history.occurrences.any((o) => o.status == BillStatus.paid),
        isTrue,
      );
      expect(history.isFirstCycle, isFalse);
    });

    test('a bill with nothing paid is the first-cycle state', () async {
      (await seedDemo(c)).orThrow();
      await next(c, billsCycleControllerProvider);
      final history = await next(
        c,
        billHistoryControllerProvider(await firstBillId()),
      );
      expect(history.isFirstCycle, isTrue);
    });
  });

  group('FeeRatesController (37)', () {
    test('saves and deletes a band', () async {
      expect(await next(c, feeRatesControllerProvider), isEmpty);
      final ctrl = c.read(feeRatesControllerProvider.notifier);
      expect(
        await ctrl.saveBand(
          provider: AlertSource.mtnMomo,
          feeType: FeeType.send,
          min: Money.zero,
          max: const Money.kwacha(100),
          fee: const Money.kwacha(1),
        ),
        isNull,
      );
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(c.read(feeRatesControllerProvider).value, hasLength(1));
      expect(
        await ctrl.deleteBand(
          provider: AlertSource.mtnMomo,
          feeType: FeeType.send,
          min: Money.zero,
        ),
        isNull,
      );
    });

    test('a bad band comes back as an error code', () async {
      await next(c, feeRatesControllerProvider);
      final code = await c
          .read(feeRatesControllerProvider.notifier)
          .saveBand(
            provider: AlertSource.mtnMomo,
            feeType: FeeType.send,
            min: const Money.kwacha(10),
            max: const Money.kwacha(5),
            fee: const Money.kwacha(1),
          );
      expect(code, isNotNull);
    });
  });

  test('Payday (13) carries a fee per transfer', () async {
    (await seedDemo(c)).orThrow();
    final p = (await c.read(paydayRepositoryProvider).getAll()).orThrow().first;
    final s = await next(c, paydayControllerProvider(p.id));
    expect(
      s.fees.perTransfer.keys.toSet(),
      p.transfers.map((t) => t.id).toSet(),
    );
  });
}
