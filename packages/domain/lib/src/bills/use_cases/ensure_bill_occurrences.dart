import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/entities/bill_occurrence.dart';
import 'package:buckets_domain/src/bills/policies/bill_occurrences.dart';
import 'package:buckets_domain/src/bills/ports/bill_occurrence_repository.dart';
import 'package:buckets_domain/src/bills/ports/bill_repository.dart';
import 'package:buckets_domain/src/ledger/use_cases/get_current_cycle.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/local_date.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';

/// Creates this cycle's occurrences for every bill due in it (R-BILL-6). Run
/// when a payday starts and whenever Plan > Bills opens; never duplicates.
final class EnsureBillOccurrences {
  /// Creates the use case.
  const new(
    this._bills,
    this._occurrences,
    this._cycle,
    this._clock,
    this._zone,
    this._ids,
  );

  final BillRepository _bills;
  final BillOccurrenceRepository _occurrences;
  final GetCurrentCycle _cycle;
  final Clock _clock;
  final LocalTimeZone _zone;
  final IdGenerator _ids;

  /// The occurrences added (empty when nothing was missing).
  Future<Result<List<BillOccurrence>>> call() => attempt(() async {
    final window = unwrap(await _cycle()).cycle;
    if (window == null) return const [];
    final offset = _zone.offsetAt(_clock.now());
    final created = BillOccurrences.forCycle(
      bills: unwrap(await _bills.getAll()),
      existing: unwrap(await _occurrences.getAll()),
      start: LocalDate.ofInstant(window.start, offset),
      end: LocalDate.ofInstant(window.end, offset),
      ids: _ids,
      utcOffset: offset,
    );
    for (final o in created) {
      unwrap(await _occurrences.save(o));
    }
    return created;
  });
}
