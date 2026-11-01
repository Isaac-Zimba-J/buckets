import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../helpers.dart';

/// Each builder returns a fresh instance; `id` changes one field.
final builders = <String, Object Function(String id)>{
  'Account': (id) => ok(
    Account.create(
      id: id,
      name: 'Zanaco',
      kind: AccountKind.bank,
      matchKeys: [ok(MatchKey.create('4521'))],
    ),
  ),
  'Bucket': (id) => ok(
    Bucket.create(
      id: id,
      name: 'Laptop',
      kind: BucketKind.goal,
      color: BucketColor.goal,
      accountId: 'a',
    ),
  ),
  'IncomeSource': (id) => ok(
    IncomeSource.create(
      id: id,
      name: 'Salary',
      kind: IncomeKind.salary,
      schedule: const MonthlyPay(25),
      landsInAccountId: 'a',
      splitProfileId: 'p',
    ),
  ),
  'IrregularPay': (id) =>
      id == 'x' ? const IrregularPay() : const MonthlyPay(1),
  'SplitProfile': (id) => ok(
    SplitProfile.create(
      id: id,
      allocations: [Allocation('living', BasisPoints.full)],
    ),
  ),
  'Bill': (id) => ok(
    Bill.create(
      id: id,
      name: 'Rent',
      amount: const Money.kwacha(2500),
      frequency: BillFrequency.monthly,
      dueDay: 1,
      paidFromBucketId: 'living',
    ),
  ),
  'LedgerEntry': (id) => ok(
    LedgerEntry.create(
      id: id,
      occurredAt: utc,
      kind: LedgerEntryKind.allocation,
      bucketId: 'living',
      amount: const Money.kwacha(3080),
    ),
  ),
  'Payday': (id) => ok(
    Payday.create(
      id: id,
      incomeSourceId: 's',
      amount: const Money.kwacha(12000),
      startedAt: utc,
      transfers: [
        ok(
          Transfer.create(
            id: 't',
            bucketId: 'e',
            toAccountId: 'save',
            amount: const Money.kwacha(770),
          ),
        ),
      ],
    ),
  ),
  'PaymentAlert': (id) => ok(
    PaymentAlert.create(
      id: id,
      rawText: '[MESSAGE]',
      source: AlertSource.airtelMoney,
      receivedAt: utc,
      parsed: ParsedMessage(
        confidence: 0.9,
        direction: MessageDirection.incoming,
        reference: 'ZX98',
      ),
    ),
  ),
  'ProofResult': (id) => ProofResult(
    amount: const CheckPassed(),
    account: CheckFailed(id),
    date: const CheckUnknown(),
    reference: const CheckPassed(),
  ),
  'Transaction': (id) => ok(
    Transaction.create(
      id: id,
      amount: const Money.kwacha(185),
      bucketId: 'living',
      category: Category.food,
      accountId: 'momo',
      occurredAt: utc,
      source: TransactionSource.alert,
      lines: const [TransactionLine('living', Money.kwacha(185))],
    ),
  ),
  'MerchantKey': (id) => ok(MerchantKey.create('shop $id')),
  'Goal': (id) => ok(Goal.create(bucketId: id, target: const Money(1))),
  'PlannedPurchase': (id) => ok(
    PlannedPurchase.create(
      id: id,
      name: 'Gas',
      amount: const Money.kwacha(350),
      bucketId: 'living',
    ),
  ),
  'Wish': (id) => ok(
    Wish.create(
      id: id,
      name: 'Speaker',
      amount: const Money.kwacha(1200),
      bucketId: 'fun',
      createdAt: utc,
      endsAt: utc.add(const Duration(hours: 48)),
    ),
  ),
  'CheckIn': (id) => ok(
    CheckIn.create(
      id: id,
      countedAt: utc,
      expectedCash: Money.zero,
      countedCash: Money.zero,
    ),
  ),
  'ScheduledNotification': (id) => ScheduledNotification(
    id: id,
    kind: NotificationKind.payday,
    at: utc,
    deepLink: 'buckets://payday/p',
  ),
  'IncomingAlertText': (id) =>
      IncomingAlertText(packageName: id, text: '[MESSAGE]', receivedAt: utc),
  'BucketShare': (id) => BucketShare(id, const Money(1)),
  'BillReservation': (id) =>
      BillReservation(billId: id, bucketId: 'living', amount: const Money(1)),
  'StartedPayday': (id) => StartedPayday(
    ok(
      Payday.create(
        id: id,
        incomeSourceId: 's',
        amount: const Money(1),
        startedAt: utc,
        transfers: const [],
      ),
    ),
    const [],
  ),
  'DateWindow': (id) => ok(
    DateWindow.create(utc, utc.add(Duration(days: id.length))),
  ),
};

void main() {
  for (final MapEntry(key: name, value: build) in builders.entries) {
    test('$name has value equality', () {
      expect(build('x'), build('x'));
      expect(build('x').hashCode, build('x').hashCode);
      expect(build('x'), isNot(build('yy')));
    });
  }
}
