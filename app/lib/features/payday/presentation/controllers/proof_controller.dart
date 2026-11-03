import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/features/payday/presentation/controllers/payday_view_models.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'proof_controller.freezed.dart';
part 'proof_controller.g.dart';

/// Screens 14–15 Prove transfer.
@freezed
sealed class ProofState with _$ProofState {
  /// Empty textarea.
  const factory ProofState.idle() = ProofIdle;

  /// Checking the pasted message.
  const factory ProofState.checking() = ProofChecking;

  /// Four green checks; the transfer is proven.
  const factory ProofState.passed({required List<CheckRowVm> checks}) =
      ProofPassed;

  /// Screen 15. With [canSavePartial], offer "Save [parsed] and mark [owed]
  /// as owed" (R-PROOF-3).
  const factory ProofState.failed({
    required List<CheckRowVm> checks,
    required bool canSavePartial,
    required Money? parsed,
    required Money? owed,
  }) = ProofFailed;

  /// Saved without passing proof, or partly proven; back to screen 13.
  const factory ProofState.saved() = ProofSaved;
}

/// Screens 14–15 for [transferId] of [paydayId].
@riverpod
class ProofController extends _$ProofController {
  String _lastText = '';

  @override
  ProofState build(String paydayId, String transferId) =>
      const ProofState.idle();

  /// Checks a pasted confirmation message.
  Future<void> check(String text) async {
    _lastText = text;
    state = const ProofState.checking();
    final result = await ref.read(proveTransferProvider)(
      paydayId: paydayId,
      transferId: transferId,
      text: text,
    );
    state = switch (result) {
      Err() => const ProofState.idle(),
      Ok(value: final o) when o.result.passed => ProofState.passed(
        checks: CheckRowVm.of(o.result),
      ),
      Ok(value: final o) => ProofState.failed(
        checks: CheckRowVm.of(o.result),
        canSavePartial: o.canSavePartial,
        parsed: o.parsed.amount,
        owed: switch ((o.parsed.amount, _due(o.payday))) {
          (final Money parsed, final Money due) => due - parsed,
          _ => null,
        },
      ),
    };
  }

  Money? _due(Payday payday) {
    final t = payday.transfers.where((t) => t.id == transferId).firstOrNull;
    return t == null ? null : (t.owedAmount ?? t.amount);
  }

  /// "Save K x and mark K y as owed" for the last checked message.
  Future<bool> savePartial() async {
    final result = await ref.read(recordPartialTransferProvider)(
      paydayId: paydayId,
      transferId: transferId,
      text: _lastText,
    );
    if (result is Ok) state = const ProofState.saved();
    return result is Ok;
  }

  /// "Mark as saved" without proof (R-PROOF-4).
  Future<bool> markSelfReported() async {
    final result = await ref.read(markTransferSelfReportedProvider)(
      paydayId: paydayId,
      transferId: transferId,
    );
    if (result is Ok) state = const ProofState.saved();
    return result is Ok;
  }
}
