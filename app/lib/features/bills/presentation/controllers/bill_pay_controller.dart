import 'package:buckets/bootstrap/activity_use_cases.dart';
import 'package:buckets/bootstrap/bills_fees_use_cases.dart';
import 'package:buckets/bootstrap/ports.dart';
import 'package:buckets/features/shared/presentation/failure_exception.dart';
import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/buckets_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bill_pay_controller.freezed.dart';
part 'bill_pay_controller.g.dart';

/// An account the bill can be paid from, and whether it charges fees.
@freezed
abstract class PayAccountVm with _$PayAccountVm {
  /// Creates the row.
  const factory PayAccountVm({
    required String id,
    required String name,
    required bool chargesFees,
  }) = _PayAccountVm;
}

/// Screen 34 Mark bill paid.
@freezed
abstract class BillPayState with _$BillPayState {
  /// The sheet: the unpaid occurrence of [billName] and the accounts to pay
  /// from. [saving] shows while the payment is written.
  const factory BillPayState({
    required String occurrenceId,
    required String billName,
    required Money expected,
    required List<PayAccountVm> accounts,
    String? defaultAccountId,
    @Default(false) bool saving,
    String? errorCode,
  }) = _BillPayState;
}

/// Screen 34 for [billId].
@riverpod
class BillPayController extends _$BillPayController {
  @override
  Future<BillPayState> build(String billId) async {
    final bill = (await ref.watch(billRepositoryProvider).getAll())
        .orThrow()
        .firstWhere((b) => b.id == billId);
    final due =
        (await ref.watch(billOccurrenceRepositoryProvider).getForBill(billId))
            .orThrow()
            .where((o) => o.status == BillStatus.due)
            .toList()
          ..sort((a, b) => a.dueDate.compareTo(b.dueDate));
    if (due.isEmpty) {
      const Err<void>(NotFoundFailure('bill.notDue', 'This bill is paid.'))
          .orThrow();
    }
    final accounts = (await ref.watch(accountRepositoryProvider).getAll())
        .orThrow();
    final spending = accounts.where((a) => a.isSpending).firstOrNull;
    return BillPayState(
      occurrenceId: due.first.id,
      billName: bill.name,
      expected: due.first.expectedAmount,
      accounts: [
        for (final a in accounts)
          PayAccountVm(
            id: a.id,
            name: a.name,
            chargesFees: FeePolicy.providerOf(a.kind) != null,
          ),
      ],
      defaultAccountId: spending?.id ?? accounts.firstOrNull?.id,
    );
  }

  /// The estimated fee for paying [amount] from [accountId]; null when the
  /// account charges none or no rate covers it (R-FEE-2).
  Future<Money?> estimateFee({
    required Money amount,
    required String accountId,
  }) async {
    final accounts = (await ref.read(accountRepositoryProvider).getAll())
        .orThrow();
    final kind = accounts.firstWhere((a) => a.id == accountId).kind;
    final provider = FeePolicy.providerOf(kind);
    if (provider == null) return null;
    return (await ref.read(estimateFeeProvider)(
      provider: provider,
      feeType: FeeType.billPay,
      amount: amount,
    )).orThrow();
  }

  /// Marks the bill paid (R-BILL-7). A null [fee] means "estimate it".
  /// Returns whether it worked; failures show as `errorCode`.
  Future<bool> pay({
    required Money amount,
    required String accountId,
    Money? fee,
    String? proofText,
  }) async {
    final current = state.value;
    if (current == null) return false;
    state = AsyncData(current.copyWith(saving: true, errorCode: null));
    // A pasted confirmation gives the real fee and the reference (R-FEE-3).
    final parsed = proofText == null || proofText.trim().isEmpty
        ? null
        : ref.read(parsePastedMessageProvider)(proofText);
    final result = await ref.read(markBillPaidProvider)(
      occurrenceId: current.occurrenceId,
      amount: amount,
      accountId: accountId,
      fee: fee ?? parsed?.fee,
      proofRef: parsed?.reference,
    );
    state = AsyncData(
      current.copyWith(
        saving: false,
        errorCode: switch (result) {
          Err(:final failure) => failure.code,
          Ok() => null,
        },
      ),
    );
    return result is Ok;
  }
}
