import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

import '../fakes/fakes.dart';
import '../fakes/fakes_activity.dart';
import '../helpers.dart';

/// Repositories seeded like first run: default buckets, MoMo spending
/// account, savings account, cash in hand.
class World {
  new() {
    accounts.store.items
      ..['momo'] = ok(
        Account.create(
          id: 'momo',
          name: 'MoMo',
          kind: AccountKind.mtnMomo,
          isSpending: true,
        ),
      )
      ..['savings'] = ok(
        Account.create(id: 'savings', name: 'Savings', kind: AccountKind.bank),
      )
      ..['cash'] = const Account.cashInHand(id: 'cash');
    for (final b in Bucket.defaults(
      ids: SequentialIds(),
      spendingAccountId: 'momo',
      savingsAccountId: 'savings',
    )) {
      buckets.store.items[b.id] = b;
    }
  }

  final accounts = InMemoryAccountRepository();
  final buckets = InMemoryBucketRepository();
  final incomes = InMemoryIncomeRepository();
  final profiles = InMemorySplitProfileRepository();
  final bills = InMemoryBillRepository();
  final ledger = InMemoryLedgerRepository();
  final settings = InMemorySettingsRepository();
  final permissions = FakePermissionGateway();
  final clock = FakeClock(DateTime.utc(2026, 10, 25, 6));
  final zone = LusakaTimeZone();
  final ids = _Ids();
  final paydays = InMemoryPaydayRepository();
  final alerts = InMemoryAlertRepository();
  final goals = InMemoryGoalRepository();
  final held = InMemoryHeldIncomeRepository();
  final transactions = InMemoryTransactionRepository();

  String bucketOf(BucketKind kind) =>
      buckets.store.items.values.firstWhere((b) => b.kind == kind).id;
}

class _Ids implements IdGenerator {
  var _n = 0;

  @override
  String newId() => 'new-${++_n}';
}
