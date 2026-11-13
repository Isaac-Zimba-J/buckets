import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/demo_seed.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets/features/home/presentation/controllers/bucket_detail_controller.dart';
import 'package:buckets/features/home/presentation/controllers/goals_controller.dart';
import 'package:buckets/features/home/presentation/controllers/home_controller.dart';
import 'package:buckets/features/logging/presentation/controllers/log_payment_controller.dart';
import 'package:buckets/features/payday/presentation/controllers/income_received_controller.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_controller.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_done_controller.dart';
import 'package:buckets/features/payday/presentation/controllers/proof_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/bills_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/bucket_accounts_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/income_setup_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/permissions_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/split_controller.dart';
import 'package:buckets/features/setup/presentation/controllers/welcome_controller.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_test/flutter_test.dart';

import 'flow_harness.dart';

/// Screens 01–06 on controllers: accounts, a Laptop goal, salary, the
/// canvas bills, the default split, buckets placed, setup completed.
Future<String> runSetup(Flow f) async {
  final c = f.c;
  expect(await f.next(welcomeControllerProvider), isFalse);
  (await c.read(firstRunSeedProvider)()).orThrow();
  await f.next(bucketAccountsControllerProvider);
  final accounts = c.read(bucketAccountsControllerProvider.notifier);
  expect(
    await accounts.saveAccount(
      id: 'momo',
      name: '[MOMO]',
      kind: AccountKind.mtnMomo,
      isSpending: true,
    ),
    isTrue,
  );
  expect(
    await accounts.saveAccount(
      id: 'savings',
      name: '[BANK]',
      kind: AccountKind.bank,
      matchKeys: ['4521'],
    ),
    isTrue,
  );
  // A goal made before the income is in its default split (R-SPLIT-4).
  await f.next(goalsControllerProvider);
  expect(
    await c
        .read(goalsControllerProvider.notifier)
        .create(
          name: 'Laptop',
          target: const Money.kwacha(9000),
          accountId: 'savings',
        ),
    isTrue,
  );
  await f.next(incomeSetupControllerProvider);
  expect(
    await c
        .read(incomeSetupControllerProvider.notifier)
        .save(
          name: 'Salary',
          kind: IncomeKind.salary,
          landsInAccountId: 'momo',
          expected: const Money.kwacha(12000),
          paydayOfMonth: 25,
        ),
    isTrue,
  );
  final salary = c.read(incomeSetupControllerProvider).value!.incomes.single;
  await f.next(billsControllerProvider);
  for (final (name, kwacha) in const [
    ('Rent', 2500),
    ('ZESCO', 400),
    ('Water', 600),
    ('Transport', 800),
  ]) {
    expect(
      await c
          .read(billsControllerProvider.notifier)
          .save(
            name: name,
            amount: Money.kwacha(kwacha),
            frequency: BillFrequency.monthly,
            dueDay: 1,
          ),
      isTrue,
    );
  }
  final split = splitControllerProvider(salary.id);
  expect((await f.next(split)).amountToSplit, const Money.kwacha(7700));
  expect(await c.read(split.notifier).save(), isTrue);
  final spending = {
    f.bucket(BucketKind.living),
    f.bucket(BucketKind.guiltFree),
  };
  c.invalidate(bucketAccountsControllerProvider);
  for (final b in (await f.next(bucketAccountsControllerProvider)).buckets) {
    final account = spending.contains(b.bucketId) ? 'momo' : 'savings';
    expect(await accounts.assign(b.bucketId, account), isTrue);
  }
  expect(
    c.read(bucketAccountsControllerProvider).value!.someUnassigned,
    isFalse,
  );
  await f.next(permissionsControllerProvider);
  expect(
    await c.read(permissionsControllerProvider.notifier).complete(),
    isTrue,
  );
  c.invalidate(welcomeControllerProvider);
  expect(await f.next(welcomeControllerProvider), isTrue);
  return salary.id;
}

