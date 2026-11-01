import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:test/test.dart';

import '../../helpers.dart';

Transaction tx({
  List<TransactionLine> lines = const [],
  Money amount = const Money.kwacha(185),
  String? billId,
}) => ok(
  Transaction.create(
    id: 'tx',
    amount: amount,
    bucketId: 'living',
    category: Category.market,
    accountId: 'momo',
    occurredAt: utc,
    source: TransactionSource.receipt,
    alertId: 'al',
    receiptId: 'rc',
    lines: lines,
    billId: billId,
  ),
);

PaymentAlert alert(ParsedMessage parsed) => ok(
  PaymentAlert.create(
    id: 'al',
    rawText: null,
    source: AlertSource.mtnMomo,
    receivedAt: utc,
    parsed: parsed,
  ),
);

void main() {
  group('R-SPEND-1 spend entries', () {
    test('one negative spend entry for a single-bucket transaction', () {
      final entries = ok(
        SpendingPolicy.spendEntries(tx(), ids: SequentialIds()),
      );
      final e = entries.single;
      expect(e.kind, LedgerEntryKind.spend);
      expect(e.bucketId, 'living');
      expect(e.amount, const Money.kwacha(-185));
      expect(e.occurredAt, utc);
      expect(
        e.refs,
        const LedgerRefs(transactionId: 'tx', alertId: 'al', receiptId: 'rc'),
      );
    });

    test('one entry per bucket when a receipt is split', () {
      final split = tx(
        amount: const Money.kwacha(300),
        lines: const [
          TransactionLine('living', Money.kwacha(100)),
          TransactionLine('family', Money.kwacha(150)),
          TransactionLine('living', Money.kwacha(50)),
        ],
      );
      final entries = ok(
        SpendingPolicy.spendEntries(split, ids: SequentialIds()),
      );
      expect(
        {for (final e in entries) e.bucketId: e.amount},
        {
          'living': const Money.kwacha(-150),
          'family': const Money.kwacha(-150),
        },
      );
    });

    test('a bill payment is tagged with the bill (R-BILL-2a)', () {
      final entries = ok(
        SpendingPolicy.spendEntries(tx(billId: 'rent'), ids: SequentialIds()),
      );
      expect(entries.single.refs.billId, 'rent');
    });
  });

  test('R-SPEND-2 a fee is its own transaction in Fees, same bucket', () {
    final fee = ok(
      SpendingPolicy.feeTransaction(tx(), fee: const Money(250), id: 'fee'),
    );
    expect(fee.id, 'fee');
    expect(fee.amount, const Money(250));
    expect(fee.category, Category.fees);
    expect(fee.bucketId, 'living');
    expect(fee.accountId, 'momo');
    expect(fee.occurredAt, utc);
    expect(fee.alertId, 'al');
    expect(fee.lines, isEmpty);
    expect(fee.billId, isNull);
    expect(
      SpendingPolicy.feeTransaction(tx(), fee: Money.zero, id: 'fee'),
      isErr('amount.notPositive'),
    );
  });

  group('R-SPEND-4 withdrawals', () {
    final parsed = ParsedMessage(
      confidence: 1,
      direction: MessageDirection.outgoing,
      amount: const Money.kwacha(500),
      fee: const Money.kwacha(5),
      occurredAt: DateTime.utc(2026, 10, 30, 6),
      isWithdrawal: true,
    );

    test('moves cash into Cash in hand and only the fee is spending', () {
      final (w, fee) = ok(
        SpendingPolicy.withdrawal(
          alert(parsed),
          ids: SequentialIds(),
          fromAccountId: 'momo',
          cashAccountId: 'cash',
          feeBucketId: 'living',
        ),
      );
      expect(w.amount, const Money.kwacha(500));
      expect(w.fromAccountId, 'momo');
      expect(w.cashAccountId, 'cash');
      expect(w.occurredAt, DateTime.utc(2026, 10, 30, 6));
      expect(w.alertId, 'al');
      expect(fee!.category, Category.fees);
      expect(fee.amount, const Money.kwacha(5));
      expect(fee.bucketId, 'living');
      expect(fee.accountId, 'momo');
    });

    test('no fee transaction without a fee; receivedAt when no date', () {
      final (w, fee) = ok(
        SpendingPolicy.withdrawal(
          alert(
            ParsedMessage(
              confidence: 1,
              amount: const Money.kwacha(100),
              isWithdrawal: true,
            ),
          ),
          ids: SequentialIds(),
          fromAccountId: 'momo',
          cashAccountId: 'cash',
          feeBucketId: 'living',
        ),
      );
      expect(fee, isNull);
      expect(w.occurredAt, utc);
    });

    test('only withdrawal alerts with an amount', () {
      Result<Object?> run(ParsedMessage p) => SpendingPolicy.withdrawal(
        alert(p),
        ids: SequentialIds(),
        fromAccountId: 'momo',
        cashAccountId: 'cash',
        feeBucketId: 'living',
      );
      expect(
        run(ParsedMessage(confidence: 1, amount: const Money(1))),
        isErr('alert.notWithdrawal'),
      );
      expect(
        run(ParsedMessage(confidence: 1, isWithdrawal: true)),
        isErr('amount.missing'),
      );
    });
  });

  test('R-SPEND-5 Guilt-free stays quiet unless it goes below K 0', () {
    expect(
      SpendingPolicy.isWarningSuppressed(BucketKind.guiltFree, Money.zero),
      isTrue,
    );
    expect(
      SpendingPolicy.isWarningSuppressed(BucketKind.guiltFree, const Money(-1)),
      isFalse,
    );
    expect(
      SpendingPolicy.isWarningSuppressed(BucketKind.living, const Money(500)),
      isFalse,
    );
  });
}
