import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/buckets/entities/bucket.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/policies/fee_policy.dart';
import 'package:buckets_domain/src/fees/ports/fee_tariff_repository.dart';
import 'package:buckets_domain/src/fees/use_cases/learn_fee.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/use_cases/spend_writer.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// Records the fee on a proven transfer as its own Fees transaction charged
/// to Living (R-FEE-1, R-FEE-5, R-FEE-6), and learns the rate from it when
/// the message showed one (R-FEE-4).
final class RecordTransferFee {
  /// Creates the use case.
  const new(
    this._paydays,
    this._incomes,
    this._accounts,
    this._buckets,
    this._tariffs,
    this._learn,
    this._spend,
    this._clock,
    this._ids,
  );

  final PaydayRepository _paydays;
  final IncomeRepository _incomes;
  final AccountRepository _accounts;
  final BucketRepository _buckets;
  final FeeTariffRepository _tariffs;
  final LearnFee _learn;
  final SpendWriter _spend;
  final Clock _clock;
  final IdGenerator _ids;

  /// Records the fee of [transferId] on [paydayId]; the money left the
  /// income's landing account. [fee] is what the proof message showed, if
  /// anything. Returns null when that account isn't mobile money (no fee to
  /// record).
  Future<Result<Transaction?>> call({
    required String paydayId,
    required String transferId,
    Money? fee,
  }) => attempt(() async {
    final payday = unwrap(await _paydays.get(paydayId));
    final transfer = payday.transfers.firstWhere((t) => t.id == transferId);
    final fromAccountId = unwrap(await _incomes.get(payday.incomeSourceId))
        .landsInAccountId;
    final amount = transfer.amount;
    final account = unwrap(await _accounts.getAll())
        .where((a) => a.id == fromAccountId)
        .firstOrNull;
    final provider = account == null
        ? null
        : FeePolicy.providerOf(account.kind);
    final living = unwrap(await _buckets.getAll())
        .where((b) => b.kind == BucketKind.living)
        .firstOrNull;
    if (provider == null || living == null) return null;

    final (feeAmount, feeSource) = FeePolicy.resolve(
      fromMessage: fee,
      estimated: fee != null
          ? null
          : FeePolicy.estimate(
              unwrap(await _tariffs.find(provider, FeeType.send)),
              amount,
            ),
    );
    final tx = unwrap(
      Transaction.create(
        id: _ids.newId(),
        amount: feeAmount,
        bucketId: living.id,
        category: Category.fees,
        accountId: fromAccountId,
        occurredAt: _clock.now(),
        source: TransactionSource.pasted,
        feeType: FeeType.send,
        feeSource: feeSource,
        provider: provider,
        parentTransactionId: transferId,
      ),
    );
    unwrap(await _spend.writeAll([tx]));
    if (fee != null) {
      unwrap(
        await _learn(
          provider: provider,
          feeType: FeeType.send,
          amount: amount,
          fee: fee,
        ),
      );
    }
    return tx;
  });
}
