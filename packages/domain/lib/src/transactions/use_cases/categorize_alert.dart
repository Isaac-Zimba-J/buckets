import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/entities/account.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/policies/categorizer.dart';
import 'package:buckets_domain/src/transactions/policies/spending_policy.dart';
import 'package:buckets_domain/src/transactions/ports/merchant_rule_repository.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';
import 'package:buckets_domain/src/transactions/use_cases/spend_writer.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// Files a payment alert from the sort sheet (screen 18, R-SPEND-1…4).
final class CategorizeAlert {
  /// Creates the use case.
  const new({
    required this._alerts,
    required this._accounts,
    required this._transactions,
    required this._rules,
    required this._writer,
    required this._ids,
  });

  final AlertRepository _alerts;
  final AccountRepository _accounts;
  final TransactionRepository _transactions;
  final MerchantRuleRepository _rules;
  final SpendWriter _writer;
  final IdGenerator _ids;

  /// Files [alertId] as [category] from [bucketId] and marks it sorted. A
  /// withdrawal moves cash into Cash in hand instead and only its fee is
  /// spending (returns null). [alwaysFile] saves a merchant rule.
  Future<Result<Transaction?>> call({
    required String alertId,
    required Category category,
    required String bucketId,
    bool alwaysFile = false,
  }) => attempt(() async {
    final alert = unwrap(await _alerts.get(alertId));
    final accounts = unwrap(await _accounts.getAll());
    final account = accountFor(alert.source, accounts);
    Transaction? filed;
    if (alert.parsed.isWithdrawal) {
      final cash = accounts.firstWhere((a) => a.kind == AccountKind.cash);
      final (withdrawal, fee) = unwrap(
        SpendingPolicy.withdrawal(
          alert,
          ids: _ids,
          fromAccountId: account.id,
          cashAccountId: cash.id,
          feeBucketId: bucketId,
        ),
      );
      unwrap(await _transactions.saveWithdrawal(withdrawal));
      if (fee != null) unwrap(await _writer.write(fee));
    } else {
      final amount = alert.parsed.amount;
      if (amount == null) {
        unwrap<void>(
          const Err(ValidationFailure('amount.missing', 'Enter the amount.')),
        );
      }
      filed = unwrap(
        await _writer.write(
          unwrap(
            Transaction.create(
              id: _ids.newId(),
              amount: amount!,
              bucketId: bucketId,
              category: category,
              accountId: account.id,
              occurredAt: alert.parsed.occurredAt ?? alert.receivedAt,
              source: TransactionSource.alert,
              alertId: alert.id,
            ),
          ),
          fee: alert.parsed.fee,
        ),
      );
    }
    final counterparty = alert.parsed.counterparty;
    if (alwaysFile && counterparty != null) {
      unwrap(
        await _rules.save(
          unwrap(
            Categorizer.newRule(
              id: _ids.newId(),
              counterparty: counterparty,
              category: category,
              bucketId: bucketId,
            ),
          ),
        ),
      );
    }
    unwrap(await _alerts.save(unwrap(alert.withStatus(AlertStatus.sorted))));
    return filed;
  });

  /// The account an alert's money left: the first of the provider's kind,
  /// otherwise the spending account.
  static Account accountFor(AlertSource source, List<Account> accounts) {
    final kind = switch (source) {
      AlertSource.mtnMomo => AccountKind.mtnMomo,
      AlertSource.airtelMoney => AccountKind.airtelMoney,
      AlertSource.bank => AccountKind.bank,
      AlertSource.unknown => null,
    };
    return accounts.where((a) => a.kind == kind).firstOrNull ??
        accounts.firstWhere((a) => a.isSpending);
  }
}
