import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/proof/policies/proof_verifier.dart';
import 'package:buckets_domain/src/proof/use_cases/prove_transfer.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// "Mark as saved" without proof (R-PROOF-4, screen 14).
final class MarkTransferSelfReported {
  /// Creates the use case.
  const new(this._paydays, this._prove, this._clock);

  final PaydayRepository _paydays;
  final ProveTransfer _prove;
  final Clock _clock;

  /// The payday with the transfer self-reported.
  Future<Result<Payday>> call({
    required String paydayId,
    required String transferId,
  }) => attempt(() async {
    final payday = unwrap(await _paydays.get(paydayId));
    final transfer = payday.transfers.where((t) => t.id == transferId);
    if (transfer.isEmpty) {
      unwrap<void>(
        const Err(NotFoundFailure('transfer.notFound', 'Transfer not found.')),
      );
    }
    final marked = unwrap(
      ProofVerifier.markSelfReported(transfer.single, _clock.now()),
    );
    return unwrap<Payday>(await _prove.saveTransfer(payday, marked));
  });
}
