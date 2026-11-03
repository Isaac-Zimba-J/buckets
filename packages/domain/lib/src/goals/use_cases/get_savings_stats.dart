import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/ledger/use_cases/get_current_cycle.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// The stat cards on Goals (screen 10).
final class GetSavingsStats {
  /// Creates the use case.
  const new(this._buckets, this._ledger, this._cycle);

  final BucketRepository _buckets;
  final LedgerRepository _ledger;
  final GetCurrentCycle _cycle;

  static const Set<BucketKind> _spending = {
    BucketKind.living,
    BucketKind.guiltFree,
  };

  /// Total saved (every bucket except Living and Guilt-free) and saved
  /// this cycle (allocations to them, excluding bill money).
  Future<Result<({Money totalSaved, Money savedThisCycle})>> call() =>
      attempt(() async {
        final saving = {
          for (final b in unwrap(await _buckets.getAll()))
            if (!_spending.contains(b.kind) && !b.archived) b.id,
        };
        final entries = unwrap(await _ledger.getEntries());
        final cycle = unwrap(await _cycle()).cycle;
        return (
          totalSaved: saving.fold(
            Money.zero,
            (s, id) => s + BalanceCalculator.balance(entries, id),
          ),
          savedThisCycle: entries
              .where(
                (e) =>
                    e.kind == LedgerEntryKind.allocation &&
                    e.refs.billId == null &&
                    saving.contains(e.bucketId) &&
                    (cycle?.contains(e.occurredAt) ?? false),
              )
              .fold(Money.zero, (s, e) => s + e.amount),
        );
      });
}
