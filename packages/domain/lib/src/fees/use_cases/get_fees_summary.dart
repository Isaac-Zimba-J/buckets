import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/fees/entities/fee_tariff.dart';
import 'package:buckets_domain/src/fees/value_objects/fees_summary.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/ledger/use_cases/get_current_cycle.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/date_window.dart';
import 'package:buckets_domain/src/transactions/entities/transaction.dart';
import 'package:buckets_domain/src/transactions/ports/transaction_repository.dart';
import 'package:buckets_domain/src/transactions/value_objects/category.dart';

/// The Fees page for the current pay cycle (R-FEE-7, SCREENS 36).
final class GetFeesSummary {
  /// Creates the use case.
  const new(this._transactions, this._cycle, this._incomes, this._paydays);

  final TransactionRepository _transactions;
  final GetCurrentCycle _cycle;
  final IncomeRepository _incomes;
  final PaydayRepository _paydays;

  /// The summary, or null before the first cycle exists.
  Future<Result<FeesSummary?>> call() => attempt(() async {
    final window = unwrap(await _cycle()).cycle;
    if (window == null) return null;
    final now = await _inWindow(window);

    final fees = now.where((t) => t.category == Category.fees).toList();
    final byProvider = <AlertSource, Money>{};
    final byType = <FeeType, Money>{};
    for (final f in fees) {
      final provider = f.provider;
      if (provider != null) {
        byProvider.update(
          provider,
          (m) => m + f.amount,
          ifAbsent: () => f.amount,
        );
      }
      final type = f.feeType;
      if (type != null) {
        byType.update(type, (m) => m + f.amount, ifAbsent: () => f.amount);
      }
    }
    final total = fees.fold(Money.zero, (s, f) => s + f.amount);
    final moved = now
        .where((t) => t.category != Category.fees)
        .fold(Money.zero, (s, t) => s + t.amount);
    final withdrawn = unwrap(await _transactions.getWithdrawalsIn(window))
        .fold(Money.zero, (s, w) => s + w.amount);
    final base = moved + withdrawn;

    final previous = await _previousWindow();
    final previousFees = previous == null
        ? Money.zero
        : (await _inWindow(previous))
              .where((t) => t.category == Category.fees)
              .fold(Money.zero, (s, f) => s + f.amount);

    return FeesSummary(
      total: total,
      byProvider: byProvider,
      byType: byType,
      missingCount: fees.where((f) => f.feeSource == FeeSource.missing).length,
      percentOfMovedBp: base.isPositive ? total.ngwee * 10000 ~/ base.ngwee : 0,
      previousTotal: previousFees,
    );
  });

  Future<List<Transaction>> _inWindow(DateWindow w) =>
      _transactions.getIn(w).then(unwrap);

  // The cycle before this one runs from the second-latest salary payday to
  // the latest; none until there have been two.
  Future<DateWindow?> _previousWindow() async {
    final salary = unwrap(await _incomes.getAll())
        .where((i) => i.kind == IncomeKind.salary)
        .firstOrNull;
    if (salary == null) return null;
    final paydays = unwrap(await _paydays.getAll())
        .where((p) => p.incomeSourceId == salary.id)
        .toList();
    if (paydays.length < 2) return null;
    return switch (DateWindow.create(
      paydays[1].startedAt,
      paydays[0].startedAt,
    )) {
      Ok(:final value) => value,
      Err() => null,
    };
  }
}
