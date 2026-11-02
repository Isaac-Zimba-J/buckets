import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/payday/ports/held_income_repository.dart';
import 'package:buckets_domain/src/payday/use_cases/start_payday.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Splits held side-hustle money as one combined payday at month end
/// (R-PAY-6).
final class ReleaseHeldIncome {
  /// Creates the use case.
  const ReleaseHeldIncome(this._held, this._start);

  final HeldIncomeRepository _held;
  final StartPayday _start;

  /// The combined payday, or null when nothing is held.
  Future<Result<Payday?>> call(String incomeSourceId) => attempt(() async {
    final held = unwrap(await _held.getFor(incomeSourceId));
    if (held.isEmpty) return null;
    final payday = unwrap(
      await _start(
        incomeSourceId: incomeSourceId,
        amount: held.fold(Money.zero, (s, h) => s + h.amount),
      ),
    );
    unwrap(await _held.remove([for (final h in held) h.id]));
    return payday;
  });
}
