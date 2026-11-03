import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/use_cases/get_bill_reservations.dart';
import 'package:buckets_domain/src/buckets/policies/overspend_policy.dart';
import 'package:buckets_domain/src/buckets/ports/bucket_repository.dart';
import 'package:buckets_domain/src/income/entities/income_source.dart';
import 'package:buckets_domain/src/income/ports/income_repository.dart';
import 'package:buckets_domain/src/ledger/ports/ledger_repository.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/payday/policies/payday_planner.dart';
import 'package:buckets_domain/src/payday/ports/payday_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/split/ports/split_profile_repository.dart';

/// Starts a payday: "Salary landed", a confirmed salary alert, or a
/// side-hustle split (R-PAY-1, R-PAY-2).
final class StartPayday {
  /// Creates the use case.
  const new({
    required this._incomes,
    required this._profiles,
    required this._buckets,
    required this._reservations,
    required this._ledger,
    required this._paydays,
    required this._ids,
    required this._clock,
  });

  final IncomeRepository _incomes;
  final SplitProfileRepository _profiles;
  final BucketRepository _buckets;
  final GetBillReservations _reservations;
  final LedgerRepository _ledger;
  final PaydayRepository _paydays;
  final IdGenerator _ids;
  final Clock _clock;

  /// The new payday for [amount] from [incomeSourceId]. Writes the split
  /// and bill allocations; a salary payday also settles overspend
  /// carry-overs, reducing those allocations (R-OVER-2).
  Future<Result<Payday>> call({
    required String incomeSourceId,
    required Money amount,
  }) => attempt(() async {
    final income = unwrap(await _incomes.get(incomeSourceId));
    final open = unwrap(await _paydays.getAll()).where(
      (p) => p.status == PaydayStatus.open && p.incomeSourceId == income.id,
    );
    if (open.isNotEmpty) {
      unwrap<void>(
        const Err(
          ConflictFailure('payday.alreadyOpen', 'Finish the open payday.'),
        ),
      );
    }
    final now = _clock.now();
    final bills = income.deductBillsFirst
        ? unwrap(await _reservations()).$1.map((l) => l.reservation).toList()
        : const <Never>[];
    final started = unwrap(
      PaydayPlanner.start(
        ids: _ids,
        income: income,
        amount: amount,
        profile: unwrap(await _profiles.get(income.splitProfileId)),
        buckets: unwrap(await _buckets.getAll()),
        bills: bills,
        now: now,
      ),
    );
    final settlements = income.kind == IncomeKind.salary
        ? unwrap(
            OverspendPolicy.settleCarryOvers(
              unwrap(await _ledger.getEntries()),
              paydayId: started.payday.id,
              ids: _ids,
              at: now,
            ),
          )
        : const <Never>[];
    unwrap(await _ledger.append([...started.entries, ...settlements]));
    final payday = PaydayPlanner.refreshStatus(started.payday);
    unwrap(await _paydays.save(payday));
    return payday;
  });
}
