import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/accounts/entities/account.dart';
import 'package:buckets_domain/src/accounts/ports/account_repository.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';
import 'package:buckets_domain/src/checkin/policies/cash_reconciler.dart';
import 'package:buckets_domain/src/checkin/ports/check_in_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/date_window.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';

/// Everything the check-in needs from storage (screen 22).
final class CheckInContext {
  /// Creates the context.
  const new({
    required this.alerts,
    required this.accounts,
    required this.transactions,
    required this.checkIns,
    required this.clock,
  });

  /// Unsorted alerts.
  final AlertRepository alerts;

  /// To find Cash in hand.
  final AccountRepository accounts;

  /// Cash spends and withdrawals.
  final TransactionRepository transactions;

  /// Past counts.
  final CheckInRepository checkIns;

  /// Now.
  final Clock clock;

  /// Expected cash at now (R-CASH-1).
  Future<Result<Money>> expectedCash() => attempt(() async {
    final cash = unwrap(await accounts.getAll())
        .firstWhere((a) => a.kind == AccountKind.cash);
    final last = unwrap(await checkIns.latest());
    final now = clock.now();
    final since = unwrap(
      DateWindow.create(
        last?.countedAt ?? DateTime.utc(2000),
        now.add(const Duration(seconds: 1)),
      ),
    );
    return CashReconciler.expectedCash(
      lastCheckIn: last,
      cashAccountId: cash.id,
      withdrawals: unwrap(await transactions.getWithdrawalsIn(since)),
      transactions: unwrap(await transactions.getIn(since)),
    );
  });
}
