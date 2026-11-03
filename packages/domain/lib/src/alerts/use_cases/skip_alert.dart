import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';

/// Leaves an alert unsorted and moves to the next one (screen 18).
final class SkipAlert {
  /// Creates the use case.
  const new(this._alerts);

  final AlertRepository _alerts;

  /// The next unsorted alert after [alertId], or null at the end.
  Future<Result<PaymentAlert?>> call(String alertId) async {
    final unsorted = await _alerts.watchByStatus(AlertStatus.newAlert).first;
    final i = unsorted.indexWhere((a) => a.id == alertId);
    return Ok(i < 0 || i + 1 >= unsorted.length ? null : unsorted[i + 1]);
  }
}
