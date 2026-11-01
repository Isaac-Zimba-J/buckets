import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/entities/account.dart';
import 'package:buckets_domain/src/alerts/value_objects/parsed_message.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/payday/entities/transfer.dart';
import 'package:buckets_domain/src/proof/value_objects/check_outcome.dart';
import 'package:buckets_domain/src/proof/value_objects/proof_result.dart';
import 'package:buckets_domain/src/shared/local_date.dart';

/// Checks a confirmation message against a payday transfer (DOMAIN §9).
abstract final class ProofVerifier {
  /// How far the parsed amount may differ from the transfer (R-PROOF-1.1).
  static const amountTolerance = Money(100);

  /// What a proof must show: the owed amount of a partial transfer,
  /// otherwise the whole amount.
  static Money amountDue(Transfer transfer) =>
      transfer.status == TransferStatus.partial
      ? transfer.owedAmount ?? transfer.amount
      : transfer.amount;

  /// The four checks of R-PROOF-1. A field that wasn't parsed gives
  /// [CheckUnknown] (R-PROOF-2).
  static ProofResult verify({
    required Transfer transfer,
    required Account destination,
    required ParsedMessage parsed,
    required bool referenceUsed,
    required DateTime paydayStartedAt,
    required DateTime now,
    required Duration utcOffset,
  }) => ProofResult(
    amount: _amount(parsed.amount, amountDue(transfer)),
    account: _account(parsed.counterparty, destination),
    date: _date(parsed.occurredAt, paydayStartedAt, now, utcOffset),
    reference: _reference(parsed.reference, referenceUsed),
  );

  static CheckOutcome _amount(Money? parsed, Money due) {
    if (parsed == null) return const CheckUnknown();
    if ((parsed - due).abs() <= amountTolerance) return const CheckPassed();
    return CheckFailed(parsed < due ? 'amountTooLow' : 'amountTooHigh');
  }

  static CheckOutcome _account(String? counterparty, Account destination) {
    if (counterparty == null) return const CheckUnknown();
    return destination.matchKeys.any((k) => k.isFoundIn(counterparty))
        ? const CheckPassed()
        : const CheckFailed('accountMismatch');
  }

  static CheckOutcome _date(
    DateTime? at,
    DateTime startedAt,
    DateTime now,
    Duration utcOffset,
  ) {
    if (at == null) return const CheckUnknown();
    final daysAgo = LocalDate.ofInstant(
      at,
      utcOffset,
    ).daysUntil(LocalDate.ofInstant(now, utcOffset));
    if (daysAgo != 0 && daysAgo != 1) {
      return const CheckFailed('notTodayOrYesterday');
    }
    return at.isBefore(startedAt.subtract(const Duration(days: 1)))
        ? const CheckFailed('beforePayday')
        : const CheckPassed();
  }

  static CheckOutcome _reference(String? reference, bool used) {
    if (reference == null || reference.trim().isEmpty) {
      return const CheckUnknown();
    }
    return used ? const CheckFailed('referenceUsed') : const CheckPassed();
  }

  /// Whether "Save K x and mark K y as owed" is offered: the amount is the
  /// only failed check and it is too low (R-PROOF-3).
  static bool canSavePartial(ProofResult result) =>
      result.amount == const CheckFailed('amountTooLow') &&
      [
        result.account,
        result.date,
        result.reference,
      ].every((c) => c is CheckPassed);

  /// [transfer] proven by [parsed] (R-PROOF-1). Fails unless [result]
  /// passed.
  static Result<Transfer> applyProof(
    Transfer transfer,
    ProofResult result,
    ParsedMessage parsed,
    DateTime now,
  ) {
    if (!result.passed) {
      return const Err(
        ValidationFailure('proof.notPassed', 'This message does not prove it.'),
      );
    }
    return transfer.copyWith(
      status: TransferStatus.proven,
      provenAmount: (transfer.provenAmount ?? Money.zero) + parsed.amount!,
      owedAmount: Money.zero,
      proofRefs: [...transfer.proofRefs, parsed.reference!],
      provenAt: now,
    );
  }

  /// [transfer] partly proven: the parsed amount is saved and the rest is
  /// owed (R-PROOF-3). Fails unless [canSavePartial].
  static Result<Transfer> applyPartial(
    Transfer transfer,
    ProofResult result,
    ParsedMessage parsed,
    DateTime now,
  ) {
    if (!canSavePartial(result)) {
      return const Err(
        ValidationFailure('proof.notPartial', 'Partial save is not possible.'),
      );
    }
    final amount = parsed.amount!;
    return transfer.copyWith(
      status: TransferStatus.partial,
      provenAmount: (transfer.provenAmount ?? Money.zero) + amount,
      owedAmount: amountDue(transfer) - amount,
      proofRefs: [...transfer.proofRefs, parsed.reference!],
      provenAt: now,
    );
  }

  /// "Mark as saved" without proof (R-PROOF-4).
  static Result<Transfer> markSelfReported(Transfer transfer, DateTime now) =>
      transfer.status == TransferStatus.proven
      ? const Err(
          ConflictFailure('transfer.alreadyProven', 'This is already proven.'),
        )
      : transfer.copyWith(status: TransferStatus.selfReported, provenAt: now);

  /// Consecutive completed paydays where every transfer is proven, from
  /// [newestFirst]. The newest payday is skipped while open; an older open
  /// one ends the streak; self-reported paydays neither count nor break it
  /// (R-PROOF-5).
  static int streak(List<Payday> newestFirst) {
    var count = 0;
    for (final (i, payday) in newestFirst.indexed) {
      if (payday.status == PaydayStatus.open) {
        if (i == 0) continue;
        break;
      }
      final statuses = payday.transfers.map((t) => t.status).toSet();
      if (statuses.every((s) => s == TransferStatus.proven)) {
        count++;
      } else if (!statuses.every(
        (s) => s == TransferStatus.proven || s == TransferStatus.selfReported,
      )) {
        break;
      }
    }
    return count;
  }
}
