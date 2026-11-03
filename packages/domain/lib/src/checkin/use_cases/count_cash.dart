import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/checkin/entities/check_in.dart';
import 'package:buckets_domain/src/checkin/policies/check_in_flow.dart';
import 'package:buckets_domain/src/checkin/use_cases/check_in_context.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Records a cash count (R-CASH-2, screen 22 step 2).
final class CountCash {
  /// Creates the use case.
  const CountCash(this._context, this._ids);

  final CheckInContext _context;
  final IdGenerator _ids;

  /// The saved count and what to ask about the gap.
  Future<Result<(CheckIn, GapPrompt)>> call(Money counted) => attempt(() async {
    final checkIn = unwrap(
      CheckIn.create(
        id: _ids.newId(),
        countedAt: _context.clock.now(),
        expectedCash: unwrap(await _context.expectedCash()),
        countedCash: counted,
      ),
    );
    unwrap(await _context.checkIns.save(checkIn));
    return (checkIn, CheckInFlow.gapPrompt(checkIn.gap));
  });
}
