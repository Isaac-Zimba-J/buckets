import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/value_objects/ledger_refs.dart';
import 'package:buckets_domain/src/shared/validation.dart';
import 'package:buckets_domain/src/transactions/entities/cash_withdrawal.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// Turns spending into ledger entries (DOMAIN §10).
abstract final class SpendingPolicy {
  /// One `spend` entry per bucket the transaction draws on (R-SPEND-1),
  /// tagged with the transaction, alert, receipt and bill.
  static Result<List<LedgerEntry>> spendEntries(
    Transaction transaction, {
    required IdGenerator ids,
  }) {
    final perBucket = <String, Money>{};
    final lines = transaction.lines.isEmpty
        ? [(transaction.bucketId, transaction.amount)]
        : [for (final l in transaction.lines) (l.bucketId, l.amount)];
    for (final (bucketId, amount) in lines) {
      perBucket.update(bucketId, (m) => m + amount, ifAbsent: () => amount);
    }
    final refs = LedgerRefs(
      transactionId: transaction.id,
      alertId: transaction.alertId,
      receiptId: transaction.receiptId,
      billId: transaction.billId,
    );
    return collect([
      for (final MapEntry(key: bucketId, value: amount) in perBucket.entries)
        LedgerEntry.create(
          id: ids.newId(),
          occurredAt: transaction.occurredAt,
          kind: LedgerEntryKind.spend,
          bucketId: bucketId,
          amount: -amount,
          refs: refs,
          note: transaction.note,
        ),
    ]);
  }

  /// The mobile money [fee] on [base] as its own transaction in Fees, from
  /// the same bucket and account (R-SPEND-2).
  static Result<Transaction> feeTransaction(
    Transaction base, {
    required Money fee,
    required String id,
  }) => Transaction.create(
    id: id,
    amount: fee,
    bucketId: base.bucketId,
    category: Category.fees,
    accountId: base.accountId,
    occurredAt: base.occurredAt,
    source: base.source,
    alertId: base.alertId,
  );

  /// A withdrawal [alert] as cash moved into Cash in hand, plus its fee as
  /// spending from [feeBucketId] (R-SPEND-4).
  static Result<(CashWithdrawal, Transaction?)> withdrawal(
    PaymentAlert alert, {
    required IdGenerator ids,
    required String fromAccountId,
    required String cashAccountId,
    required String feeBucketId,
  }) {
    final p = alert.parsed;
    if (!p.isWithdrawal) {
      return const Err(
        ValidationFailure('alert.notWithdrawal', 'This is not a withdrawal.'),
      );
    }
    final amount = p.amount;
    if (amount == null) {
      return const Err(
        ValidationFailure('amount.missing', 'Enter the amount withdrawn.'),
      );
    }
    final at = p.occurredAt ?? alert.receivedAt;
    final withdrawal = CashWithdrawal.create(
      id: ids.newId(),
      amount: amount,
      fromAccountId: fromAccountId,
      cashAccountId: cashAccountId,
      occurredAt: at,
      alertId: alert.id,
    );
    if (withdrawal case Err(:final failure)) return Err(failure);
    final w = (withdrawal as Ok<CashWithdrawal>).value;
    final fee = p.fee;
    if (fee == null || !fee.isPositive) return Ok((w, null));
    return switch (Transaction.create(
      id: ids.newId(),
      amount: fee,
      bucketId: feeBucketId,
      category: Category.fees,
      accountId: fromAccountId,
      occurredAt: at,
      source: TransactionSource.alert,
      alertId: alert.id,
    )) {
      Ok(:final value) => Ok((w, value)),
      Err(:final failure) => Err(failure),
    };
  }

  /// Whether spending warnings, notifications and overspend prompts are
  /// suppressed: always for Guilt-free unless it is below K 0 (R-SPEND-5).
  static bool isWarningSuppressed(BucketKind kind, Money balanceAfter) =>
      kind == BucketKind.guiltFree && !balanceAfter.isNegative;
}
