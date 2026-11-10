import 'package:buckets_core/buckets_core.dart';
import 'package:buckets_domain/src/alerts/ports/alert_repository.dart';

/// Deletes stored raw alert text now (SCREENS 27, R-PRIV-3): the R-PRIV-2
/// 90-day purge, early. Parsed transactions are untouched.
final class ClearAlertHistory {
  /// Creates the use case.
  const new(this._alerts, this._clock);

  final AlertRepository _alerts;
  final Clock _clock;

  /// Clears raw text recorded before now.
  Future<Result<void>> call() => _alerts.clearRawTextBefore(_clock.now());
}
