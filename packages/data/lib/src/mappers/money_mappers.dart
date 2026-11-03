import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_data/src/db/buckets_database.dart';
import 'package:buckets_data/src/mappers/results.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:drift/drift.dart';

/// Row ⇄ entity for the ledger, paydays, goals and check-ins.
abstract final class MoneyMappers {
  /// A ledger entry from its row.
  static Result<LedgerEntry> ledgerEntry(LedgerEntryRow row) =>
      LedgerEntry.create(
        id: row.id,
        occurredAt: row.occurredAt,
        kind: row.kind,
        bucketId: row.bucketId,
        amount: Money(row.amount),
        counterBucketId: row.counterBucketId,
        refs: LedgerRefs(
          paydayId: row.paydayId,
          transferId: row.transferId,
          alertId: row.alertId,
          transactionId: row.transactionId,
          receiptId: row.receiptId,
          billId: row.billId,
          carryOverId: row.carryOverId,
        ),
        note: row.note,
        reversesEntryId: row.reversesEntryId,
      );

  /// The row for [entry].
  static LedgerEntriesCompanion ledgerEntryRow(LedgerEntry entry) =>
      LedgerEntriesCompanion.insert(
        id: entry.id,
        occurredAt: entry.occurredAt,
        kind: entry.kind,
        bucketId: entry.bucketId,
        amount: entry.amount.ngwee,
        counterBucketId: Value(entry.counterBucketId),
        paydayId: Value(entry.refs.paydayId),
        transferId: Value(entry.refs.transferId),
        alertId: Value(entry.refs.alertId),
        transactionId: Value(entry.refs.transactionId),
        receiptId: Value(entry.refs.receiptId),
        billId: Value(entry.refs.billId),
        carryOverId: Value(entry.refs.carryOverId),
        note: Value(entry.note),
        reversesEntryId: Value(entry.reversesEntryId),
      );

  /// A payday from its row, its transfers (in position order) and their
  /// proof references (in position order, any transfer).
  static Result<Payday> payday(
    PaydayRow row,
    List<TransferRow> transfers,
    List<TransferProofRefRow> refs,
  ) => switch (collectAll([
    for (final t in transfers)
      Transfer.create(
        id: t.id,
        bucketId: t.bucketId,
        toAccountId: t.toAccountId,
        amount: Money(t.amount),
        status: t.status,
        provenAmount: _money(t.provenAmount),
        owedAmount: _money(t.owedAmount),
        proofRefs: [
          for (final r in refs)
            if (r.transferId == t.id) r.reference,
        ],
        provenAt: t.provenAt,
      ),
  ])) {
    Ok(value: final list) => Payday.create(
      id: row.id,
      incomeSourceId: row.incomeSourceId,
      amount: Money(row.amount),
      startedAt: row.startedAt,
      transfers: list,
      snoozesUsed: row.snoozesUsed,
      status: row.status,
      snoozedUntil: row.snoozedUntil,
    ),
    Err(:final failure) => Err(failure),
  };

  /// The rows for [payday].
  static (
    PaydaysCompanion,
    List<TransfersCompanion>,
    List<TransferProofRefsCompanion>,
  )
  paydayRows(Payday payday) => (
    PaydaysCompanion.insert(
      id: payday.id,
      incomeSourceId: payday.incomeSourceId,
      amount: payday.amount.ngwee,
      startedAt: payday.startedAt,
      snoozesUsed: payday.snoozesUsed,
      status: payday.status,
      snoozedUntil: Value(payday.snoozedUntil),
    ),
    [
      for (final (i, t) in payday.transfers.indexed)
        TransfersCompanion.insert(
          id: t.id,
          paydayId: payday.id,
          position: i,
          bucketId: t.bucketId,
          toAccountId: t.toAccountId,
          amount: t.amount.ngwee,
          status: t.status,
          provenAmount: Value(t.provenAmount?.ngwee),
          owedAmount: Value(t.owedAmount?.ngwee),
          provenAt: Value(t.provenAt),
        ),
    ],
    [
      for (final t in payday.transfers)
        for (final (i, ref) in t.proofRefs.indexed)
          TransferProofRefsCompanion.insert(
            transferId: t.id,
            position: i,
            reference: ref,
          ),
    ],
  );

  /// Held side-hustle money from its row.
  static Result<HeldIncome> heldIncome(HeldIncomeRow row) => HeldIncome.create(
    id: row.id,
    incomeSourceId: row.incomeSourceId,
    amount: Money(row.amount),
    receivedAt: row.receivedAt,
    alertId: row.alertId,
  );

  /// The row for [held].
  static HeldIncomesCompanion heldIncomeRow(HeldIncome held) =>
      HeldIncomesCompanion.insert(
        id: held.id,
        incomeSourceId: held.incomeSourceId,
        amount: held.amount.ngwee,
        receivedAt: held.receivedAt,
        alertId: Value(held.alertId),
      );

  /// A goal from its row.
  static Result<Goal> goal(GoalRow row) => Goal.create(
    bucketId: row.bucketId,
    target: Money(row.target),
    targetDate: row.targetDate,
    celebratedAt: row.celebratedAt,
  );

  /// The row for [goal].
  static GoalsCompanion goalRow(Goal goal) => GoalsCompanion.insert(
    bucketId: goal.bucketId,
    target: goal.target.ngwee,
    targetDate: Value(goal.targetDate),
    celebratedAt: Value(goal.celebratedAt),
  );

  /// A check-in from its row.
  static Result<CheckIn> checkIn(CheckInRow row) => CheckIn.create(
    id: row.id,
    countedAt: row.countedAt,
    expectedCash: Money(row.expectedCash),
    countedCash: Money(row.countedCash),
  );

  /// The row for [checkIn].
  static CheckInsCompanion checkInRow(CheckIn checkIn) =>
      CheckInsCompanion.insert(
        id: checkIn.id,
        countedAt: checkIn.countedAt,
        expectedCash: checkIn.expectedCash.ngwee,
        countedCash: checkIn.countedCash.ngwee,
      );

  static Money? _money(int? ngwee) => ngwee == null ? null : Money(ngwee);
}
