import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Result<Transaction> tx({
  Money amount = const Money.kwacha(185),
  List<TransactionLine> lines = const [],
  DateTime? at,
}) => Transaction.create(
  id: 't',
  amount: amount,
  bucketId: 'living',
  category: Category.food,
  accountId: 'momo',
  occurredAt: at ?? utc,
  source: TransactionSource.cash,
  lines: lines,
);

void main() {
  group('Category', () {
    test('has the nine default categories in order', () {
      expect(Category.defaults.map((c) => c.name), [
        'Food',
        'Transport',
        'Airtime & data',
        'Market',
        'Family',
        'Bill',
        'Planned buy',
        'Fees',
        'Other',
      ]);
      expect(Category.untracked.name, 'Untracked');
    });

    test('custom categories need a name', () {
      expect(ok(Category.create(' Rent ')), ok(Category.create('Rent')));
      expect(Category.create(''), isErr('category.blank'));
    });
  });

  group('Transaction', () {
    test('is a positive amount at a UTC time', () {
      expect(ok(tx()).note, isNull);
      expect(tx(amount: Money.zero), isErr('amount.notPositive'));
      expect(tx(at: DateTime(2026)), isErr('occurredAt.notUtc'));
    });

    test('split lines add up to the amount', () {
      const lines = [
        TransactionLine('living', Money.kwacha(100)),
        TransactionLine('family', Money.kwacha(85)),
      ];
      expect(ok(tx(lines: lines)).lines, lines);
      expect(
        tx(lines: const [TransactionLine('living', Money.kwacha(100))]),
        isErr('lines.sumMismatch'),
      );
      expect(
        tx(
          lines: const [
            TransactionLine('living', Money.kwacha(185)),
            TransactionLine('family', Money.zero),
          ],
        ),
        isErr('line.notPositive'),
      );
    });
  });

  group('MerchantKey', () {
    test('R-SPEND-3 lower-cases and strips digits and punctuation', () {
      expect(
        ok(MerchantKey.create('SHOPRITE  #0423, Cairo Rd.')).value,
        'shoprite cairo rd',
      );
      expect(MerchantKey.create('#0423 ...'), isErr('merchantKey.empty'));
    });

    test('rules carry the key, category and bucket', () {
      final key = ok(MerchantKey.create('Zesco'));
      final rule = MerchantRule(
        id: 'r',
        merchantKey: key,
        category: Category.bill,
        bucketId: 'living',
      );
      expect(rule.merchantKey, key);
      expect(
        rule,
        MerchantRule(
          id: 'r',
          merchantKey: key,
          category: Category.bill,
          bucketId: 'living',
        ),
      );
    });
  });
}
