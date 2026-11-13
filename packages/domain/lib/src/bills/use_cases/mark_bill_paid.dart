import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/bills/entities/bill.dart';
import 'package:buckets_domain/src/bills/entities/bill_occurrence.dart';
import 'package:buckets_domain/src/bills/policies/bill_occurrences.dart';
import 'package:buckets_domain/src/bills/ports/bill_occurrence_repository.dart';
import 'package:buckets_domain/src/bills/ports/bill_repository.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/policies/fee_policy.dart';
import 'package:buckets_domain/src/fees/ports/fee_tariff_repository.dart';
import 'package:buckets_domain/src/fees/ports/pending_fee_changes.dart';
import 'package:buckets_domain/src/fees/use_cases/learn_fee.dart';
import 'package:buckets_domain/src/fees/value_objects/fee_learning.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/use_cases/spend_writer.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// Ticks a bill as paid (R-BILL-7, SCREENS 34): books the spend from the
/// bill's bucket, records the fee as its own Fees transaction charged to
/// Living (R-FEE-6), and marks the occurrence paid.
final class MarkBillPaid {
  /// Creates the use case.
  const new(
    this._occurrences,
    this._bills,
    this._buckets,
    this._accounts,
    this._tariffs,
    this._spend,
    this._clock,
    this._ids, [
    this._pending,
  ]);

  final BillOccurrenceRepository _occurrences;
  final BillRepository _bills;
  final BucketRepository _buckets;
  final AccountRepository _accounts;
  final FeeTariffRepository _tariffs;
  final SpendWriter _spend;
  final Clock _clock;
  final IdGenerator _ids;
  final PendingFeeChanges? _pending;

  /// Marks [occurrenceId] paid with [amount] from [accountId]. [fee] is the
  /// fee read from a pasted message, if any; otherwise it is estimated from
  /// the rates, or recorded as `missing` (R-FEE-2). [proofRef] is the pasted
  /// message's reference.
  Future<Result<BillOccurrence>> call({
    required String occurrenceId,
    required Money amount,
    required String accountId,
    Money? fee,
    String? proofRef,
  }) => attempt(() async {
    final occurrence = unwrap(await _occurrences.getAll())
        .where((o) => o.id == occurrenceId)
        .firstOrNull;
    if (occurrence == null) {
      unwrap<void>(
        const Err(NotFoundFailure('bill.notFound', 'That bill is gone.')),
      );
    }
    if (occurrence!.status != BillStatus.due) {
      unwrap<void>(
        const Err(
          ValidationFailure('bill.notDue', 'This bill is already settled.'),
        ),
      );
    }
    final bill = unwrap(await _bills.getAll())
        .where((b) => b.id == occurrence.billId)
        .firstOrNull;
    if (bill == null) {
      unwrap<void>(
        const Err(NotFoundFailure('bill.notFound', 'That bill is gone.')),
      );
    }
    final account = unwrap(await _accounts.getAll())
        .where((a) => a.id == accountId)
        .firstOrNull;
    if (account == null) {
      unwrap<void>(
        const Err(NotFoundFailure('account.notFound', 'That account is gone.')),
      );
    }
    final now = _clock.now();
    final source = proofRef == null
        ? TransactionSource.cash
        : TransactionSource.pasted;
    final payment = unwrap(
      Transaction.create(
        id: _ids.newId(),
        amount: amount,
        bucketId: bill!.paidFromBucketId,
        category: Category.bill,
        accountId: accountId,
        occurredAt: now,
        source: source,
        billId: bill.id,
      ),
    );

    // Only mobile-money accounts charge these fees.
    final provider = FeePolicy.providerOf(account!.kind);
    Transaction? feeTx;
    if (provider != null) {
      final estimated = fee != null
          ? null
          : FeePolicy.estimate(
              unwrap(await _tariffs.find(provider, FeeType.billPay)),
              amount,
            );
      final (feeAmount, feeSource) = FeePolicy.resolve(
        fromMessage: fee,
        estimated: estimated,
      );
      final living = unwrap(await _buckets.getAll())
          .where((b) => b.kind == BucketKind.living)
          .firstOrNull;
      feeTx = unwrap(
        Transaction.create(
          id: _ids.newId(),
          amount: feeAmount,
          bucketId: living?.id ?? bill.paidFromBucketId,
          category: Category.fees,
          accountId: accountId,
          occurredAt: now,
          source: source,
          feeType: FeeType.billPay,
          feeSource: feeSource,
          provider: provider,
          parentTransactionId: payment.id,
        ),
      );
    }
    unwrap(await _spend.writeAll([payment, ?feeTx]));
    // A fee read from the user's own message teaches the rates (R-FEE-3/4).
    if (provider != null && fee != null) {
      final change = unwrap(
        await LearnFee(_tariffs)(
          provider: provider,
          feeType: FeeType.billPay,
          amount: amount,
          fee: fee,
        ),
      );
      if (change != null) {
        await _pending?.add(
          PendingFeeChange(provider, FeeType.billPay, change),
        );
      }
    }

    final paid = unwrap(
      BillOccurrence.create(
        id: occurrence.id,
        billId: occurrence.billId,
        cycleStart: occurrence.cycleStart,
        dueDate: occurrence.dueDate,
        expectedAmount: occurrence.expectedAmount,
        status: BillStatus.paid,
        paidAmount: amount,
        paidAt: now,
        accountId: accountId,
        feeTransactionId: feeTx?.id,
        proofRef: proofRef,
      ),
    );
    unwrap(await _occurrences.save(paid));
    await _advanceDueDate(bill);
    return paid;
  });

  // A paid termly/yearly bill is next due a period later; without this its
  // next occurrence would never appear.
  Future<void> _advanceDueDate(Bill bill) async {
    final next = BillOccurrences.advanceDue(bill);
    if (next == null) return;
    final moved = Bill.create(
      id: bill.id,
      name: bill.name,
      amount: bill.amount,
      frequency: bill.frequency,
      paidFromBucketId: bill.paidFromBucketId,
      dueDay: bill.dueDay,
      nextDueDate: next,
      payeeAccountHint: bill.payeeAccountHint,
    );
    if (moved case Ok(:final value)) await _bills.save(value);
  }
}
