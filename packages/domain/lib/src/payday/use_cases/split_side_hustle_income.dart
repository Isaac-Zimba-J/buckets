import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';
import 'package:buckets_domain/src/payday/entities/payday.dart';
import 'package:buckets_domain/src/payday/use_cases/start_payday.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

const _noAmount = ValidationFailure(
  'amount.missing',
  "We couldn't read the amount. Enter it.",
);

/// "Split it now" for incoming side-hustle money (R-SPLIT-5, screen 17).
final class SplitSideHustleIncome {
  /// Creates the use case.
  const new(this._alerts, this._start);

  final AlertRepository _alerts;
  final StartPayday _start;

  /// A payday for the alert's amount (or [amount]), with the alert sorted.
  Future<Result<Payday>> call({
    required String alertId,
    required String incomeSourceId,
    Money? amount,
  }) => attempt(() async {
    final alert = unwrap(await _alerts.get(alertId));
    final money = amount ?? alert.parsed.amount;
    if (money == null) unwrap<void>(const Err(_noAmount));
    final payday = unwrap(
      await _start(incomeSourceId: incomeSourceId, amount: money!),
    );
    unwrap(await _alerts.save(unwrap(alert.withStatus(AlertStatus.sorted))));
    return payday;
  });
}
