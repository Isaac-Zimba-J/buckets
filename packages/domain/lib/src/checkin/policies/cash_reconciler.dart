import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/checkin/entities/check_in.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/value_objects/ledger_refs.dart';
import 'package:buckets_domain/src/transactions/entities/cash_withdrawal.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

const _notPositive = ValidationFailure(
  'gap.notPositive',
  'There is no difference to record.',
);

/// Cash in hand between counts (DOMAIN §15). Each count resets the
/// baseline, so Cash in hand needs no running balance of its own.
abstract final class CashReconciler {
  /// Last counted cash + withdrawals since − cash spends since (R-CASH-1).
  /// Before the first count it starts from K 0. Anything at or before the
  /// last count's time is already in that count.
  static Money expectedCash({
    required CheckIn? lastCheckIn,
    required String cashAccountId,
    required Iterable<CashWithdrawal> withdrawals,
    required Iterable<Transaction> transactions,
  }) {
    final since = lastCheckIn?.countedAt;
    bool isNew(DateTime at) => since == null || at.isAfter(since);
    var cash = lastCheckIn?.countedCash ?? Money.zero;
    for (final w in withdrawals) {
      if (w.cashAccountId == cashAccountId && isNew(w.occurredAt)) {
        cash += w.amount;
      }
    }
    for (final t in transactions) {
      if (t.accountId == cashAccountId && isNew(t.occurredAt)) cash -= t.amount;
    }
    return cash;
  }

  /// Missing cash ([gap] > 0) as one Untracked transaction from Living, with
  /// its `adjustment` ledger entry (R-CASH-2).
  static Result<(Transaction, LedgerEntry)> recordUntracked({
    required Money gap,
    required String livingBucketId,
    required String cashAccountId,
    required IdGenerator ids,
    required DateTime at,
  }) {
    if (!gap.isPositive) return const Err(_notPositive);
    final tx = Transaction.create(
      id: ids.newId(),
      amount: gap,
      bucketId: livingBucketId,
      category: Category.untracked,
      accountId: cashAccountId,
      occurredAt: at,
      source: TransactionSource.cash,
    );
    if (tx case Err(:final failure)) return Err(failure);
    final transaction = (tx as Ok<Transaction>).value;
    return switch (LedgerEntry.create(
      id: ids.newId(),
      occurredAt: at,
      kind: LedgerEntryKind.adjustment,
      bucketId: livingBucketId,
      amount: -gap,
      refs: LedgerRefs(transactionId: transaction.id),
    )) {
      Ok(:final value) => Ok((transaction, value)),
      Err(:final failure) => Err(failure),
    };
  }

  /// Extra cash ([extra] > 0, a negative gap) that the user says they
  /// received (R-CASH-3): an `adjustment` into [intoLivingBucketId], or
  /// nothing when they keep it as Cash in hand (null).
  static Result<LedgerEntry?> recordReceived({
    required Money extra,
    required String? intoLivingBucketId,
    required IdGenerator ids,
    required DateTime at,
  }) {
    if (!extra.isPositive) return const Err(_notPositive);
    if (intoLivingBucketId == null) return const Ok(null);
    return switch (LedgerEntry.create(
      id: ids.newId(),
      occurredAt: at,
      kind: LedgerEntryKind.adjustment,
      bucketId: intoLivingBucketId,
      amount: extra,
    )) {
      Ok(:final value) => Ok(value),
      Err(:final failure) => Err(failure),
    };
  }
}
