import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/bills/ports/bill_occurrence_repository.dart';
import 'package:buckets_domain/src/bills/use_cases/get_bills_cycle.dart';
import 'package:buckets_domain/src/bills/value_objects/bills_cycle_view.dart';

/// [GetBillsCycle], refreshed whenever an occurrence changes (SCREENS 33).
/// Money that only moves in the ledger (e.g. a payday) shows up once the
/// payday creates its occurrences.
final class WatchBillsCycle {
  /// Creates the use case.
  const new(this._occurrences, this._get);

  final BillOccurrenceRepository _occurrences;
  final GetBillsCycle _get;

  /// Emits the view now and after every change.
  Stream<BillsCycleView?> call() => _occurrences.watchAll().asyncMap(
    (_) async => switch (await _get()) {
      Ok(:final value) => value,
      Err() => null,
    },
  );
}
