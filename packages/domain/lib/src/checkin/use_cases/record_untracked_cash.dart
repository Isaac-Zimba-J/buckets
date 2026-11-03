import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/entities/account.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/checkin/policies/cash_reconciler.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';

/// Records missing cash as one Untracked spend from Living (R-CASH-2).
final class RecordUntrackedCash {
  /// Creates the use case.
  const RecordUntrackedCash({
    required this._accounts,
    required this._buckets,
    required this._transactions,
    required this._ledger,
    required this._ids,
    required this._clock,
  });

  final AccountRepository _accounts;
  final BucketRepository _buckets;
  final TransactionRepository _transactions;
  final LedgerRepository _ledger;
  final IdGenerator _ids;
  final Clock _clock;

  /// Records [gap] (expected − counted, above K 0).
  Future<Result<void>> call(Money gap) => attempt(() async {
    final cash = unwrap(
      await _accounts.getAll(),
    ).firstWhere((a) => a.kind == AccountKind.cash);
    final living = unwrap(
      await _buckets.getAll(),
    ).firstWhere((b) => b.kind == BucketKind.living);
    final (tx, entry) = unwrap(
      CashReconciler.recordUntracked(
        gap: gap,
        livingBucketId: living.id,
        cashAccountId: cash.id,
        ids: _ids,
        at: _clock.now(),
      ),
    );
    unwrap(await _transactions.save(tx));
    unwrap(await _ledger.append([entry]));
  });
}
