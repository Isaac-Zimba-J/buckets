import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/buckets/policies/overspend_policy.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/ledger/policies/balance_calculator.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/date_window.dart';

/// How an overspent bucket can be covered (screen 09, R-OVER-2/4).
final class GetCoverOptions {
  /// Creates the use case.
  const GetCoverOptions(
    this._buckets,
    this._ledger,
    this._paydays,
    this._incomes,
    this._clock,
  );

  final BucketRepository _buckets;
  final LedgerRepository _ledger;
  final PaydayRepository _paydays;
  final IncomeRepository _incomes;
  final Clock _clock;

  /// The options in order, the overspent amount, and whether to show
  /// "your split may be too tight". Null when the bucket isn't overspent.
  Future<Result<(List<CoverOption>, Money, bool)?>> call(String bucketId) =>
      attempt(() async {
        final entries = unwrap(await _ledger.getEntries());
        final balances = BalanceCalculator.balances(entries);
        final amount = OverspendPolicy.overspentBy(
          balances[bucketId] ?? Money.zero,
        );
        if (amount == null) return null;
        final options = OverspendPolicy.coverOptions(
          overspent: unwrap(await _buckets.get(bucketId)),
          amount: amount,
          buckets: unwrap(await _buckets.getAll()),
          balances: balances,
        );
        final cycles = unwrap(await _salaryCycles());
        final tight = OverspendPolicy.suggestSplitReview([
          for (final c in cycles)
            OverspendPolicy.wasOverspentIn(entries, bucketId, c),
        ]);
        return (options, amount, tight);
      });

  /// Up to the last 3 cycles between salary paydays, oldest first; the last
  /// runs to now.
  Future<Result<List<DateWindow>>> _salaryCycles() => attempt(() async {
    final salaryIds = {
      for (final i in unwrap(await _incomes.getAll()))
        if (i.kind == IncomeKind.salary) i.id,
    };
    final starts = [
      for (final p in unwrap(await _paydays.getAll()).reversed)
        if (salaryIds.contains(p.incomeSourceId)) p.startedAt,
    ];
    final ends = [
      ...starts.skip(1),
      _clock.now().add(const Duration(seconds: 1)),
    ];
    final windows = [
      for (var i = 0; i < starts.length; i++)
        if (ends[i].isAfter(starts[i]))
          unwrap(DateWindow.create(starts[i], ends[i])),
    ];
    return windows.length <= 3 ? windows : windows.sublist(windows.length - 3);
  });
}
