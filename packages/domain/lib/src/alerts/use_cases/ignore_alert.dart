import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';
import 'package:buckets_domain/src/shared/attempt.dart';

/// Dismisses an alert (screens 17, 18).
final class IgnoreAlert {
  /// Creates the use case.
  const IgnoreAlert(this._alerts);

  final AlertRepository _alerts;

  /// The alert, now ignored.
  Future<Result<PaymentAlert>> call(String alertId) => attempt(() async {
    final alert = unwrap(
      unwrap(await _alerts.get(alertId)).withStatus(AlertStatus.ignored),
    );
    unwrap(await _alerts.save(alert));
    return alert;
  });
}
