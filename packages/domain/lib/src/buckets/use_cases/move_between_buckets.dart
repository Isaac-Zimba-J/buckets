import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/policies/move_policy.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/policies/ledger_policy.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/ledger/use_cases/get_current_cycle.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// The result of asking to move money (R-MOVE-1, R-MOVE-2).
sealed class MoveOutcome {
  const MoveOutcome();
}

/// The move needs confirmation first; nothing was written.
final class MoveNeedsConfirm extends MoveOutcome {
  /// Creates the prompt with [warning].
  const MoveNeedsConfirm(this.warning);

  /// Why to confirm.
  final MoveWarning warning;
}

/// The move happened; [entries] are the pair that was appended.
final class MoveCompleted extends MoveOutcome {
  /// Creates the result.
  const MoveCompleted(this.entries);

  /// The move pair (R-LEDGER-3).
  final List<LedgerEntry> entries;
}

/// Moves money from one bucket to another by hand (screen 09).
final class MoveBetweenBuckets {
  /// Creates the use case.
  const new(this._buckets, this._ledger, this._cycle, this._ids, this._clock);

  final BucketRepository _buckets;
  final LedgerRepository _ledger;
  final GetCurrentCycle _cycle;
  final IdGenerator _ids;
  final Clock _clock;

  /// Moves [amount] from [fromBucketId] to [toBucketId]. Returns
  /// [MoveNeedsConfirm] when the move needs confirming and [confirmed] is
  /// false; pass [confirmed] true to go ahead.
  Future<Result<MoveOutcome>> call({
    required String fromBucketId,
    required String toBucketId,
    required Money amount,
    bool confirmed = false,
  }) => attempt(() async {
    final from = unwrap(await _buckets.get(fromBucketId));
    final entries = unwrap(await _ledger.getEntries());
    final available = MovePolicy.available(from, entries);
    if (amount > available) {
      unwrap<void>(
        Err(
          ValidationFailure(
            'amount.exceedsAvailable',
            'You can move at most ${MoneyFormatter.format(available)}.',
          ),
        ),
      );
    }
    final cycle = unwrap(await _cycle()).cycle;
    final warning = MovePolicy.warningFor(
      from: from,
      amount: amount,
      entries: entries,
      cycleStart: cycle?.start,
    );
    if (warning != null && !confirmed) return MoveNeedsConfirm(warning);
    final pair = unwrap(
      LedgerPolicy.move(
        ids: _ids,
        fromBucketId: fromBucketId,
        toBucketId: toBucketId,
        amount: amount,
        at: _clock.now(),
      ),
    );
    unwrap(await _ledger.append(pair));
    return MoveCompleted(pair);
  });
}
