import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';

import '../helpers.dart';
import 'world.dart';

export 'world.dart';

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
    paydays,
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
