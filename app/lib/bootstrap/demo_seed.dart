import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/bootstrap/setup_use_cases.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class _Stop implements Exception {
  const new(this.failure);

  final Failure failure;
}

T _ok<T>(Result<T> r) => switch (r) {
  Ok(:final value) => value,
  Err(:final failure) => throw _Stop(failure),
};

/// Fills a fake-backed container with the design canvas example: salary
/// K 12,000 on the 25th, bills K 4,300, the default buckets plus a Laptop
/// goal, and a started payday (Living K 3,080, 4 transfers K 3,850).
Future<Result<void>> seedDemo(ProviderContainer c) async {
  try {
    _ok(await c.read(firstRunSeedProvider)());
    for (final (id, name, kind, spending) in const [
      ('momo', '[MOMO ACCOUNT]', AccountKind.mtnMomo, true),
      ('savings', '[SAVINGS ACCOUNT]', AccountKind.bank, false),
    ]) {
      _ok(
        await c.read(saveAccountProvider)(
          id: id,
          name: name,
          kind: kind,
          isSpending: spending,
          matchKeys: const ['4521'],
        ),
      );
    }
    final buckets = c.read(bucketRepositoryProvider);
    const spendingKinds = {BucketKind.living, BucketKind.guiltFree};
    _ok(
      await buckets.saveAll([
        for (final b in _ok(await buckets.getAll()))
          b.withAccount(spendingKinds.contains(b.kind) ? 'momo' : 'savings'),
      ]),
    );
    _ok(
      await c.read(createGoalProvider)(
        name: 'Laptop',
        target: const Money.kwacha(9000),
        accountId: 'savings',
      ),
    );
    final salary = _ok(
      await c.read(saveIncomeSourceProvider)(
        name: 'Salary',
        kind: IncomeKind.salary,
        landsInAccountId: 'momo',
        expectedAmount: const Money.kwacha(12000),
        schedule: const MonthlyPay(25),
      ),
    );
    for (final (name, kwacha) in const [
      ('Rent', 2500),
      ('ZESCO', 400),
      ('Water', 600),
      ('Transport', 800),
    ]) {
      _ok(
        await c.read(saveBillProvider)(
          name: name,
          amount: Money.kwacha(kwacha),
          frequency: BillFrequency.monthly,
          dueDay: 1,
        ),
      );
    }
    _ok(
      await c.read(startPaydayProvider)(
        incomeSourceId: salary.id,
        amount: const Money.kwacha(12000),
      ),
    );
    return const Ok(null);
  } on _Stop catch (e) {
    return Err(e.failure);
  }
}
