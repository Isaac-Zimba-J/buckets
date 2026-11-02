import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/alerts/policies/sms_parser.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/payday/entities/transfer.dart';
import 'package:buckets_domain/src/payday/policies/payday_planner.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/proof/policies/proof_verifier.dart';
import 'package:buckets_domain/src/proof/value_objects/proof_result.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';
import 'package:equatable/equatable.dart';

/// What checking a pasted confirmation message found (screens 14–15).
final class ProofOutcome with Equatable {
  /// Creates an outcome.
  const ProofOutcome({
    required this.result,
    required this.parsed,
    required this.payday,
  });

  /// The four checks.
  final ProofResult result;

  /// What was read from the message.
  final ParsedMessage parsed;

  /// The payday after the proof was applied (unchanged if it failed).
  final Payday payday;

  /// Whether "Save K x and mark K y as owed" is offered (R-PROOF-3).
  bool get canSavePartial => ProofVerifier.canSavePartial(result);

  @override
  List<Object?> get props => [result, parsed, payday];
}

/// Checks a pasted message against a transfer and, if it passes, marks
/// the transfer proven (R-PROOF-1…3, screen 14).
final class ProveTransfer {
  /// Creates the use case.
  const ProveTransfer(
    this._paydays,
    this._accounts,
    this._parser,
    this._clock,
    this._zone,
  );

  final PaydayRepository _paydays;
  final AccountRepository _accounts;
  final SmsParser _parser;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// The checks for [text]; the transfer is proven only if all pass.
  Future<Result<ProofOutcome>> call({
    required String paydayId,
    required String transferId,
    required String text,
  }) => attempt(() async {
    final checked = unwrap(await check(paydayId, transferId, text));
    if (!checked.result.passed) return checked;
    final transfer = checked.payday.transfers.firstWhere(
      (t) => t.id == transferId,
    );
    final proven = unwrap(
      ProofVerifier.applyProof(
        transfer,
        checked.result,
        checked.parsed,
        _clock.now(),
      ),
    );
    final payday = unwrap(await saveTransfer(checked.payday, proven));
    return ProofOutcome(
      result: checked.result,
      parsed: checked.parsed,
      payday: payday,
    );
  });

  /// Parses [text] and runs the four checks without saving anything.
  Future<Result<ProofOutcome>> check(
    String paydayId,
    String transferId,
    String text,
  ) => attempt(() async {
    final now = _clock.now();
    final offset = _zone.offsetAt(now);
    final payday = unwrap(await _paydays.get(paydayId));
    final transfer = payday.transfers.where((t) => t.id == transferId);
    if (transfer.isEmpty) {
      unwrap<void>(
        const Err(NotFoundFailure('transfer.notFound', 'Transfer not found.')),
      );
    }
    final parsed = _parser.parse(text, utcOffset: offset);
    final reference = parsed.reference;
    final used =
        reference != null &&
        unwrap(await _paydays.isProofReferenceUsed(reference));
    final result = ProofVerifier.verify(
      transfer: transfer.single,
      destination: unwrap(await _accounts.get(transfer.single.toAccountId)),
      parsed: parsed,
      referenceUsed: used,
      paydayStartedAt: payday.startedAt,
      now: now,
      utcOffset: offset,
    );
    return ProofOutcome(result: result, parsed: parsed, payday: payday);
  });

  /// Replaces [transfer] in [payday], refreshes its status and saves it.
  Future<Result<Payday>> saveTransfer(Payday payday, Transfer transfer) =>
      attempt(() async {
        final updated = PaydayPlanner.refreshStatus(
          unwrap(
            payday.copyWith(
              transfers: [
                for (final t in payday.transfers)
                  t.id == transfer.id ? transfer : t,
              ],
            ),
          ),
        );
        unwrap(await _paydays.save(updated));
        return updated;
      });
}
