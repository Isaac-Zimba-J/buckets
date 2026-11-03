import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/ledger/use_cases/get_current_cycle.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/local_date.dart';

/// The next expected salary payday and days until it (screen 07 countdown).
final class GetNextPayday {
  /// Creates the use case.
  const GetNextPayday(this._cycle);

  final GetCurrentCycle _cycle;

  /// The date and days left, or null without a regular salary.
  Future<Result<(LocalDate, int)?>> call() => attempt(() async {
    final info = unwrap(await _cycle());
    final next = info.nextPayday;
    return next == null ? null : (next, info.daysLeft!);
  });
}
