import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/policies/fee_policy.dart';
import 'package:buckets_domain/src/fees/ports/fee_tariff_repository.dart';
import 'package:buckets_domain/src/fees/value_objects/fees_summary.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/date_window.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';

/// The fee for each transfer of a payday (R-FEE-5, SCREENS 13): estimated
/// from the source account's rates, or the actual fee once the transfer's
/// proof recorded one.
final class EstimatePaydayFees {
  /// Creates the use case.
  const new(
    this._paydays,
    this._incomes,
    this._accounts,
    this._tariffs,
    this._transactions,
    this._clock,
  );

  final PaydayRepository _paydays;
  final IncomeRepository _incomes;
  final AccountRepository _accounts;
  final FeeTariffRepository _tariffs;
  final TransactionRepository _transactions;
  final Clock _clock;

  /// The fees of [paydayId]'s transfers.
  Future<Result<PaydayFees>> call(String paydayId) => attempt(() async {
    final payday = unwrap(await _paydays.get(paydayId));
    final income = unwrap(await _incomes.get(payday.incomeSourceId));
    final source = unwrap(await _accounts.getAll())
        .where((a) => a.id == income.landsInAccountId)
        .firstOrNull;
    final provider = source == null ? null : FeePolicy.providerOf(source.kind);
    if (provider == null) {
      return PaydayFees({
        for (final t in payday.transfers) t.id: const TransferFee(null),
      });
    }
    final tariff = unwrap(await _tariffs.find(provider, FeeType.send));
    final end = _clock.now().add(const Duration(days: 1));
    final window = DateWindow.create(payday.startedAt, end);
    final recorded = window is Ok<DateWindow>
        ? unwrap(await _transactions.getIn(window.value))
        : <Transaction>[];
    return PaydayFees({
      for (final t in payday.transfers)
        t.id: switch (recorded
            .where((r) => r.parentTransactionId == t.id)
            .firstOrNull) {
          final fee? when fee.feeSource != FeeSource.missing => TransferFee(
            fee.amount,
            isActual: true,
          ),
          _ => TransferFee(FeePolicy.estimate(tariff, t.amount)),
        },
    });
  });
}
