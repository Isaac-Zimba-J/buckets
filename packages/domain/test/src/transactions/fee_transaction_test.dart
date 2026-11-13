import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Result<Transaction> make({
  Money amount = const Money(250),
  Category category = Category.fees,
  FeeType? type,
  FeeSource? source,
  String? parent,
}) => Transaction.create(
  id: 't',
  amount: amount,
  bucketId: 'living',
  category: category,
  accountId: 'momo',
  occurredAt: utc,
  source: TransactionSource.alert,
  feeType: type,
  feeSource: source,
  provider: AlertSource.mtnMomo,
  parentTransactionId: parent,
);

void main() {
  group('fee transactions (R-FEE-1, R-FEE-2)', () {
    test('carry type, source, provider and parent', () {
      final t = ok(
        make(type: FeeType.send, source: FeeSource.message, parent: 'p1'),
      );
      expect(t.feeType, FeeType.send);
      expect(t.feeSource, FeeSource.message);
      expect(t.provider, AlertSource.mtnMomo);
      expect(t.parentTransactionId, 'p1');
    });

    test('a missing fee is K 0, any other zero amount is refused', () {
      expect(
        ok(
          make(
            amount: Money.zero,
            type: FeeType.send,
            source: FeeSource.missing,
          ),
        ).amount,
        Money.zero,
      );
      expect(
        make(amount: Money.zero, type: FeeType.send, source: FeeSource.message),
        isErr('amount.notPositive'),
      );
      expect(make(amount: Money.zero), isErr('amount.notPositive'));
      expect(
        make(
          amount: const Money(-1),
          type: FeeType.send,
          source: FeeSource.missing,
        ),
        isErr('amount.negative'),
      );
    });

    test('fee details only belong on a Fees transaction, with a type', () {
      expect(
        make(
          category: Category.food,
          type: FeeType.send,
          source: FeeSource.message,
        ),
        isErr('fee.category'),
      );
      expect(make(source: FeeSource.message), isErr('fee.type'));
    });
  });

  group('SpendingPolicy fee helpers', () {
    final base = ok(
      make(category: Category.food, amount: const Money.kwacha(100)),
    );

    test('a payment fee links back to its payment', () {
      final fee = ok(
        SpendingPolicy.feeTransaction(base, fee: const Money(250), id: 'f'),
      );
      expect(fee.parentTransactionId, 't');
      expect(fee.feeType, FeeType.merchantPay);
      expect(fee.feeSource, FeeSource.message);
      expect(fee.category, Category.fees);
    });
  });
}
