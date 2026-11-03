import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';

/// Alerts waiting to be sorted, oldest first (screen 18, Home count).
final class WatchUnsortedAlerts {
  /// Creates the use case.
  const new(this._alerts);

  final AlertRepository _alerts;

  /// The unsorted alerts, emitting on change.
  Stream<List<PaymentAlert>> call() =>
      _alerts.watchByStatus(AlertStatus.newAlert);
}
