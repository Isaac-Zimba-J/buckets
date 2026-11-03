import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/value_objects/incoming_alert_text.dart';

/// Payment notifications captured on the phone (ARCHITECTURE §6).
abstract interface class PaymentAlertSource {
  /// Returns and removes every capture queued since the last drain, oldest
  /// first.
  Future<Result<List<IncomingAlertText>>> drain();
}
