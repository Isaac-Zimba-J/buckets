import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payday_view_models.freezed.dart';

/// A transfer row on the payday checklist (screen 13).
@freezed
abstract class TransferRowVm with _$TransferRowVm {
  /// Creates the row; [owed] is set for a partial transfer.
  const factory TransferRowVm({
    required String id,
    required String bucketId,
    required String bucketName,
    required BucketColor color,
    required Money amount,
    required TransferStatus status,
    required Money? owed,
  }) = _TransferRowVm;
}

/// Which proof check a row shows (screen 14).
enum ProofCheck {
  /// Amount within K 1.
  amount,

  /// Destination account.
  account,

  /// Today or yesterday.
  date,

  /// Unused reference.
  reference,
}

/// One proof check row: passed, failed with a reason, or unknown (the
/// field wasn't found, so the screen says which field to check).
@freezed
abstract class CheckRowVm with _$CheckRowVm {
  /// Creates the row; [reason] is set when it failed.
  const factory CheckRowVm({
    required ProofCheck check,
    required bool passed,
    required bool unknown,
    required String? reason,
  }) = _CheckRowVm;

  /// The rows of [result], in display order.
  static List<CheckRowVm> of(ProofResult result) => [
    for (final (check, outcome) in [
      (ProofCheck.amount, result.amount),
      (ProofCheck.account, result.account),
      (ProofCheck.date, result.date),
      (ProofCheck.reference, result.reference),
    ])
      CheckRowVm(
        check: check,
        passed: outcome is CheckPassed,
        unknown: outcome is CheckUnknown,
        reason: switch (outcome) {
          CheckFailed(:final reason) => reason,
          _ => null,
        },
      ),
  ];
}
