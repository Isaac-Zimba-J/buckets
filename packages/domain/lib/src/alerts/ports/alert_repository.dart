import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/shared/date_window.dart';

/// Stores payment alerts.
abstract interface class AlertRepository {
  /// The alert with [id], or `NotFoundFailure`.
  Future<Result<PaymentAlert>> get(String id);

  /// Inserts or replaces [alert].
  Future<Result<void>> save(PaymentAlert alert);

  /// The alert from [source] with parsed [reference], if any (R-PARSE-4).
  Future<Result<PaymentAlert?>> findByReference(
    AlertSource source,
    String reference,
  );

  /// Alerts received inside [window], for duplicate checks without a
  /// reference (R-PARSE-4).
  Future<Result<List<PaymentAlert>>> getReceivedIn(DateWindow window);

  /// Clears the raw text of alerts received before [cutoff], keeping the
  /// parsed fields (R-PRIV-2).
  Future<Result<void>> clearRawTextBefore(DateTime cutoff);

  /// Alerts with [status], oldest first, emitting again on change.
  Stream<List<PaymentAlert>> watchByStatus(AlertStatus status);
}
