import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/proof/policies/proof_verifier.dart';
import 'package:buckets_domain/src/proof/use_cases/prove_transfer.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// "Save K x and mark K y as owed" (R-PROOF-3, screen 15).
final class RecordPartialTransfer {
  /// Creates the use case from the proving use case it shares checks with.
  const RecordPartialTransfer(this._prove, this._clock);

  final ProveTransfer _prove;
  final Clock _clock;

  /// The payday with the transfer partly proven; fails with
  /// `proof.notPartial` unless only the amount was too low.
  Future<Result<Payday>> call({
    required String paydayId,
    required String transferId,
    required String text,
  }) => attempt(() async {
    final checked = unwrap(await _prove.check(paydayId, transferId, text));
    final transfer = checked.payday.transfers.firstWhere(
      (t) => t.id == transferId,
    );
    final partial = unwrap(
      ProofVerifier.applyPartial(
        transfer,
        checked.result,
        checked.parsed,
        _clock.now(),
      ),
    );
    return unwrap(await _prove.saveTransfer(checked.payday, partial));
  });
}
