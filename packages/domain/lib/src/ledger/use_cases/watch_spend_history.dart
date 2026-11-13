import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/ledger/entities/ledger_entry.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/ledger/value_objects/month_spend.dart';

/// The result of [WatchSpendHistory.call].
final class SpendHistory {
  /// Creates a spend history.
  const new({required this.months, required this.allTime});

  /// Months with any spending, most recent first.
  final List<MonthSpend> months;

  /// Total spending across all time.
  final Money allTime;
}

/// Watches the ledger and groups spend entries by UTC calendar month,
/// netting reversals so the history stays accurate after refunds.
final class WatchSpendHistory {
  /// Creates the use case.
  const new(this._ledger);

  final LedgerRepository _ledger;

  /// Emits a [SpendHistory] whenever the ledger changes.
  Stream<SpendHistory> call() => _ledger.watchEntries().map(_compute);

  static SpendHistory _compute(List<LedgerEntry> entries) {
    // Collect reversed entry IDs so we can net them out.
    final reversedIds = {
      for (final e in entries)
        if (e.kind == LedgerEntryKind.reversal && e.reversesEntryId != null)
          e.reversesEntryId!,
    };

    // Map year-month → {ngwee total, individual entries}.
    final byMonthTotal = <(int, int), int>{};
    final byMonthEntries = <(int, int), List<LedgerEntry>>{};
    for (final e in entries) {
      if (e.kind != LedgerEntryKind.spend) continue;
      if (reversedIds.contains(e.id)) continue;
      final key = (e.occurredAt.year, e.occurredAt.month);
      byMonthTotal[key] = (byMonthTotal[key] ?? 0) + (-e.amount.ngwee);
      (byMonthEntries[key] ??= []).add(e);
    }

    final months =
        [
          for (final entry in byMonthTotal.entries)
            MonthSpend(
              year: entry.key.$1,
              month: entry.key.$2,
              total: Money(entry.value),
              entries: (byMonthEntries[entry.key] ?? [])
                ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt)),
            ),
        ]..sort((a, b) {
          final cy = b.year.compareTo(a.year);
          return cy != 0 ? cy : b.month.compareTo(a.month);
        });

    final allTime = byMonthTotal.values.fold(0, (s, v) => s + v);
    return SpendHistory(months: months, allTime: Money(allTime));
  }
}
