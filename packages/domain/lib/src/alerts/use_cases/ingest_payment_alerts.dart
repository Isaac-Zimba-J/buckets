import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/entities/payment_alert.dart';
import 'package:buckets_domain/src/alerts/policies/duplicate_detector.dart';
import 'package:buckets_domain/src/alerts/policies/sms_parser.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';
import 'package:buckets_domain/src/alerts/ports/payment_alert_source.dart';
import 'package:buckets_domain/src/alerts/value_objects/incoming_alert_text.dart';
import 'package:buckets_domain/src/shared/attempt.dart';
import 'package:buckets_domain/src/shared/date_window.dart';
import 'package:buckets_domain/src/shared/ports/local_time_zone.dart';

/// Pulls captured notifications in, parses them and stores them as alerts,
/// marking duplicates (ARCHITECTURE §6, R-PARSE-2…4).
final class IngestPaymentAlerts {
  /// Creates the use case. [packageSources] maps Android package names to
  /// providers (Open question 2); unknown packages parse with every template.
  const IngestPaymentAlerts({
    required this._source,
    required this._parser,
    required this._alerts,
    required Map<String, AlertSource> packageSources,
    required this._ids,
    required this._zone,
  }) : _packages = packageSources;

  final PaymentAlertSource _source;
  final SmsParser _parser;
  final AlertRepository _alerts;
  final Map<String, AlertSource> _packages;
  final IdGenerator _ids;
  final LocalTimeZone _zone;

  /// The new, non-duplicate alerts, oldest first.
  Future<Result<List<PaymentAlert>>> call() => attempt(() async {
    final fresh = <PaymentAlert>[];
    for (final text in unwrap(await _source.drain())) {
      final alert = unwrap(await _store(text));
      if (alert.status == AlertStatus.newAlert) fresh.add(alert);
    }
    return fresh;
  });

  Future<Result<PaymentAlert>> _store(IncomingAlertText text) =>
      attempt(() async {
        final known = _packages[text.packageName];
        final parsed = _parser.parse(
          text.text,
          utcOffset: _zone.offsetAt(text.receivedAt),
          source: known,
        );
        final alert = unwrap(
          PaymentAlert.create(
            id: _ids.newId(),
            rawText: text.text,
            source: known ?? AlertSource.unknown,
            receivedAt: text.receivedAt,
            parsed: parsed,
          ),
        );
        final reference = parsed.reference;
        final at = parsed.occurredAt ?? text.receivedAt;
        final candidates = reference != null
            ? [?unwrap(await _alerts.findByReference(alert.source, reference))]
            : unwrap(
                await _alerts.getReceivedIn(
                  unwrap(
                    DateWindow.create(
                      at.subtract(const Duration(minutes: 3)),
                      at.add(const Duration(minutes: 3)),
                    ),
                  ),
                ),
              );
        final duplicate = DuplicateDetector.findDuplicate(alert, candidates);
        final stored = duplicate == null
            ? alert
            : unwrap(alert.withStatus(AlertStatus.duplicate));
        unwrap(await _alerts.save(stored));
        return stored;
      });
}
