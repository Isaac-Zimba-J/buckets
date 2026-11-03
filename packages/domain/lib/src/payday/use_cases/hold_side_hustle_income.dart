import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';
import 'package:buckets_domain/src/payday/entities/held_income.dart';
import 'package:buckets_domain/src/payday/policies/payday_planner.dart';
import 'package:buckets_domain/src/payday/ports/held_income_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';

/// "Hold until month end" for side-hustle money (R-PAY-6, screen 17).
final class HoldSideHustleIncome {
  /// Creates the use case.
  const new(this._alerts, this._held, this._ids, this._clock, this._zone);

  final AlertRepository _alerts;
  final HeldIncomeRepository _held;
  final IdGenerator _ids;
  final Clock _clock;
  final LocalTimeZone _zone;

  /// The held amount and when it will be split.
  Future<Result<(HeldIncome, DateTime)>> call({
    required String alertId,
    required String incomeSourceId,
    Money? amount,
  }) => attempt(() async {
    final now = _clock.now();
    final alert = unwrap(await _alerts.get(alertId));
    final money = amount ?? alert.parsed.amount;
    if (money == null) {
      unwrap<void>(
        const Err(
          ValidationFailure('amount.missing', "We couldn't read the amount."),
        ),
      );
    }
    final held = unwrap(
      HeldIncome.create(
        id: _ids.newId(),
        incomeSourceId: incomeSourceId,
        amount: money!,
        receivedAt: alert.receivedAt,
        alertId: alert.id,
      ),
    );
    unwrap(await _held.add(held));
    unwrap(await _alerts.save(unwrap(alert.withStatus(AlertStatus.sorted))));
    return (
      held,
      PaydayPlanner.holdReleaseAt(now, utcOffset: _zone.offsetAt(now)),
    );
  });
}