void main() {
  late Flow f;
  setUp(() => f = Flow());
  tearDown(() => f.dispose());

  test('1 setup → first payday → prove 3, fail 1 then partial → '
      'complete', () async {
    final c = f.c;
    await runSetup(f);
    expect(await f.next(homeControllerProvider), isA<HomeFirstRun>());

    // The salary alert arrives; "Salary landed" starts the payday.
    final alert = (await f.ingest(
      'TEST RECEIVED K12,000.00 FROM [EMPLOYER] REF SAL1',
    )).single;
    final received = incomeReceivedControllerProvider(alert.id);
    final ready = await f.next(received) as IncomeReady;
    expect(ready.suggestion, IncomeSuggestion.salaryLanded);
    expect(await c.read(received.notifier).salaryLanded(), isTrue);
    final paydayId = (c.read(received).value! as IncomeSplit).paydayId;

    final payday = paydayControllerProvider(paydayId);
    var state = await f.next(payday);
    expect(state.transfers, hasLength(4));
    expect(state.left, const Money.kwacha(3850));
    final home = await f.next(homeControllerProvider) as HomeActive;
    expect(home.banner?.pending, 4);

    // Three proofs pass.
    final [first, second, third, last] = state.transfers;
    for (final (i, t) in [first, second, third].indexed) {
      final proof = proofControllerProvider(paydayId, t.id);
      c.listen(proof, (_, _) {});
      await c.read(proof.notifier).check(sentToSavings(t.amount, 'OK$i'));
      expect(c.read(proof), isA<ProofPassed>(), reason: t.bucketName);
    }
    await f.settle();
    state = c.read(payday).value!;
    expect(state.done, 3);
    expect(state.complete, isFalse);

    // The fourth is K 20 short: save what arrived, then prove the rest.
    final proof = proofControllerProvider(paydayId, last.id);
    c.listen(proof, (_, _) {});
    final short = last.amount - const Money.kwacha(20);
    await c.read(proof.notifier).check(sentToSavings(short, 'LOW1'));
    final failed = c.read(proof) as ProofFailed;
    expect(failed.canSavePartial, isTrue);
    expect(failed.owed, const Money.kwacha(20));
    expect(await c.read(proof.notifier).savePartial(), isTrue);
    await f.settle();
    state = c.read(payday).value!;
    expect(state.transfers.last.owed, const Money.kwacha(20));
    expect(state.complete, isFalse);

    c
      ..invalidate(proof)
      ..listen(proof, (_, _) {});
    await c
        .read(proof.notifier)
        .check(sentToSavings(const Money.kwacha(20), 'REST1'));
    expect(c.read(proof), isA<ProofPassed>());
    await f.settle();
    state = c.read(payday).value!;
    expect(state.complete, isTrue);
    expect(state.left, Money.zero);

    final done = await f.next(paydayDoneControllerProvider(paydayId));
    expect(done.livingLeft, const Money.kwacha(3080));
    expect(done.guiltFreeLeft, const Money.kwacha(770));
    final unlocked = await f.next(homeControllerProvider) as HomeActive;
    expect(unlocked.unlocked, isTrue);
    expect(unlocked.banner, isNull);
  });

  test('3 Living overspent → cover from Guilt-free', () async {
    final c = f.c;
    (await seedDemo(c)).orThrow();
    final living = f.bucket(BucketKind.living);
    final detail = bucketDetailControllerProvider(living);
    expect(await f.next(detail), isA<BucketNormal>());

    // Log K 3,390 of cash from Living (holds K 3,080): K 310 over.
    final log = logPaymentControllerProvider;
    c.listen(log, (_, _) {});
    expect(
      await c
          .read(log.notifier)
          .save(
            category: Category.food,
            bucketId: living,
            amount: const Money.kwacha(3390),
          ),
      isTrue,
    );
    await f.settle();
    final over = c.read(detail).value! as BucketOverspent;
    expect(over.overspentBy, const Money.kwacha(310));
    final fromGuiltFree = over.options.first;
    expect(fromGuiltFree.fromName, 'Guilt-free');

    expect(await c.read(detail.notifier).cover(fromGuiltFree), isTrue);
    await f.settle();
    expect(c.read(detail).value, isA<BucketNormal>());
    final home = await f.next(homeControllerProvider) as HomeActive;
    expect(home.guiltFreeLeft, const Money.kwacha(460));
  });

  test('5 side hustle: hold twice, released as one payday at month '
      'end', () async {
    final c = f.c;
    (await seedDemo(c)).orThrow();
    await f.next(incomeSetupControllerProvider);
    expect(
      await c
          .read(incomeSetupControllerProvider.notifier)
          .save(
            name: 'Tutoring',
            kind: IncomeKind.sideHustle,
            landsInAccountId: 'momo',
          ),
      isTrue,
    );
    final hustle = c
        .read(incomeSetupControllerProvider)
        .value!
        .incomes
        .firstWhere((i) => i.kind == IncomeKind.sideHustle)
        .id;

    for (final (kwacha, ref) in const [(2000, 'H1'), (1500, 'H2')]) {
      final alert = (await f.ingest(
        'TEST RECEIVED K$kwacha.00 FROM [CUSTOMER] REF $ref',
      )).single;
      final received = incomeReceivedControllerProvider(alert.id);
      final ready = await f.next(received) as IncomeReady;
      expect(ready.suggestion, IncomeSuggestion.sideHustle);
      expect(await c.read(received.notifier).hold(hustle), isTrue);
      final holding = c.read(received).value! as IncomeHolding;
      expect(holding.releaseAt, DateTime.utc(2026, 10, 31, 16));
    }

    final payday = (await c.read(releaseHeldIncomeProvider)(hustle)).orThrow()!;
    expect(payday.amount, const Money.kwacha(3500));
    expect((await c.read(releaseHeldIncomeProvider)(hustle)).orThrow(), isNull);
  });
}
